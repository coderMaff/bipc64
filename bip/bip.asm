// Bip C64 Edition
// 07/05/21 maf created
// 21/05/21 maf got keyboard code working split to own library file
// to do:
//		Keyboard delay needs to be higher
// 		Background, look into charmaps and replacing black background
//		Why does p1 buzz when not moving

// -[ Constants ]---------------------------------------------------------------

#import "..\libs\constants.asm"

.const MAXTHROTTLE = 5
.const MINTHROTTLE = 1

// -[ Begin ]-------------------------------------------------------------------

BasicUpstart2(start)

.pc = $5000 "maincode"

// - import source file_save

.import source "..\libs\input.asm"

.import source "initialise.asm"
.import source "textout.asm"
.import source "handlekeys.asm"
.import source "movesprites.asm"
.import source "drawhud.asm"


// -----------------------------------------------------------------------------

//set screen up
start:
	jsr initialise

mainloop:

// Draw once per screen refresh
waitforraster:
	lda $d012								// Grab raster position
	cmp #208								// Check if its finished drawing play area
	bne waitforraster				// It hasnt

	jsr handlekeys
	jsr movesprites
	jsr drawhud							// Drawing the hud kills keyboard control
	jmp mainloop

end:
	rts

// --[ Variables ]--------------------------------------------------------------

welcome_text:
	.encoding "screencode_upper"
	.text "BIP V20210522 BY MATT BUSHELL"
	.byte $ff

throttle_text0:
	.encoding "screencode_upper"
	.text "THROTTLE:----"
	.byte $ff

throttle_text1:
	.encoding "screencode_upper"
	.text "THROTTLE:----"
	.byte $ff

speed_text0:
	.encoding "screencode_upper"
	.text "SPEED:----"
	.byte $ff

speed_text1:
	.encoding "screencode_upper"
	.text "SPEED:----"
	.byte $ff

vP0Throttle:			// $5215w
	.byte 0

vP0Speed:
	.byte 0

vP0Facing:
	.byte 0

vP0Score:
	.byte 0

vP0LastXPos:
	.byte 0
	.byte 0

vP1Throttle:				// $521b
	.byte 0

vP1Speed:
	.byte 0

vP1Facing:
	.byte 0

vP1Score:
	.byte 0

vP1LastXPos:
	.byte 0
	.byte 1

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
