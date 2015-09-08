module sync_rst (
                 input wire clk,
                 input wire resetn_in,
                 output wire reset,
                 output wire reset_n
                 );

   reg [19:0] cnt;
   reg        rstn0, rstn1;

   reg        srst;

   assign reset = srst;
   assign resetn = ~srst;

   always @(posedge clk)
     begin
        rstn0 = resetn_in;
        rstn1 = rstn0;
     end

   always @(posedge clk)
     begin
        if (rstn1)
          begin
             if (cnt == 0)
               begin
                  cnt = 0;
                  srst = 1'b0;
               end
             else
               begin
                  cnt = cnt - 1;
                  srst = 1'b1;
               end
          end
        else
          begin
             srst = 1'b1;
             cnt = 1000000;
          end
     end

endmodule
