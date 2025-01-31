DDR_A = $6003    ; Port A Data Direction Register (pins)
DDR_B = $6002    ; Port B Data Direction Register
PORT_A = $6001   ; Port A Data Register
PORT_B = $6000   ; Port B Data Register

; LCD control pins (connected to Port A)
LCD_RS = %00100000  
LCD_RW = %01000000  
LCD_E  = %10000000  

; SPI control pins (connected to Port B)
SCK = %00000001  
MOSI = %00000010 
DR = %00000100
CS = %00001000 


LCD_Clear = %00000000  ; LCD Clear command

;;;;;;;;;;;;;;;;;;;;;;;;;
  .org $8000  
  lda #$ff  ; Set all pins on Port B to output
  sta DDR_B 

  lda $6000
  sta DDR_B

  lda #%11100000  ; Set top 3 pins on Port A to output (LCD control)
  sta DDR_A 

;;;;;;;;;;;;;;;;;;;;;;;;;

	lda #CS
	sta PORT_B

	; bit bang 01 in SPI

	lda #0
	sta PORT_B
	lda #SCK
	sta PORT_B

	lda #MOSI
	sta PORT_B
	lda #(SCK|MOSI)
	sta PORT_B
 
loop:
  jmp loop


  .org $fffc  ; Set reset vector
  .word $8000 ; Start address for program
  .word $0000 ; Padding to complete memory
