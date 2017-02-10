
VLOG = iverilog
TOOLCHAIN_PREFIX = /opt/riscv32i/bin/riscv32-unknown-elf-

firmware.hex: firmware.S firmware.c firmware.lds
	$(TOOLCHAIN_PREFIX)gcc -Os -m32 -march=RV32IC -ffreestanding -nostdlib -o firmware.elf firmware.S firmware.c \
		 --std=gnu99 -Wl,-Bstatic,-T,firmware.lds,-Map,firmware.map,--strip-debug -lgcc
	$(TOOLCHAIN_PREFIX)objcopy -O binary firmware.elf firmware.bin
	$(TOOLCHAIN_PREFIX)objdump -d firmware.elf > disasm.S
	python3 makehex.py firmware.bin 1024 > firmware.hex
clean:
	rm -f firmware.elf
	rm -f *.mif
	rm -f firmware.bin firmware.hex

