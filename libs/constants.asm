// --[ Constants ]--------------------------------------------------------------
.const TEXTPOS_L = $00FB
.const TEXTPOS_H = $00FC
.const TEXTTOPRINT_L = $00FD
.const TEXTTOPRINT_H = $00FE

.const SCREEN_RAM	= $0400
.const CURSOR_VISIBLE = $00CC

// Sprite
.const SPRITE_ENABLE = $d015
.const SPRITE_EXTRACOLOR = $d025

.const SPRITE0_XCOORD = $d000
.const SPRITE0_YCOORD = $d001
.const SPRITE1_XCOORD = $d002
.const SPRITE1_YCOORD = $d003

.const SPRITEA_XHB = $d010					// All sprites, high bit for x coord

.const SPRITE0_DATA	= $07f8
.const SPRITE1_DATA	= $07f9

// Keyboard stuff
.const SCNKEY = $FF9F 							// Keyboard
.const GETIN = $FFE4 								// Get Input
