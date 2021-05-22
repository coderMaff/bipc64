// --[ Draw text to screen ]----------------------------------------------------

textout_init:
	ldy #$00

textout_loop:
	lda (TEXTTOPRINT_L),y
	cmp #$ff										// If we hit an $ff weve reached the end of the text
	beq textout_end

	sta (TEXTPOS_L),y						// Same column next row is $0798

	iny
	bne textout_loop						// loop if we are not done yet

textout_end:
	rts
