module ROM (
            input wire         clk,
            input wire         reset,
            input wire [31:0]  haddr,
            input wire         hwrite,
            input wire [2:0]   hsize,
            input wire [2:0]   hburst,
            input wire [3:0]   hprot,
            input wire [1:0]   htrans,
            input wire         hmastlock,
            input wire [31:0]  hwdata,
            output wire [31:0] hrdata,
            input wire         hsel,
            input wire         hreadyin,
            output wire        hreadyout,
            output wire        hresp
            );

   wire [11:0] addr;

   assign hreadyout = 1'b1;
   assign hresp = 1'b0;

   assign addr = {12 {!reset}} & haddr[11:0];

   alt_rom mem(.clock(clk),
               .address(addr),
               .q(hrdata));

endmodule
