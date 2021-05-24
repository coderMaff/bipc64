// ----------------------- Handle keyboard -------------------------------------

handlekeys:
	jsr input_get						// Get keyboard/joystick input

	ldx vInputResult
	cpx #NOINPUT
	bne continue
	jmp nokey
	
continue:
	cpx #KEY_BSP
	bne !skip+
	jmp end

!skip:
	cpx #KEY_W							// If key W is pressed
	bne !skip+

	lda vP0Throttle					// Throttle into acc
	cmp #MAXTHROTTLE				// Compare with max
	bcs !skip+							// Throttle >= max so skip increase
	inc vP0Throttle					// increase the throttle

!skip:
	cpx	#KEY_S							// See if key S is pressed
	bne !skip+

	lda vP0Throttle					// Throttle into acc
	cmp #MINTHROTTLE				// Compare with min
	bcc !skip+							// Throttle < min so skip decrease
	dec vP0Throttle					// decrease throttle

!skip:
	cpx	#KEY_A							// See if key S is pressed
	bne !skip+
	inc vP0Facing						// Incrament facing
	lda vP0Facing						// Check if vP0Facing has gone over 8
	cmp #8
	bcc !afterreset+
	lda #0
	sta vP0Facing
!afterreset:
	lda #$28								// Sprite data is at $0a00 / $40 = $28
	clc
	adc vP0Facing						//  + vP0Facing
	sta SPRITE0_DATA				// Store at sprite 0

!skip:
	cpx	#KEY_D							// See if key S is pressed
	bne !skip+
	dec vP0Facing						// Incrament facing
	lda vP0Facing						// Check if vP0Facing has gone under 0
	cmp #9									// $FF is 1 less than 0 so rest it back to 8
	bcc !afterreset+
	lda #7
	sta vP0Facing
!afterreset:
	lda #$28								// Sprite data is at $0a00 / $40 = $28
	clc
	adc vP0Facing						//  + vP0Facing
	sta SPRITE0_DATA				// Store at sprite 0

!skip:
	cpx #KEY_I							// If key I is pressed
	bne !skip+

	lda vP1Throttle					// Throttle into acc
	cmp #MAXTHROTTLE				// Compare with max
	bcs !skip+							// Throttle >= max so skip increase
	inc vP1Throttle					// increase the throttle

!skip:
	cpx	#KEY_K							// See if key S is pressed
	bne !skip+

	lda vP1Throttle					// Throttle into acc
	cmp #MINTHROTTLE				// Compare with min
	bcc !skip+							// Throttle < max so skip decrease
	dec vP1Throttle					// decrease throttle

!skip:
	cpx	#KEY_J							// See if key S is pressed
	bne !skip+
	inc vP1Facing						// Incrament facing
	lda vP1Facing						// Check if vP0Facing has gone over 8
	cmp #8
	bcc !afterreset+
	lda #0
	sta vP1Facing
!afterreset:
	lda #$34								// Sprite data is at $0a00 / $40 = $28
	clc
	adc vP1Facing						//  + vP0Facing
	sta SPRITE1_DATA				// Store at sprite 0

!skip:
	cpx	#KEY_L							// See if key S is pressed
	bne !skip+
	dec vP1Facing						// Incrament facing
	lda vP1Facing						// Check if vP0Facing has gone under 0
	cmp #9									// $FF is 1 less than 0 so rest it back to 8
	bcc !afterreset+
	lda #7
	sta vP1Facing
!afterreset:
	lda #$34								// Sprite data is at $0a00 / $40 = $28
	clc
	adc vP1Facing						//  + vP0Facing
	sta SPRITE1_DATA				// Store at sprite 0

!skip:

nokey:
	rts
