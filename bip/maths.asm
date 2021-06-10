// --[ Maths ]------------------------------------------------------------------

//Divide by 10 = 17 bytes, 30 cycles

divideby10:
  sta  vTempByte
  lsr
  lsr
  lsr
  adc  vTempByte
  ror
  adc  vTempByte
  ror
  adc  vTempByte
  ror
  lsr
  lsr
  lsr
	rts
