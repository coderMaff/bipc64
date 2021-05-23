// --[ Move sprites ]-----------------------------------------------------------

// to do : instead of analizing these seprately, treat each player as an offert into memory and cycle through twice
//				 need some sort of lookup table

// Player 0
movesprites:
	lda SPRITE0_XCOORD						// Fly right round and round and round
	sta vP0LastXPos
	clc
	adc vP0Throttle								// Add throttle to it
	sta SPRITE0_XCOORD						// Store in $d000 = sprite x pos low bit

	cmp vP0LastXPos
	bcs !skip+										// SPRITE0_XCOORD > vPOLastXPos so no need to set hight bit

	lda SPRITEA_XHB								// Set the high bit
	eor #%00000001
	sta SPRITEA_XHB
	inc vP0LastXPos + 1

!skip:													// Check if we're over 65
	lda vP0LastXPos + 1						// See if were more than 255 across the screen
	cmp #1
	bcc !skip+										// vPOLastXPos + 1 < 1 so no need to check if were past 320 (65)
	lda SPRITE0_XCOORD
	cmp #65
	bcc !skip+										// SPRITE0_XCOORD < 65 so no need to reset x pos to 0
	lda #0
	sta SPRITE0_XCOORD
	sta vP0LastXPos + 1
	lda SPRITEA_XHB								// Unset the high bit
	eor #%00000001
	sta SPRITEA_XHB

!skip:

// Player 1
	lda SPRITE1_XCOORD						// Fly left round and round and round  $511c
	sta vP1LastXPos
	sec														// Set the carry flag
	sbc vP1Throttle								// Subtract the throttle
	sta SPRITE1_XCOORD						// Store in $d000 = sprite x pos low bit

	cmp vP1LastXPos
	bcc !skip+										// SPRITE1_XCOORD < vP1LastXPos so no need to unset hight bit

	lda SPRITEA_XHB								// Swap the high bit
	eor #%00000010
	sta SPRITEA_XHB
	inc vP1LastXPos + 1

	lda SPRITEA_XHB 							// Check if the high bit is now Set
	eor #%00000010								// Only interested by byte 1
	and #%00000010
	bne	!skip+										//
	lda #65												// otherwise overwrite 25x (with 65)
	sta SPRITE1_XCOORD

!skip:
	rts
