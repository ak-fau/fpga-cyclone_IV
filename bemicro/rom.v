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

   reg [31:0] addr;
   reg [31:0] data;

   assign hrdata = data;

   assign hreadyout = 1'b1;
   assign hresp = 1'b0;

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         addr = 32'h00000000;
      end
      else if (clk) begin
         addr = haddr;
      end
   end

   always begin
      case (addr)
        // User mode trap
        32'h00000100:
          data = 32'h1d00006f; // J trap_entry (0x2d0)

        // Supervisor mode trap
        32'h00000140:
          data = 32'h0000006f;

        // Hypervisor mode trap
        32'h00000180:
          data = 32'h0000006f;

        // Machine mode trap
        32'h000001c0:
          data = 32'h1300006f; // j 0x300

        // NMI
        // 32'h000001fc:
        //   data = 32'h00000013; // NOP

        // Reset
        32'h00000200: // reset vector
          data = 32'h2000006f; // j 0x400

        // Trap entry
        32'h000002d0:
          data = 32'h0000006f;

        // LED counter
        32'h00000400:
          data = 32'h00000693;
        32'h00000404:
          data = 32'h800005b7;
        32'h00000408:
          data = 32'h017d8637;
        32'h0000040c:
          data = 32'h00168793;
        32'h00000410:
          data = 32'h0ff7f713;
        32'h00000414:
          data = 32'h00d58023;
        32'h00000418:
          data = 32'h84060793;
        32'h0000041c:
          data = 32'hfff78793;
        32'h00000420:
          data = 32'hfe079ee3;
        32'h00000424:
          data = 32'h00070693;
        32'h00000428:
          data = 32'hfe5ff06f;
        32'h0000042c:
          data = 32'h0000006f;

        default
          data = 32'h00000013; // NOP
      endcase
   end

endmodule
