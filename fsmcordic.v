module fsmcordic#(parameter WIDTH=24)(
    input clk,
    input enable,
    input reg signed [WIDTH-1:0] z,//angulo
    output signed [WIDTH-1:0] x,//coseno del angulo
    output signed [WIDTH-1:0] y//seno del angulo
);
    reg signed [WIDTH-1:0] y_i1;//siguiente iteracion
    reg signed [WIDTH-1:0] x_i1;
    reg [WIDTH-1]arctan;//angulo
    integer [4:0]i;//iteracion
    //reg minuscos;//para guardar el negativo segun el cuadrante
   // reg minussen;
    reg d_sig;//suma o resta

    ROM arctancalc(
        .clk(clk),
        .i(read_addr),
        .arctan(read_data),
    );
    always @* begin
        x = 24'h009B75;//se le agrega la constante para que quede de la longitud corecta, calculada segun el numero de iteraciones
        y = 0;
        d_sig=0;
        z_i1 = 0;
        x_i1 = 0;
        y_i1 = 0;

        if (enable) begin
/* Ahorita suponemos que el angulo esta entre los 90° por lo que no haremos + ni -*/
            for (i = 0; i < 16; i = i + 1) begin
                if (d_sig) begin//cambiamos el simbolo segun si el angulo se paso
                    x_i1 = x+(y_iter >>> i);//como la proxima iteracion depende X de Y, y Y de X primero pasamos todo a una variable temporal
                    y_i1 = y-(x_iter >>> i);
                    z=z+arctan;
                end
                else begin
                    x_i1 = x-(y_iter >>> i);
                    y_i1 = y+(x_iter >>> i);
                    z=z-arctan;//como z solo depende de si misma no se necesita la variable temporal
                end
                x=x_i1;//y despues de calcular todo lo pasamos a los valores reales que se iteraran despues
                y=y_i1;
            end
        end
    end
endmodule
