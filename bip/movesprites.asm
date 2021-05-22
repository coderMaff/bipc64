// ----------------- Move sprites-----------------------------------------------

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
	rts
