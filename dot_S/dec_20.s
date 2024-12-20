DDR_A = $6003 ; this and 
DDR_B = $6002 ; this sets the pin dir to output or input of PORT A and B
PORT_A = $6001 ; this and 
PORT_B = $6000 ; this sets the information to PORT A and B
LCD_RS = %00100000 ; 8ht pin of PORT A is Register select of LCD
LCD_RW = %01000000 ; read/writre enable 
LCD_E =  %10000000 ; LCD enble
LCD_Clear = %00000000

;;;;;;;;;;;;;;;;;;;;;;;;;
  .org $8000  
  lda #$ff  ; #$ff = #%11111111
  sta DDR_B ; Set all pins on port B to output
  lda #%11100000
  sta DDR_A
;;;;;;;;;;;;;;;;;;;;;;;;;
; 4-bit data mode for LCD (To save up some pins in the ports) 
; 0000 - data , 0000 - func
  lda #%00000000
  sta PORT_B

  lda #%00100010
  sta PORT_B
;----------------------
  lda #%00000000
  sta PORT_B

  lda #%00000010
  sta PORT_B
  
  ora #%11100000
  sta PORT_B

  lda #%00000000
  sta PORT_B
;--------------------
  lda #%00000010
  sta PORT_B
  
  ora #%01100000
  sta PORT_B

  lda #%00000000
  sta PORT_B
;--------------------
  lda #%01001010
  sta PORT_B
  
  and #%10001010
  sta PORT_B

  lda #%00000000
  sta PORT_B

loop:
  jmp loop


  .org $fffc
  .word $8000
  .word $0000
