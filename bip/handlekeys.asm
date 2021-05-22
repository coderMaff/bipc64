// ----------------------- Handle keyboard -------------------------------------

handlekeys:
	jsr input_get						// Get keyboard/joystick input

	ldx vInputResult
	cpx #NOINPUT
	beq nokey

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
	bcc !skip+							// Throttle < max so skip decrease
	dec vP0Throttle					// decrease throttle

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

nokey:
	rts
