import sys

if len(sys.argv) != 3:
    print("Usage: python assembler.py output_file_name input_file_name")
    exit(1)


input_file = open(sys.argv[2], 'r')
output_file = open(sys.argv[1], 'w+')

lines = input_file.read().split('\n')

for line in lines:
    if len(line) > 0:
        if "//" in line:
            line = line[:line.index("//")].strip()

        output_file.write(line.replace(',', '') + "\n")
