  .org $8000  

  ; Set DDRs
  lda #$ff          ; Set all pins on PORT_B to output
  sta DDR_B         

  lda #%11100000
  sta DDR_A          ; Set top three pins on PORT A to output and the rest to input

  ; Initialize LCD in 4-bit mode
  lda #%00000001     ; Clear the display
  jsr LCD_inst

  lda #%00111000     ; Set 4-bit mode (only the high nibble is used)
  jsr LCD_inst
  
  lda #%00001110     ; Display on, cursor off, blink off
  jsr LCD_inst

  lda #%00000110     ; Increment cursor, no display shift
  jsr LCD_inst

  ; Print "Murggi Pittu"
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

loop:
  jmp loop

; ---------------------------
; Subroutines
; ---------------------------

; LCD_inst: Sends a command in 4-bit mode
LCD_inst:
  ; Send high nibble (upper 4 bits)
  and #%11110000        ; Mask low nibble (bits 0–3)
  jsr SendNibble         ; Send high nibble

  ; Send low nibble (lower 4 bits)
  asl                    ; Shift bits left (to move low nibble to high)
  asl
  asl
  asl
  and #%11110000        ; Mask high nibble (now low nibble is in the upper 4 bits)
  jsr SendNibble         ; Send low nibble

  rts

; print_char: Sends a character in 4-bit mode
print_char:
  ; Set RS for data (RS=1)
  lda #LCD_RS
  sta PORT_A
  jsr SendNibble         ; Send high nibble of the character
  lda #(LCD_RS | LCD_E)  ; Set RS=1, E=1 (for data)
  sta PORT_A
  lda #LCD_RS           ; Set RS=1 (data), E=0
  sta PORT_A
  jsr SendNibble         ; Send low nibble of the character
  rts

; SendNibble: Sends a single 4-bit nibble to the LCD
SendNibble:
  sta PORT_B            ; Output nibble to PORT_B
  lda #LCD_E            ; Set E=1 (Enable)
  sta PORT_A
  lda #LCD_Clear        ; Clear the control pins
  sta PORT_A
  rts

;;;;;;;;;;;;;;;;;;;;;;;;
  
  .org $fffc
  .word $8000
  .word $0000
