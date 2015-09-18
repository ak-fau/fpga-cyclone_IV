# Create a base clock for the PLL input clock
create_clock -name clk50_in -period 20ns [get_ports CLK_FPGA_50M]

# Create the PLL Output clocks automatically
derive_pll_clocks
