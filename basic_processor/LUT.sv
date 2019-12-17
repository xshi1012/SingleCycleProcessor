module LUT(
    input logic[5:0] lut_index,
    output logic[9:0] jump_addr
);

    logic[9:0] lookup_table[64];
    always_comb jump_addr = lookup_table[lut_index];

    initial begin
        $readmemb("lookup_table.txt", lookup_table);
    end

endmodule