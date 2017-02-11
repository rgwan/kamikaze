#Kamikaze: 

Light-weight RV32IMC core for FPGA or ASIC.

Description:
---------

It realized a RISC-V 32bit core by 4-stage pipeline. It aims to replace Cortex-M3.

Currently is not usable, working in progress.


Goals:
---------

	RISC-V RV32IMC instruction set compatible.

	Maybe add some instruction to enhance it's performance.

	Harvard architecture.

	Small footprint for small FPGA or ASIC.

	AHB-Lite or AXI bus wrapper.

	Debug supported. The debug register will mapped on MMIO(APB interface), and support debug externally from special UART.

License:  
----------

MIT
