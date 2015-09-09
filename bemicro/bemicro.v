module bemicro
  (
   // Clock inputs
   input wire  CLK_FPGA_50M, // CLK 1
   input wire  RX_CLK, //       CLK 4
   input wire  TX_CLK, //       CLK 5
   input wire  P1, //           CLK 12 / Diff CLK 7n
   input wire  P2, //           CLK 13 / Diff CLK 7p
   input wire  P35, //          CLK 14 / Diff CLK 6n
   input wire  P36, //          CLK 15 / Diff CLK 6p

   // Extension connector
   output wire RESET_EXP_N,
   input wire  EXP_PRESENT,
   inout wire  P3,
   inout wire  P4,
   inout wire  P5,
   inout wire  P6,
   inout wire  P7,
   inout wire  P8,
   inout wire  P9,
   inout wire  P10,
   inout wire  P11,
   inout wire  P12,
   inout wire  P13,
   inout wire  P14,
   inout wire  P15,
   inout wire  P16,
   inout wire  P17,
   inout wire  P18,
   inout wire  P19,
   inout wire  P20,
   inout wire  P21,
   inout wire  P22,
   inout wire  P23,
   inout wire  P24,
   inout wire  P25,
   inout wire  P26,
   inout wire  P27,
   inout wire  P28,
   inout wire  P29,
   inout wire  P37,
   inout wire  P38,
   inout wire  P39,
   inout wire  P40,
   inout wire  P41,
   inout wire  P42,
   inout wire  P43,
   inout wire  P44,
   inout wire  P45,
   inout wire  P46,
   inout wire  P47,
   inout wire  P48,
   inout wire  P49,
   inout wire  P50,
   inout wire  P51,
   inout wire  P52,
   inout wire  P53,
   inout wire  P54,
   inout wire  P55,
   inout wire  P56,
   inout wire  P57,
   inout wire  P58,
   inout wire  P59,
   inout wire  P60,

   // SDRAM
   output wire RAM_A0,
   output wire RAM_A1,
   output wire RAM_A2,
   output wire RAM_A3,
   output wire RAM_A4,
   output wire RAM_A5,
   output wire RAM_A6,
   output wire RAM_A7,
   output wire RAM_A8,
   output wire RAM_A9,
   output wire RAM_A10,
   output wire RAM_A11,
   output wire RAM_A12,
   output wire RAM_A13,

   output wire RAM_BA0,
   output wire RAM_BA1,

   output wire RAM_RAS_N,
   output wire RAM_CAS_N,
   output wire RAM_CS_N,
   output wire RAM_WS_N,

   output wire RAM_CKE,
   output wire RAM_CK_N,
   output wire RAM_CK_P,

   output wire RAM_LDM,
   output wire RAM_UDM,

   inout wire RAM_LDQS,
   inout wire RAM_UDQS,

   inout wire RAM_D0,
   inout wire RAM_D1,
   inout wire RAM_D2,
   inout wire RAM_D3,
   inout wire RAM_D4,
   inout wire RAM_D5,
   inout wire RAM_D6,
   inout wire RAM_D7,
   inout wire RAM_D8,
   inout wire RAM_D9,
   inout wire RAM_D10,
   inout wire RAM_D11,
   inout wire RAM_D12,
   inout wire RAM_D13,
   inout wire RAM_D14,
   inout wire RAM_D15,

   // Ethernet

   // MicroSD card
   output wire SD_CLK,
   output wire SD_CMD,
   inout wire  SD_DAT0,
   inout wire  SD_DAT1,
   inout wire  SD_DAT2,
   inout wire  SD_DAT3,

   // SPI to temperature sensor (LM71)
   output wire TEMP_CS_N,
   output wire TEMP_SC,
   output wire TEMP_MOSI,
   input wire  TEMP_MISO,

   // Switches / buttons / LEDs
   input wire  RECONFIG_SW1,
   input wire  RECONFIG_SW2,
   input wire  CPU_RST_N,
   input wire  PBSW_N,

   output wire F_LED0,
   output wire F_LED1,
   output wire F_LED2,
   output wire F_LED3,
   output wire F_LED4,
   output wire F_LED5,
   output wire F_LED6,
   output wire F_LED7
   );

   wire        sysclk;
   wire        sysrst;
   wire        sysrst_n;
   wire [7:0]  led;

   assign RESET_EXP_N = sysrst_n;

   assign F_LED0 = ~led[0];
   assign F_LED1 = ~led[1];
   assign F_LED2 = ~led[2];
   assign F_LED3 = ~led[3];
   assign F_LED4 = ~led[4];
   assign F_LED5 = ~led[5];
   assign F_LED6 = ~led[6];
   assign F_LED7 = ~led[7];

   assign P3 = 1'bZ;
   assign P4 = 1'bZ;
   assign P5 = 1'bZ;
   assign P6 = 1'bZ;
   assign P7 = 1'bZ;
   assign P8 = 1'bZ;
   assign P9 = 1'bZ;

   assign P10 = 1'bZ;
   assign P11 = 1'bZ;
   assign P12 = 1'bZ;
   assign P13 = 1'bZ;
   assign P14 = 1'bZ;
   assign P15 = 1'bZ;
   assign P16 = 1'bZ;
   assign P17 = 1'bZ;
   assign P18 = 1'bZ;
   assign P19 = 1'bZ;

   assign P20 = 1'bZ;
   assign P21 = 1'bZ;
   assign P22 = 1'bZ;
   assign P23 = 1'bZ;
   assign P24 = 1'bZ;
   assign P25 = 1'bZ;
   assign P26 = 1'bZ;
   assign P27 = 1'bZ;
   assign P28 = 1'bZ;
   assign P29 = 1'bZ;

   // assign P35 = 1'bZ;
   // assign P36 = 1'bZ;
   assign P37 = 1'bZ;
   assign P38 = 1'bZ;
   assign P39 = 1'bZ;

   assign P40 = 1'bZ;
   assign P41 = 1'bZ;
   assign P42 = 1'bZ;
   assign P43 = 1'bZ;
   assign P44 = 1'bZ;
   assign P45 = 1'bZ;
   assign P46 = 1'bZ;
   assign P47 = 1'bZ;
   assign P48 = 1'bZ;
   assign P49 = 1'bZ;

   assign P50 = 1'bZ;
   assign P51 = 1'bZ;
   assign P52 = 1'bZ;
   assign P53 = 1'bZ;
   assign P54 = 1'bZ;
   assign P55 = 1'bZ;
   assign P56 = 1'bZ;
   assign P57 = 1'bZ;
   assign P58 = 1'bZ;
   assign P59 = 1'bZ;

   assign P60 = 1'bZ;

   assign SD_CLK  = 1'b0;
   assign SD_CMD  = 1'b0;
   assign SD_DAT0 = 1'bZ;
   assign SD_DAT1 = 1'bZ;
   assign SD_DAT2 = 1'bZ;
   assign SD_DAT3 = 1'bZ;

   // Define open drain output for TEMP_MOSI
   // OPNDRN iTEMP_MOSI_OD (.in(wTEMP_MOSI), .out(TEMP_MOSI));
   assign TEMP_CS_N = 1'b1;
   assign TEMP_SC   = 1'b0;
   assign TEMP_MOSI = 1'b0;

   assign RAM_A0 = 1'b0;
   assign RAM_A1 = 1'b0;
   assign RAM_A2 = 1'b0;
   assign RAM_A3 = 1'b0;
   assign RAM_A4 = 1'b0;
   assign RAM_A5 = 1'b0;
   assign RAM_A6 = 1'b0;
   assign RAM_A7 = 1'b0;
   assign RAM_A8 = 1'b0;
   assign RAM_A9 = 1'b0;
   assign RAM_A10 = 1'b0;
   assign RAM_A11 = 1'b0;
   assign RAM_A12 = 1'b0;
   assign RAM_A13 = 1'b0;

   assign RAM_BA0 = 1'b0;
   assign RAM_BA1 = 1'b0;

   assign RAM_RAS_N = 1'b0;
   assign RAM_CAS_N = 1'b0;
   assign RAM_CS_N = 1'b0;
   assign RAM_WS_N = 1'b0;
   assign RAM_CKE = 1'b0;
   assign RAM_CK_N = 1'b0;
   assign RAM_CK_P = 1'b0;

   assign RAM_LDM = 1'b0;
   assign RAM_UDM = 1'b0;

   assign RAM_LDQS = 1'bZ;
   assign RAM_UDQS = 1'bZ;

   assign RAM_D0 = 1'bZ;
   assign RAM_D1 = 1'bZ;
   assign RAM_D2 = 1'bZ;
   assign RAM_D3 = 1'bZ;
   assign RAM_D4 = 1'bZ;
   assign RAM_D5 = 1'bZ;
   assign RAM_D6 = 1'bZ;
   assign RAM_D7 = 1'bZ;
   assign RAM_D8 = 1'bZ;
   assign RAM_D9 = 1'bZ;
   assign RAM_D10 = 1'bZ;
   assign RAM_D11 = 1'bZ;
   assign RAM_D12 = 1'bZ;
   assign RAM_D13 = 1'bZ;
   assign RAM_D14 = 1'bZ;
   assign RAM_D15 = 1'bZ;

   assign sysclk = CLK_FPGA_50M;

   sync_rst srst(
                 .clk(sysclk),
                 .resetn_in(CPU_RST_N),
                 .reset(sysrst),
                 .reset_n(sysrst_n)
                 );

   zscale_wrapper zs (
                      .clk(sysclk),
                      .reset(sysrst),
                      .led(led)
                      );

endmodule
