// --[ Move sprites ]-----------------------------------------------------------

// to do : instead of analizing these seprately, treat each player as an offert into memory and cycle through twice
//				 need some sort of lookup table
//				 then see bipCalcMovement of original game

// Player 0
movesprites:
	lda SPRITE0_XCOORD									// Fly right round and round and round
	sta vPlayer0 + OFFSET_LASTXPOS
	clc
	adc vPlayer0 + OFFSET_THROTTLE			// Add throttle to it
	sta SPRITE0_XCOORD									// Store in $d000 = sprite x pos low bit
	cmp vPlayer0 + OFFSET_LASTXPOS
	bcs !skip+													// SPRITE0_XCOORD > vPOLastXPos so no need to set hight bit
	lda SPRITEA_XHB											// Set the high bit
	eor #%00000001
	sta SPRITEA_XHB
	inc vPlayer0 + OFFSET_LASTXPOS + 1

!skip:																// Check if we're over 65
	lda vPlayer0 + OFFSET_LASTXPOS + 1	// See if were more than 255 across the screen
	cmp #1
	bcc !skip+													// vPOLastXPos + 1 < 1 so no need to check if were past 320 (65)
	lda SPRITE0_XCOORD
	cmp #65
	bcc !skip+													// SPRITE0_XCOORD < 65 so no need to reset x pos to 0
	lda #0
	sta SPRITE0_XCOORD
	sta vPlayer0 + OFFSET_LASTXPOS + 1
	lda SPRITEA_XHB											// Unset the high bit
	eor #%00000001
	sta SPRITEA_XHB

// Player 1
!skip:
	lda SPRITE1_XCOORD									// Fly left round and round and round  $511c
	sta vPlayer1 + OFFSET_LASTXPOS
	sec																	// Set the carry flag
	sbc vPlayer1 + OFFSET_THROTTLE											// Subtract the throttle
	sta SPRITE1_XCOORD									// Store in $d000 = sprite x pos low bit
	cmp vPlayer1 + OFFSET_LASTXPOS
	beq !skip+													// Hasnt moved so no need to unset high bit
	bcc !skip+													// SPRITE1_XCOORD < vPlayer1 + OFFSET_LASTXPOS so no need to unset hight bit
	lda SPRITEA_XHB											// Swap the high bit
	eor #%00000010
	sta SPRITEA_XHB
	inc vPlayer1 + OFFSET_LASTXPOS + 1
	lda SPRITEA_XHB 										// Check if the high bit is now Set
	eor #%00000010											// Only interested by byte 1
	and #%00000010
	bne	!skip+
	lda #65															// otherwise overwrite 25x (with 65)
	sta SPRITE1_XCOORD

!skip:

//		164		 190		222
//				\		|		/
//					\	|	/
//	128------ + ------- 0
//					/ | \
//				 /	|   \
//			96		64    32
//
// * Sprites facing in different directions traslate facing 0-255 into a direction and sprite
// 1 $0a00 = facing right 				> 238 || >= 0 && <= 16 - Put this last (otherwise this!)

// 2 $0a40 = facing right up 			> 206 && <= 238
// 3 $0a80 = facing up						> 180 && <= 206
// 4 $0ac0 = facing left up				>	144 && <= 180
// 5 $0b00 = facing left					> 112 && <= 144
// 6 $0b40 = facing left down 		>  80 && <= 112
// 7 $0b80 = facing down 					>  48 && <= 80
// 8 $0bc0 = facing right & down 	>  16 && <= 48

rotatesprites:
	lda vPlayer0 + OFFSET_FACING

	cmp #238														// Right Up
	bcs !skip+													// if(vPlayer0 + OFFSET_FACING > 238) jump to skip
	cmp #206
	bcc !skip+													// vPlayer0 + OFFSET_FACING < 206
	ldx #$29														// $0a40 / $40 = $29
	stx SPRITE0_DATA
	jmp rotatefinished

!skip:																// Up
	cmp #206
	bcs !skip+
	cmp #180
	bcc !skip+
	ldx #$2a														// $0a80 / $40 = $2a
	stx SPRITE0_DATA
	jmp rotatefinished

!skip:																// Up Left
	cmp #180
	bcs !skip+
	cmp #144
	bcc !skip+
	ldx #$2b
	stx SPRITE0_DATA
	jmp rotatefinished

!skip:																// Left
	cmp #144
	bcs !skip+
	cmp #112
	bcc !skip+
	ldx #$2c
	stx SPRITE0_DATA
	jmp rotatefinished

!skip:																// Left Down
	cmp #112
	bcs !skip+
	cmp #80
	bcc !skip+
	ldx #$2d
	stx SPRITE0_DATA
	jmp rotatefinished

!skip:																// Down
	cmp #80
	bcs !skip+
	cmp #48
	bcc !skip+
	ldx #$2e
	stx SPRITE0_DATA
	jmp rotatefinished

!skip:																// Down Right
	cmp #48
	bcs !skip+
	cmp #16
	bcc !skip+
	ldx #$2f
	stx SPRITE0_DATA
	jmp rotatefinished

!skip:
	ldx #$28														// Right is the only one left
	stx SPRITE0_DATA

rotatefinished:
	rts
