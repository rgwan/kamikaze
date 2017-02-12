
kamikaze.vcd: tb.vvp
	vvp -n tb.vvp
tb.vvp:	top.v fetch.v tb.v kamikaze.v decode.v riscv_defines.v execute.v compress_decoder.v
	iverilog top.v fetch.v decode.v riscv_defines.v execute.v tb.v kamikaze.v compress_decoder.v -o tb.vvp
clean:
	rm *.vvp *.vcd
