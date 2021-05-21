textout_init:
	ldy #$00
textout_loop:
	lda (TEXTTOPRINT_L),y
	cmp #$ff								// If we hit an $ff weve reached the end of the text
	beq textout_end

	sta $0770,y							// Same column next row is $0798
	sta $078a,y							// ...and store in screen ram near the center

	iny
	bne textout_loop						// loop if we are not done yet

textout_end:
	rts
