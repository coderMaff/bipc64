// --[ Initialise ]-------------------------------------------------------------

initialise:
	lda #BLUE
	sta $d020									// Load into border
	lda #BLUE
	sta $d021 								// Load into main screen

	// clear the screen
	tax												// put accumulator of 0 into x register
	lda #$20									// Space character i.e. blank

	// turn the cursor off
	sta CURSOR_VISIBLE				// Store anything non 0 to hide the cursor

	clearloop:
	sta SCREEN_RAM,x					// x starts at 0 then decreases to FF then FE etc.
	sta $0500,x								// all the way down to 0 again where it...
	sta $0600,x
	sta $0700,x
	dex												// x = x - 1
	bne clearloop							// ...jumps out of the loop

	//set sprites up (0)
	lda #$01 								// sprite multicolor 1
	sta SPRITE_EXTRACOLOR

	lda #$28   							// Sprite data is at $0a00 = $28*$40
	sta SPRITE0_DATA				// Sprite 0

	lda #24 								// Screen is 320x200 ($140x$C8) or ($41+Hihg Bit Setx$c8)
	sta SPRITE0_XCOORD			// x coord low but $d010 is the x coord high bit
	lda #192
	sta SPRITE0_YCOORD			// y coord

	//set sprites up (1)
	lda #$2C   							// Sprite data is at $0b00 = $28*$40
	sta SPRITE1_DATA				// Sprite 1

	lda #$30								// $30 + $FF
	sta SPRITE1_XCOORD			// x coord low but $d010 is the x coord high bit

	lda #%00000010					// Set high bit to get right side of screen
	sta SPRITEA_XHB

	lda #192
	sta SPRITE1_YCOORD			// y coord

	// Turn on sprites 0&1
	lda #%00000011					// Sprite 0 & 1
	sta SPRITE_ENABLE				// Turn on Sprite 0 & 1


	rts
