// Bip C64 Edition
// 07/05/21 maf created
// to do:
//		sprite x gets to 255 x 2 = 510 before going back to zero, should go back to 0 at 320
//    Work out how to set the bits and read just the bits we're interested in
// 		store an x/y coord for text and convert that to offset in text print
//		Keyboard delay needs to be higher
//		adding 2 to throttle is mad fast, why?

// -[ Constants ]---------------------------------------------------------------

#import "..\libs\constants.asm"

.const MAXTHROTTLE = 10
.const MINTHROTTLE = 1

// -[ Begin ]-------------------------------------------------------------------

BasicUpstart2(start)

.pc = $5000 "maincode"

// - import source file_save

.import source "textout.asm"
.import source "..\libs\input.asm"

// -----------------------------------------------------------------------------

//set screen up
start:
	lda #$00									// Black
	sta $d020									// Load black into border
	sta $d021 								// Load black into main screen

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

// Write text to the screen
	lda #<throttle_text
	sta TEXTTOPRINT_L
	lda #>throttle_text
	sta TEXTTOPRINT_H
	jsr textout_init				// Write some screen text

mainloop:

// Draw once per screen refresh
waitforraster:
	lda $d012								// Grab raster position
	cmp #208								// Check if its finished drawing play area
	bne waitforraster				// It hasnt

// Handle keyboard
	jsr input_get						// Get keyboard/joystick input

	ldx vInputResult
	cpx #NOINPUT
	beq !skip+

	cpx #KEY_W							// If key W is pressed
	bne !skip+

	lda vP0Throttle					// Throttle into acc
	cmp #MAXTHROTTLE				// Compare with max
	bcs !skip+							// Throttle >= max so skip increase
	inc vP0Throttle					// increase the throttle

	cpx	#KEY_S							// See if key S is pressed
	bne !skip+

	lda vP0Throttle					// Throttle into acc
	cmp #MINTHROTTLE				// Compare with min
	bcc !skip+							// Throttle < max so skip decrease
	dec vP0Throttle					// decrease throttle


!skip:
	lda SPRITE0_XCOORD			// Fly right round and round and round
	clc
	adc vP0Throttle					// Add throttle to it
	sta SPRITE0_XCOORD			// Store in $d000 = sprite x pos low bit

	bne under255

// - Deal with sprite high bit (x over 255) -THIS IS JUNK WRITE SOME SENSE------
over255:
	lda SPRITEA_XHB					// Load high bit of sprite x pos into accumulator
	bne setzero							// if its not zero set it to zero
	lda #%00000001								// otherwise set it to one
	ora SPRITEA_XHB
	sta $d010
	jmp mainloop

setzero:
	lda #%00000000
	ora SPRITEA_XHB
	sta $d010
	jmp mainloop

under255:
	jmp mainloop

end:
	rts

throttle_text:
	.encoding "screencode_upper"
	.text "THROTTLE"
	.byte $ff

speed_text:
	.encoding "screencode_upper"
	.text "SPEED"
	.byte $ff

// $0801-$9FFF Memory we can use

vP0Throttle:
	.byte 0

vP1Throttle:
	.byte 0

vP0Score:
	.byte 0

vP1Score:
	.byte 0


// sprite 0 / singlecolor / color: $01
*=$0a00
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %01110000,%01111111,%11111000
	.byte %11110000,%00111111,%11110000
	.byte %11110000,%00000000,%00000000
	.byte %11111000,%00000000,%00000000
	.byte %11111111,%11111111,%11111110
	.byte %11111111,%11111111,%11111111
	.byte %01111111,%11111111,%11111111
	.byte %01111111,%11111111,%11111110
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00011000,%00000000
	.byte %00000000,%00111100,%00000000

// sprite 1 / singlecolor
*=$0b00
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00011111,%11111110,%00001110
	.byte %00001111,%11111100,%00001111
	.byte %00000000,%00000000,%00001111
	.byte %00000000,%00000000,%00011111
	.byte %01111111,%11111111,%11111111
	.byte %11111111,%11111111,%11111111
	.byte %11111111,%11111111,%11111110
	.byte %01111111,%11111111,%11111110
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00000000,%00000000
	.byte %00000000,%00011000,%00000000
	.byte %00000000,%00111100,%00000000
