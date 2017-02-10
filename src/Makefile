
kamikaze.vcd: tb.vvp
	vvp -n tb.vvp
tb.vvp:	top.v fetch.v tb.v kamikaze.v
	iverilog top.v fetch.v tb.v kamikaze.v -o tb.vvp
