DDR_A = $6003 ; this and 
DDR_B = $6002 ; this sets the pin dir to output or input of PORT A and B
PORT_A = $6001 ; this and 
PORT_B = $6000 ; this sets the information to PORT A and B
LCD_RS = %00100000 ; 8ht pin of PORT A is Register select of LCD
LCD_RW = %01000000 ; read/writre enable 
LCD_E =  %10000000 ; LCD enble
LCD_Clear = %00000000 ; use when you need to clear all the info in the pins

;;;;;;;;;;;;;;;;;;;;;;;;;
  .org $8000  
  lda #$ff  ; #$ff = #%11111111
  sta DDR_B ; Set all pins on port B to output

  lda #%11100000
  sta DDR_A ; Set top three pins on port A to output and rest to input
;;;;;;;;;;;;;;;;;;;;;;;;;
  ;jsr LCD_init ; jump to "lcd_init" subroutine -- initilizes the LCD
  lda #%00000001 ; inst to clear 
; clears all the info and resets the display
  jsr LCD_inst

  lda #%00111000 ; inst code to set 8-bit op in LCD
  ; sets 8-bit opertaion mode from the LCD display
  jsr LCD_inst
  
  lda #%00001110 ; inst to turn the diaply and curser amd blink
  jsr LCD_inst

  lda #%00000110 ; Increment and shift cursor; don't shift display
  jsr LCD_inst

  lda #"M"
  jsr print_char
  lda #"u"
  jsr print_char
  lda #"r"
  jsr print_char
  lda #"g"
  jsr print_char
  lda #"g"
  jsr print_char
  lda #"i"
  jsr print_char
  lda #" "
  jsr print_char
  lda #"P"
  jsr print_char
  lda #"i"
  jsr print_char
  lda #"t"
  jsr print_char
  lda #"t"
  jsr print_char
  lda #"u"
  jsr print_char


;LCD_init:
 ; lda #%00000001 ; inst to clear 
; clears all the info and resets the display
  ;jsr LCD_inst

  ;lda #%00111000 ; inst code to set 8-bit op in LCD
  ; sets 8-bit opertaion mode from the LCD display
 ; jsr LCD_inst
  
  ;lda #%00001110 ; inst to turn the diaply and curser amd blink
  ;jsr LCD_inst

 ; lda #%00000110 ; Increment and shift cursor; don't shift display
  ;jsr LCD_inst
  ;rts    ; returm to subroutine

loop:
  jmp loop


LCD_inst:
  sta PORT_B
  lda #LCD_Clear
  sta PORT_A
  lda #LCD_E
  sta PORT_A
  lda #LCD_Clear
  sta PORT_A
  rts

print_char:
  sta PORT_B
  lda #LCD_RS
  sta PORT_A
  lda #(LCD_RS | LCD_E)
  sta PORT_A
  lda #LCD_RS
  sta PORT_A
  rts

;;;;;;;;;;;;;;;;;;;;;;;;
  
  .org $fffc
  .word $8000
  .word $0000