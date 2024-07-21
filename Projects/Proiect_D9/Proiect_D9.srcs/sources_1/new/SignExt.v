module SignExt(
        input [15:0] IN,
        input EXTOP, // bitul de semn pentru extindere
        output [31:0] OUT        
);

    assign OUT = {{16{EXTOP}}, IN};

endmodule