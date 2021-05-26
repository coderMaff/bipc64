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
	dec vP0Facing						// Incrament facing
	dec vP0Facing
	dec vP0Facing

!skip:
	cpx	#KEY_D							// See if key D is pressed
	bne !skip+
	inc vP0Facing						// Incrament facing
	inc vP0Facing
	inc vP0Facing

!skip:
	cpx #KEY_I							// If key I is pressed
	bne !skip+

	lda vP1Throttle					// Throttle into acc
	cmp #MAXTHROTTLE				// Compare with max
	bcs !skip+							// Throttle >= max so skip increase
	inc vP1Throttle					// increase the throttle

!skip:
	cpx	#KEY_K							// See if key K is pressed
	bne !skip+

	lda vP1Throttle					// Throttle into acc
	cmp #MINTHROTTLE				// Compare with min
	bcc !skip+							// Throttle < max so skip decrease
	dec vP1Throttle					// decrease throttle

!skip:
	cpx	#KEY_J							// See if key J is pressed
	bne !skip+
	dec vP1Facing						// Incrament facing
	dec vP1Facing
	dec vP1Facing

!skip:
	cpx	#KEY_L							// See if key L is pressed
	bne !skip+
	inc vP1Facing						// Incrament facing
	inc vP1Facing
	inc vP1Facing	

!skip:

nokey:
	rts
