/* Quartus II 64-Bit Version 15.0.1 Build 150 06/03/2015 SJ Web Edition */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Cfg)
		Device PartName(EP4CE22) Path("./output_files/") File("bemicro.jic") MfrSpec(OpMask(1) SEC_Device(EPCS16) Child_OpMask(1 3));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;
