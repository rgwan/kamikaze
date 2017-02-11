
kamikaze.vcd: tb.vvp
	vvp -n tb.vvp
tb.vvp:	top.v fetch.v tb.v kamikaze.v decode.v
	iverilog top.v fetch.v decode.v tb.v kamikaze.v -o tb.vvp
clean:
	rm *.vvp *.vcd
