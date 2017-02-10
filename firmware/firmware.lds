SECTIONS {
	.memory : {
		. = 0x0000000; /* due to TD v3.0.987 bug */
		*(.init);
		*(.text);
		*(*);
		. = ALIGN(4);
		end = .;
	}
}

