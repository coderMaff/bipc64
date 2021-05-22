// --[ Draw Hud ]---------------------------------------------------------------

.const POS_TITLE = $0405
.const POS_SPEED0 = $0773
.const POS_SPEED1 = $078B
.const POS_THROTTLE0 = $0798
.const POS_THROTTLE1 = $07B0

drawhud:
// Title
	lda #<POS_TITLE
	sta TEXTPOS_L
	lda #>POS_TITLE
	sta TEXTPOS_H
	lda #<welcome_text
	sta TEXTTOPRINT_L
	lda #>welcome_text
	sta TEXTTOPRINT_H
	jsr textout_init

// Speed Player 0
	lda #<POS_SPEED0
	sta TEXTPOS_L
	lda #>POS_SPEED0
	sta TEXTPOS_H
	lda #<speed_text0
	sta TEXTTOPRINT_L
	lda #>speed_text0
	sta TEXTTOPRINT_H
	jsr textout_init

// Speed Player 1
	lda #<POS_SPEED1
	sta TEXTPOS_L
	lda #>POS_SPEED1
	sta TEXTPOS_H
	lda #<speed_text1
	sta TEXTTOPRINT_L
	lda #>speed_text1
	sta TEXTTOPRINT_H
	jsr textout_init

// Throttle Player 0
	lda #<POS_THROTTLE0
	sta TEXTPOS_L
	lda #>POS_THROTTLE0
	sta TEXTPOS_H
	lda #<throttle_text0
	sta TEXTTOPRINT_L
	lda #>throttle_text0
	sta TEXTTOPRINT_H
	jsr textout_init

// Throttle Player 1
	lda #<POS_THROTTLE1
	sta TEXTPOS_L
	lda #>POS_THROTTLE1
	sta TEXTPOS_H
	lda #<throttle_text1
	sta TEXTTOPRINT_L
	lda #>throttle_text1
	sta TEXTTOPRINT_H
	jsr textout_init

	rts

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
