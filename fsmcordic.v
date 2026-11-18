module fsmcordic#(parameter WIDTH=24)(
    input clk,
    input enable,
    input reg signed [WIDTH-1:0] z,
    output signed [WIDTH-1:0] x,
    output signed [WIDTH-1:0] y
);
    reg signed [WIDTH-1:0] y_i1;
    reg signed [WIDTH-1:0] x_i1;
    reg signed [WIDTH-1:0] z_i1;
    reg [WIDTH-1]arctan;
    integer [4:0]i;
    reg minuscos;
    reg minussen;

    ROM arctancalc(
        .clk(clk),
        .i(read_addr),
        .arctan(read_data),
    );
    always @* begin
        x = 24'h009B75;
        y = 0;
        z_i1 = 0;
        x_i1 = 0;
        y_i1 = 0;

        if (enable) begin
/* Ahorita suponemos que el angulo esta entre los 90° por lo que no haremos + ni -
*/
            for (i = 0; i < 16; i = i + 1) begin
                x_shift = x_iter >>> i;
                y_shift = y_iter >>> i;

                if (y_iter > 25'sd0) begin
                    x_iter = x_iter + y_shift;
                    y_iter = y_iter - x_shift;
                    z_iter = z_iter + $signed(atan_rom[i]);
                end else if (y_iter < 25'sd0) begin
                    x_iter = x_iter - y_shift;
                    y_iter = y_iter + x_shift;
                    z_iter = z_iter - $signed(atan_rom[i]);
                end
            end

            z = z_iter;
        end
    end
endmodule