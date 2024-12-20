DDR_A = $6003 ; this and 
DDR_B = $6002 ; this sets the pin dir to output or input of PORT A and B
PORT_A = $6001 ; this and 
PORT_B = $6000 ; this sets the information to PORT A and B
LCD_RS = %00100000 ; 8ht pin of PORT A is Register select of LCD
LCD_RW = %01000000 ; read/writre enable 
LCD_E =  %10000000 ; LCD enble
LCD_Clear = %00000000 ; use when you need to clear all the info in the pins


  .org $8000  
  lda #$ff  ; #$ff = #%11111111
  sta DDR_B ; Set all pins on port B to output

  lda #%11100000
  sta DDR_A ; Set top three pins on port A to output and rest to input

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  lda #%00000001 ; inst to clear 
  sta PORT_B ; clears all the info and resets the display
  lda #LCD_Clear
  sta PORT_A
  lda #LCD_E
  sta PORT_A
  lda #LCD_Clear
  sta PORT_A

  lda #%00111000 ; inst code to set 8-bit op in LCD
  sta PORT_B ; sets 8-bit opertaion mode from the LCD display
  lda #LCD_Clear
  sta PORT_A
  lda #LCD_E
  sta PORT_A
  lda #LCD_Clear
  sta PORT_A
  
  lda #%00001110 ; inst to turn the diaply and curser amd blink
  sta PORT_B
  lda #LCD_Clear
  sta PORT_A
  lda #LCD_E
  sta PORT_A
  lda #LCD_Clear
  sta PORT_A

  lda #%00000110 ; Increment and shift cursor; don't shift display
  sta PORT_B
  lda #LCD_Clear
  sta PORT_A
  lda #LCD_E
  sta PORT_A
  lda #LCD_Clear
  sta PORT_A

  lda #"H"
  sta PORT_B
  lda #LCD_RS
  sta PORT_A
  lda #(LCD_RS | LCD_E)
  sta PORT_A
  lda #LCD_RS
  sta PORT_A

  lda #"O"
  sta PORT_B
  lda #LCD_RS
  sta PORT_A
  lda #(LCD_RS | LCD_E)
  sta PORT_A
  lda #LCD_RS
  sta PORT_A
  lda #"L"
  sta PORT_B
  lda #LCD_RS
  sta PORT_A
  lda #(LCD_RS | LCD_E)
  sta PORT_A
  lda #LCD_RS
  sta PORT_A

  lda #"L"
  sta PORT_B
  lda #LCD_RS
  sta PORT_A
  lda #(LCD_RS | LCD_E)
  sta PORT_A
  lda #LCD_RS
  sta PORT_A

  lda #"O"
  sta PORT_B
  lda #LCD_RS
  sta PORT_A
  lda #(LCD_RS | LCD_E)
  sta PORT_A
  lda #LCD_RS
  sta PORT_A

  lda #" "
  sta PORT_B
  lda #LCD_RS
  sta PORT_A
  lda #(LCD_RS | LCD_E)
  sta PORT_A
  lda #LCD_RS
  sta PORT_A

  lda #"W"
  sta PORT_B
  lda #LCD_RS
  sta PORT_A
  lda #(LCD_RS | LCD_E)
  sta PORT_A
  lda #LCD_RS
  sta PORT_A

  lda #"O"
  sta PORT_B
  lda #LCD_RS
  sta PORT_A
  lda #(LCD_RS | LCD_E)
  sta PORT_A
  lda #LCD_RS
  sta PORT_A

  lda #"R"
  sta PORT_B
  lda #LCD_RS
  sta PORT_A
  lda #(LCD_RS | LCD_E)
  sta PORT_A
  lda #LCD_RS
  sta PORT_A

  lda #"L"
  sta PORT_B
  lda #LCD_RS
  sta PORT_A
  lda #(LCD_RS | LCD_E)
  sta PORT_A
  lda #LCD_RS
  sta PORT_A

  lda #"D"
  sta PORT_B
  lda #LCD_RS
  sta PORT_A
  lda #(LCD_RS | LCD_E)
  sta PORT_A
  lda #LCD_RS
  sta PORT_A


loop:
  jmp loop

  .org $fffc  ;since 6502 starts reading from fffc and fffd
  .word $8000 ; reset is set to start from $8000 look at line 11 to understand 
  .word $0000 ; serves as padding because the last two bytes are unfilles and should be filled to compleate all 32768 bytes
  ; only then you can successfully upload on to the eeprom if not it is not possible.