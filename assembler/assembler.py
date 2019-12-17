import sys

opcodes = {
    "add": "000",
    "mov": "001",
    "csl": "010",
    "csr": "010",
    "lw": "011",
    "sw": "100",
    "xor": "101",
    "and": "110",
    "bne": "111",
    "halt": "010",
    "jump": "dummy"
}

labels = {}

if len(sys.argv) != 3:
    print("Usage: python assembler.py output_file_name input_file_name")
    exit(1)


input_file = open(sys.argv[2], 'r')
lines = input_file.read().split('\n')
lut_file = open('lookup_table.txt', 'w+')

line_count = 0
label_count = 0
for line in lines:
    if ":" in line:
        labels[line.strip().split(":")[0]] = "{0:09b}".format(label_count)
        lut_address = "{0:010b}".format(line_count)

        lut_file.write(lut_address + "\n")

        label_count += 1
        if (label_count >= 64):
            input_file.close()
            lut_file.close()
            print("You have more than 64 labels, which this processor does not support")
            sys.exit()
    
    line_count += 1


output_file = open(sys.argv[1], 'w+')
for line in lines:
    input_line = line.lower()
    if ":" in line:
        input_line = line.split(":")[1].strip().lower()
    
    if len(input_line) == 0:
        continue

    opcode = ""
    rt = ""
    rs = ""

    inputs = input_line.split()
    key = inputs[0]

    print(inputs)
    opcode = opcodes[key]
    if key in ["add", "lw", "sw", "and", "xor", "bne"]:
        rt = "{0:03b}".format(int(inputs[1][1]))
        rs = "{0:03b}".format(int(inputs[2][1]))
    elif key == "mov":
        rt = "{0:03b}".format(int(inputs[1][1]))
        rs = "{0:03b}".format(int(inputs[2]))
    elif key == "csl":
        rt = "{0:03b}".format(int(inputs[1][1]))
        func = "0"
        imm = "{0:02b}".format(int(inputs[2]))
        rs = func + imm
    elif key == "csr":
        rt = "{0:03b}".format(int(inputs[1][1]))
        func = "1"
        imm = "{0:02b}".format(int(inputs[2]))
        rs = func + imm
    elif key == "halt":
        rt = "000"
        rs = "000"
    elif key == "jump":
        address = labels[inputs[1]]
        opcode = address[0:3]
        rt = address[3:6]
        rs = address[6:9]

    output_line = opcode + rt + rs + "\n"
    output_file.write(output_line)

output_file.close()
input_file.close()
lut_file.close()