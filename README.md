#Kamikaze: 

Light-weight RV32IMC core for FPGA or ASIC.

Description:
---------

It realized a RISC-V 32bit core by 4-stage pipeline. It aims to replace Cortex-M3.

Currently is not usable, working in progress.


Goals:
---------

	RISC-V RV32IMC instruction set compatible.

	I will add some instruction to enhance it's performance, if I have enough time working onm it.

	Harvard architecture which features I-bus and D-bus.

	Small footprint for small FPGA or ASIC.

	AHB-Lite or AXI bus wrapper.

	Debug supported. The debug register will mapped on MMIO(APB interface), and support debug externally from special UART.

Authors:
----------

Zhiyuan Wan

License:  
----------

MIT

