module ROM#(parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 8)(
    input  clk,
    input  [ADDR_WIDTH-1:0] read_addr,
    output reg [DATA_WIDTH-1:0] read_data
);
    // Banco de 32 registros de DATA_WIDTH bits
    reg [DATA_WIDTH-1:0] rom [(2**ADDR_WIDTH)-1:0];
    
    initial begin
        $readmemh("rom_data.txt", rom);
    end

    always @(posedge clk) begin
        read_data <= rom[read_addr];
    end
endmodule