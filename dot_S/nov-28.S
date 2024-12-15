  .org $8000 ;indicating that the next inst starts from address 8000 on 6502

;initiating all pins of PORT B in 6522 adaptor
reset:
  lda #$ff   ; loads 11111111 into A register
  sta $6002  ; Stores 11111111 at address 6002, 
 
; in this case when $6002 is set to a specific hexcode, the adaptor chip is activated (6522) -
; -Based on the Hexcode the 6522 performs the operation. In this case 6002 indicates that PORT B of 6522 is active (Data Direction Register
; of PORT B) and set to output.
; what ever is stored in 6002; 1 indiactes that pin is output, 0 indicates that pin is input 
; if lda is 11100000 top three pins are set as outputs and the rest 5 pins are set to inputs

; now to what data to transmit or recivce data from this port, lets say hexcode 50 to set out 
  lda #$50   ; loads 50 hex code into registes A
  sta $6000  ; stores 50 at address 6000 indicating that output/input to PORT B pins (inthis case PORT B DDR is initiated yo OUTPUT) 

  ; $6001 indiactes output/input to PORT A based on what is set at $6003  (Data Direction Regiated of PORT A)

;so finally

;Step 1
  ; initiating all pins of PORT A pins to output 
   lda #$ff
   sta $6003
;Step 2
  ; giving info to all pins at PORT A
  lda #$55
  sta $6001

  .org $fffc  ; since 6502 starts reading from fffc and fffd
  .word reset ; reset is set to start from $8000 look at line 1 to understand 
  .word $0000 ; serves as padding because the last two bytes are unfilles and should be filled to compleate all 32768 bytes
  ; only then you can successfully upload on to the eeprom if now it is not possible.
  

