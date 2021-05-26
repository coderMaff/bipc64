// Keyboard / Joystick scan routines

.const KEYPRESSED  = $cb
.const INPUTDELAY = 2
.const NOINPUT = 253

.const KEY_DEL = 0
.const KEY_RTN = 1
.const KEY_L_R = 2
.const KEY_F78 = 3
.const KEY_F12 = 4
.const KEY_F34 = 5
.const KEY_F56 = 6
.const KEY_U_D = 7
.const KEY_3 = 8
.const KEY_W = 9
.const KEY_A = 10
.const KEY_4 = 11
.const KEY_Z = 12
.const KEY_S = 13
.const KEY_E = 14
//.const UNUSED = 15
.const KEY_5 = 16
.const KEY_R = 17
.const KEY_D = 18
.const KEY_6 = 19
.const KEY_C = 20
.const KEY_F = 21
.const KEY_T = 22
.const KEY_X = 23
.const KEY_7 = 24
.const KEY_Y = 25
.const KEY_G = 26
.const KEY_8 = 27
.const KEY_B = 28
.const KEY_H = 29
.const KEY_U = 30
.const KEY_V = 31
.const KEY_9 = 32
.const KEY_I = 33
.const KEY_J = 34
.const KEY_0 = 35
.const KEY_M = 36
.const KEY_K = 37
.const KEY_O = 38
.const KEY_N = 39
.const KEY_PLS = 40
.const KEY_P = 41
.const KEY_L = 42
.const KEY_MIN = 43
.const KEY_GT = 44
.const KEY_OB = 45
.const KEY_AT = 46
.const KEY_LT = 47
.const KEY_PND = 48
.const KEY_STR = 49
.const KEY_CB = 50
.const KEY_CLR = 51
//.const UNUSED = 52
.const KEY_EQ = 53
.const KEY_UP = 54
.const KEY_QST = 55
.const KEY_1 = 56
.const KEY_BSP = 57
//.const UNUSED = 58
.const KEY_2 = 59
.const KEY_SPC = 60
//.const UNUSED = 61
.const KEY_Q = 62
.const KEY_RUN = 63
.const KEY_NONE = 64




input_get:
	jsr input_key
	lda vInputResult
	cmp #NOINPUT
	bne !skip+
	//jsr input_joy
!skip:
	rts

input_key:
	lda KEYPRESSED										// Get the key
	cmp vPreviousKey 									// Is it the same as last time?
	bne !skip+												// No, dont delay

	dec vKeyDelayCounter								// Key is the same, wait a bit
	beq !skip+
	lda #NOINPUT
	sta vInputResult
	rts

!skip:
	// restore key delay counter
	ldx #INPUTDELAY
	stx vKeyDelayCounter
	sta vPreviousKey

	cmp #KEY_NONE
	bne !skip+
	lda #NOINPUT
	sta vInputResult

!skip:
	sta vInputResult
	rts

// Variables

vInputResult:
	.byte 0

vKeyDelayCounter:
	.byte INPUTDELAY

vPreviousKey:
	.byte NOINPUT
