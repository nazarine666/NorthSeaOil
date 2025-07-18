!source "common.asm"

;*=$c700

;  sei
;  lda #50   ; 0011 0010 
;  sta 01
;  jsr SPRITE_MENU_START
;  lda #55   ; 0011 0111
;  sta 01
;  cli
;  rts
;  nop

MENU_COUNT                  = SPRITE_MENU_MENU_COUNT   ; poke here to set menu size
MENU_INDEX                  = SPRITE_MENU_MENU_INDEX   ; Here is where the index will be stored at end

SPRITE_X_OFFSET             = 88    ; Changing this involves changing MSB Sprite
SPRITE_Y_OFFSET             = 140
SPRITE_COLOUR               = 1
SPRITE_WRITE_BLOCK          = 32
SPRITE_MEMORY_LOCATION_BASE = $c000+(64*SPRITE_WRITE_BLOCK)

STRING_LINE_MAX_LENGTH      = 24    ; Max length of a string


STRING_LINE_STORAGE         = $340  ; String gets stored here during write

JOYSTICK_LEFT=4
JOYSTICK_RIGHT=8
JOYSTICK_UP=1
JOYSTICK_DOWN=2
JOYSTICK_FIRE=16

START_OF_VARIABLE_STORAGE_AREA  = $2d
START_OF_VARIABLE_STORAGE_AREA_MSB=START_OF_VARIABLE_STORAGE_AREA+1
START_OF_VARIABLE_STORAGE_AREA_LSB=START_OF_VARIABLE_STORAGE_AREA

START_OF_ARRAY_STORAGE_AREA     = $2f
START_OF_ARRAY_STORAGE_AREA_MSB=START_OF_ARRAY_STORAGE_AREA+1
START_OF_ARRAY_STORAGE_AREA_LSB=START_OF_ARRAY_STORAGE_AREA

WORKING_VARIABLE_ADDRESS=$ae
WORKING_VARIABLE_ADDRESS_LSB=WORKING_VARIABLE_ADDRESS
WORKING_VARIABLE_ADDRESS_MSB=WORKING_VARIABLE_ADDRESS+1

STRING_FOUND_LENGTH=SPRITE_MENU_STRING_FOUND_LENGTH
STRING_FOUND_ADDRESS=SPRITE_MENU_STRING_FOUND_ADDRESS
STRING_FOUND_ADDRESS_LSB=STRING_FOUND_ADDRESS
STRING_FOUND_ADDRESS_MSB=STRING_FOUND_ADDRESS+1


SPRITE_0_MEMORY_LOCATION_BASE =SPRITE_MEMORY_LOCATION_BASE+(64*0)+(3*3)
SPRITE_1_MEMORY_LOCATION_BASE =SPRITE_MEMORY_LOCATION_BASE+(64*1)+(3*3)
SPRITE_2_MEMORY_LOCATION_BASE =SPRITE_MEMORY_LOCATION_BASE+(64*2)+(3*3)
SPRITE_3_MEMORY_LOCATION_BASE =SPRITE_MEMORY_LOCATION_BASE+(64*3)+(3*3)
SPRITE_4_MEMORY_LOCATION_BASE =SPRITE_MEMORY_LOCATION_BASE+(64*4)+(3*3)
SPRITE_5_MEMORY_LOCATION_BASE =SPRITE_MEMORY_LOCATION_BASE+(64*5)+(3*3)
SPRITE_6_MEMORY_LOCATION_BASE =SPRITE_MEMORY_LOCATION_BASE+(64*6)+(3*3)
SPRITE_7_MEMORY_LOCATION_BASE =SPRITE_MEMORY_LOCATION_BASE+(64*7)+(3*3)
CHARACTER_ROM_BASE          =$d000



*=SPRITE_MENU_PROGRAM_START
SPRITE_MENU_START
jmp START
EOR_BYTE    !byte $ff
VARIABLE_NAME_1 !byte 0
VARIABLE_NAME_2 !byte 0
ARRAY_BASE_ADDRESS  !word 0
ARRAY_BASE_ADDRESS_LSB=ARRAY_BASE_ADDRESS
ARRAY_BASE_ADDRESS_MSB=ARRAY_BASE_ADDRESS+1
ARRAY_SIZE !byte 0
NEXT_ARRAY_ADDRESS  !word 0
NEXT_ARRAY_ADDRESS_LSB=NEXT_ARRAY_ADDRESS
NEXT_ARRAY_ADDRESS_MSB=NEXT_ARRAY_ADDRESS+1
ARRAY_ELEMENT_ADDRESS !word 0
ARRAY_ELEMENT_ADDRESS_LSB=ARRAY_ELEMENT_ADDRESS
ARRAY_ELEMENT_ADDRESS_MSB=ARRAY_ELEMENT_ADDRESS+1

SPRITE_ADDRESS_LSB_LOOKUP_LINE_0
  !byte <(SPRITE_0_MEMORY_LOCATION_BASE+0)
  !byte <(SPRITE_0_MEMORY_LOCATION_BASE+1)
  !byte <(SPRITE_0_MEMORY_LOCATION_BASE+2)
  !byte <(SPRITE_1_MEMORY_LOCATION_BASE+0)
  !byte <(SPRITE_1_MEMORY_LOCATION_BASE+1)
  !byte <(SPRITE_1_MEMORY_LOCATION_BASE+2)
  !byte <(SPRITE_2_MEMORY_LOCATION_BASE+0)
  !byte <(SPRITE_2_MEMORY_LOCATION_BASE+1)
  !byte <(SPRITE_2_MEMORY_LOCATION_BASE+2)
  !byte <(SPRITE_3_MEMORY_LOCATION_BASE+0)
  !byte <(SPRITE_3_MEMORY_LOCATION_BASE+1)
  !byte <(SPRITE_3_MEMORY_LOCATION_BASE+2)
  !byte <(SPRITE_4_MEMORY_LOCATION_BASE+0)
  !byte <(SPRITE_4_MEMORY_LOCATION_BASE+1)
  !byte <(SPRITE_4_MEMORY_LOCATION_BASE+2)
  !byte <(SPRITE_5_MEMORY_LOCATION_BASE+0)
  !byte <(SPRITE_5_MEMORY_LOCATION_BASE+1)
  !byte <(SPRITE_5_MEMORY_LOCATION_BASE+2)
  !byte <(SPRITE_6_MEMORY_LOCATION_BASE+0)
  !byte <(SPRITE_6_MEMORY_LOCATION_BASE+1)
  !byte <(SPRITE_6_MEMORY_LOCATION_BASE+2)
  !byte <(SPRITE_7_MEMORY_LOCATION_BASE+0)
  !byte <(SPRITE_7_MEMORY_LOCATION_BASE+1)
  !byte <(SPRITE_7_MEMORY_LOCATION_BASE+2)
SPRITE_ADDRESS_MSB_LOOKUP_LINE_0
  !byte >(SPRITE_0_MEMORY_LOCATION_BASE+0)
  !byte >(SPRITE_0_MEMORY_LOCATION_BASE+1)
  !byte >(SPRITE_0_MEMORY_LOCATION_BASE+2)
  !byte >(SPRITE_1_MEMORY_LOCATION_BASE+0)
  !byte >(SPRITE_1_MEMORY_LOCATION_BASE+1)
  !byte >(SPRITE_1_MEMORY_LOCATION_BASE+2)
  !byte >(SPRITE_2_MEMORY_LOCATION_BASE+0)
  !byte >(SPRITE_2_MEMORY_LOCATION_BASE+1)
  !byte >(SPRITE_2_MEMORY_LOCATION_BASE+2)
  !byte >(SPRITE_3_MEMORY_LOCATION_BASE+0)
  !byte >(SPRITE_3_MEMORY_LOCATION_BASE+1)
  !byte >(SPRITE_3_MEMORY_LOCATION_BASE+2)
  !byte >(SPRITE_4_MEMORY_LOCATION_BASE+0)
  !byte >(SPRITE_4_MEMORY_LOCATION_BASE+1)
  !byte >(SPRITE_4_MEMORY_LOCATION_BASE+2)
  !byte >(SPRITE_5_MEMORY_LOCATION_BASE+0)
  !byte >(SPRITE_5_MEMORY_LOCATION_BASE+1)
  !byte >(SPRITE_5_MEMORY_LOCATION_BASE+2)
  !byte >(SPRITE_6_MEMORY_LOCATION_BASE+0)
  !byte >(SPRITE_6_MEMORY_LOCATION_BASE+1)
  !byte >(SPRITE_6_MEMORY_LOCATION_BASE+2)
  !byte >(SPRITE_7_MEMORY_LOCATION_BASE+0)
  !byte >(SPRITE_7_MEMORY_LOCATION_BASE+1)
  !byte >(SPRITE_7_MEMORY_LOCATION_BASE+2)
SPRITE_ADDRESS_LSB_LOOKUP_LINE_1
  !byte <(SPRITE_0_MEMORY_LOCATION_BASE+0+3*8)
  !byte <(SPRITE_0_MEMORY_LOCATION_BASE+1+3*8)
  !byte <(SPRITE_0_MEMORY_LOCATION_BASE+2+3*8)
  !byte <(SPRITE_1_MEMORY_LOCATION_BASE+0+3*8)
  !byte <(SPRITE_1_MEMORY_LOCATION_BASE+1+3*8)
  !byte <(SPRITE_1_MEMORY_LOCATION_BASE+2+3*8)
  !byte <(SPRITE_2_MEMORY_LOCATION_BASE+0+3*8)
  !byte <(SPRITE_2_MEMORY_LOCATION_BASE+1+3*8)
  !byte <(SPRITE_2_MEMORY_LOCATION_BASE+2+3*8)
  !byte <(SPRITE_3_MEMORY_LOCATION_BASE+0+3*8)
  !byte <(SPRITE_3_MEMORY_LOCATION_BASE+1+3*8)
  !byte <(SPRITE_3_MEMORY_LOCATION_BASE+2+3*8)
  !byte <(SPRITE_4_MEMORY_LOCATION_BASE+0+3*8)
  !byte <(SPRITE_4_MEMORY_LOCATION_BASE+1+3*8)
  !byte <(SPRITE_4_MEMORY_LOCATION_BASE+2+3*8)
  !byte <(SPRITE_5_MEMORY_LOCATION_BASE+0+3*8)
  !byte <(SPRITE_5_MEMORY_LOCATION_BASE+1+3*8)
  !byte <(SPRITE_5_MEMORY_LOCATION_BASE+2+3*8)
  !byte <(SPRITE_6_MEMORY_LOCATION_BASE+0+3*8)
  !byte <(SPRITE_6_MEMORY_LOCATION_BASE+1+3*8)
  !byte <(SPRITE_6_MEMORY_LOCATION_BASE+2+3*8)
  !byte <(SPRITE_7_MEMORY_LOCATION_BASE+0+3*8)
  !byte <(SPRITE_7_MEMORY_LOCATION_BASE+1+3*8)
  !byte <(SPRITE_7_MEMORY_LOCATION_BASE+2+3*8)
SPRITE_ADDRESS_MSB_LOOKUP_LINE_1
  !byte >(SPRITE_0_MEMORY_LOCATION_BASE+0+3*8)
  !byte >(SPRITE_0_MEMORY_LOCATION_BASE+1+3*8)
  !byte >(SPRITE_0_MEMORY_LOCATION_BASE+2+3*8)
  !byte >(SPRITE_1_MEMORY_LOCATION_BASE+0+3*8)
  !byte >(SPRITE_1_MEMORY_LOCATION_BASE+1+3*8)
  !byte >(SPRITE_1_MEMORY_LOCATION_BASE+2+3*8)
  !byte >(SPRITE_2_MEMORY_LOCATION_BASE+0+3*8)
  !byte >(SPRITE_2_MEMORY_LOCATION_BASE+1+3*8)
  !byte >(SPRITE_2_MEMORY_LOCATION_BASE+2+3*8)
  !byte >(SPRITE_3_MEMORY_LOCATION_BASE+0+3*8)
  !byte >(SPRITE_3_MEMORY_LOCATION_BASE+1+3*8)
  !byte >(SPRITE_3_MEMORY_LOCATION_BASE+2+3*8)
  !byte >(SPRITE_4_MEMORY_LOCATION_BASE+0+3*8)
  !byte >(SPRITE_4_MEMORY_LOCATION_BASE+1+3*8)
  !byte >(SPRITE_4_MEMORY_LOCATION_BASE+2+3*8)
  !byte >(SPRITE_5_MEMORY_LOCATION_BASE+0+3*8)
  !byte >(SPRITE_5_MEMORY_LOCATION_BASE+1+3*8)
  !byte >(SPRITE_5_MEMORY_LOCATION_BASE+2+3*8)
  !byte >(SPRITE_6_MEMORY_LOCATION_BASE+0+3*8)
  !byte >(SPRITE_6_MEMORY_LOCATION_BASE+1+3*8)
  !byte >(SPRITE_6_MEMORY_LOCATION_BASE+2+3*8)
  !byte >(SPRITE_7_MEMORY_LOCATION_BASE+0+3*8)
  !byte >(SPRITE_7_MEMORY_LOCATION_BASE+1+3*8)
  !byte >(SPRITE_7_MEMORY_LOCATION_BASE+2+3*8)
START
  jsr HideCharacterROM
  jsr SetupSprites
  jsr RevealCharacterROM
  jsr ClearSpriteMenu
  jsr FindMenuPrompt
  jsr StoreCentredString
  jsr RevealCharacterROM
  lda #0
  jsr DisplaySpriteLine
  ;jsr DisplayPromptString
  jsr HideCharacterROM
  jsr FindMenuChoices
  ; at this point ARRAY_BASE_ADDRESS points to element 0 of the array
  ; default the menu choice to #1
  lda #1
  sta MENU_INDEX
  ; Draw the initial menu choice
ARRAY_ENTRY_LOOP
  jsr FindArrayEntry
  jsr StoreCentredString
  jsr RevealCharacterROM
  lda #1
  jsr DisplaySpriteLine
  ;jsr DisplayChoiceString

  jsr HideCharacterROM    ; need joystick
  ; wait for joystick to be released
JOYSTICK_CLEAR_LOOP
  lda $dc00
  eor #$ff      ;Swap it so bit 1= Pressed instead of 0=pressed
  and #31       ;only interested in lowest 5 bits
  bne JOYSTICK_CLEAR_LOOP

JOYSTICK_USED_LOOP  
  ; At this point joystick has been moved
  lda $dc00
  eor #$ff      ;Swap it so bit 1= Pressed instead of 0=pressed
  and #31       ;only interested in lowest 5 bits
  beq JOYSTICK_USED_LOOP
  tax           ;remember joystick value
  
  and #JOYSTICK_FIRE
  beq NOT_FIRE
  jmp END
NOT_FIRE    
  txa
  and #(JOYSTICK_DOWN + JOYSTICK_LEFT)
  beq NOT_MENU_LESS
  dec MENU_INDEX
  jmp MENU_RATIONALISE
  ; we are pressing either down or right
NOT_MENU_LESS
  inc MENU_INDEX
MENU_RATIONALISE
  lda MENU_INDEX
  bne MENU_RATIONALISE_NOT_ZERO
  lda MENU_COUNT
  sta MENU_INDEX
MENU_RATIONALISE_NOT_ZERO
  lda MENU_INDEX
  clc
  cmp MENU_COUNT
  bcc MENU_RATIONALISE_COMPLETE   ; A < M
  beq MENU_RATIONALISE_COMPLETE   ; A = M
  ; at this point the A register > MENU COUNT
  lda #1
  sta MENU_INDEX
MENU_RATIONALISE_COMPLETE
  jmp ARRAY_ENTRY_LOOP
  
END
    ; tidy up anything at this point
    rts
RevealCharacterROM
  lda $1
  ; turn on character rom (bit 2 = 0)
  and #(255-4)
  sta $1
  rts
  
HideCharacterROM
  ; turn VIC I/O
  lda $1
  ora #4
  sta $1
  rts

SetupSprites
  ; Y Coordinates
  lda #SPRITE_Y_OFFSET
  ldy #1
  clc
SpriteSetupYLoop
  sta $d000,y
  iny
  iny
  cpy #17
  bcc SpriteSetupYLoop

  ; X Coordinates
  lda #SPRITE_X_OFFSET
  clc
  ldx #0
SpriteSetupXLoop
  sta $d000,x
  inx
  inx
  adc #24
  clc
  cpx #16
  bcc SpriteSetupXLoop
  lda #$80;   Last sprite in the MSB
  sta $d010
  
  ; Sprite Colour Setup
  ldx #0
  clc
  lda #SPRITE_COLOUR
SpriteColourLoop
  sta $d027,x
  inx
  cpx #8
  bcc SpriteColourLoop
  
  ; Sprite Priority
  lda #$00
  sta $d01b
  ; Sprite enabled
  lda #$ff
  sta $d015
  
  ; Sprite MOBS
  ; SPRITE_WRITE_BLOCK - Assumed that Sprite MOBS Already set up
  ; not needed here
  rts
  
ClearSpriteMenu
  ; Setup the sprite contents menu initially
  clc
  ldx #0
  lda EOR_BYTE
BLANK_LOOP
  sta SPRITE_MEMORY_LOCATION_BASE,x
  sta SPRITE_MEMORY_LOCATION_BASE+256,x
  inx
  bne BLANK_LOOP
  
  ldx #0
  lda #255
HORIZONTAL_BORDER_LOOP
  sta SPRITE_MEMORY_LOCATION_BASE+(64*0),x
  sta SPRITE_MEMORY_LOCATION_BASE+(64*1),x
  sta SPRITE_MEMORY_LOCATION_BASE+(64*2),x
  sta SPRITE_MEMORY_LOCATION_BASE+(64*3),x
  sta SPRITE_MEMORY_LOCATION_BASE+(64*4),x
  sta SPRITE_MEMORY_LOCATION_BASE+(64*5),x
  sta SPRITE_MEMORY_LOCATION_BASE+(64*6),x
  sta SPRITE_MEMORY_LOCATION_BASE+(64*7),x

  sta SPRITE_MEMORY_LOCATION_BASE+(60+(64*0)),x
  sta SPRITE_MEMORY_LOCATION_BASE+(60+(64*1)),x
  sta SPRITE_MEMORY_LOCATION_BASE+(60+(64*2)),x
  sta SPRITE_MEMORY_LOCATION_BASE+(60+(64*3)),x
  sta SPRITE_MEMORY_LOCATION_BASE+(60+(64*4)),x
  sta SPRITE_MEMORY_LOCATION_BASE+(60+(64*5)),x
  sta SPRITE_MEMORY_LOCATION_BASE+(60+(64*6)),x
  sta SPRITE_MEMORY_LOCATION_BASE+(60+(64*7)),x
  inx
  cpx #3
  bcc HORIZONTAL_BORDER_LOOP

  ldy #3
VERTICAL_LOOP
  lda SPRITE_MEMORY_LOCATION_BASE,y
  ora #128
  sta SPRITE_MEMORY_LOCATION_BASE,y

  lda SPRITE_MEMORY_LOCATION_BASE+2+(64*7),y
  ora #1
  sta SPRITE_MEMORY_LOCATION_BASE+2+(64*7),y
  iny
  iny
  iny
  cpy #(20*3)
  bcc VERTICAL_LOOP  
  
  rts
  

StoreCentredString
  lda #32
  ldy #0
ClearStoredStringAreaLoop
  sta STRING_LINE_STORAGE,y
  iny
  clc
  cpy #STRING_LINE_MAX_LENGTH
  bcc ClearStoredStringAreaLoop
  
  ; Force string to be max length
  clc
  lda STRING_FOUND_LENGTH
  cmp #STRING_LINE_MAX_LENGTH
  bcc StringLengthOK
  lda #STRING_LINE_MAX_LENGTH
  sta STRING_FOUND_LENGTH
StringLengthOK  
  sec
  lda #STRING_LINE_MAX_LENGTH
  sbc STRING_FOUND_LENGTH
  clc
  ror   ; divide by 2
  tax
  ldy #0
  ; x storage offset
  ; y character offset
CharacterCopyLoop
  lda(STRING_FOUND_ADDRESS),y
  and #63
  sta STRING_LINE_STORAGE,x
  inx
  iny
  clc
  cpy STRING_FOUND_LENGTH
  bcc CharacterCopyLoop
  rts
  
;DisplayPromptString
;  ldy #0
;DisplayPromptStringLoop
;  lda STRING_LINE_STORAGE,y
;  sta $0400,y
;  iny
;  clc
;  cpy #STRING_LINE_MAX_LENGTH
;  bcc DisplayPromptStringLoop
;  rts

;DisplayChoiceString
;  ldy #0
;DisplayChoiceStringLoop
;  lda STRING_LINE_STORAGE,y
;  sta $0400+80,y
;  iny
;  clc
;  cpy #STRING_LINE_MAX_LENGTH
;  bcc DisplayChoiceStringLoop
;  rts

FindArrayEntry
!if(FindArrayEntry-SPRITE_MENU_FIND_ARRAY_ENTRY) {
  !ERROR "FindArrayEntry does not match"
}
  ; each entry is 3 bytes (*2 + itself)
  lda ARRAY_BASE_ADDRESS_LSB
  sta ARRAY_ELEMENT_ADDRESS_LSB
  lda ARRAY_BASE_ADDRESS_MSB
  sta ARRAY_ELEMENT_ADDRESS_MSB
  clc
  lda MENU_INDEX
  rol     ; *2
  adc MENU_INDEX
  clc
  adc ARRAY_ELEMENT_ADDRESS_LSB
  sta ARRAY_ELEMENT_ADDRESS_LSB
  bcc ARRAY_ELEMENT_ADDRESS_SKIP
  inc ARRAY_ELEMENT_ADDRESS_MSB
ARRAY_ELEMENT_ADDRESS_SKIP  
  ; ARRAY_ELEMENT_ADDRESS points to element
  lda ARRAY_ELEMENT_ADDRESS_LSB
  sta LOAD_ELEMENT_ADDRESS_LENGTH_LSB
  sta LOAD_ELEMENT_ADDRESS_LSB_LSB
  sta LOAD_ELEMENT_ADDRESS_MSB_LSB

  lda ARRAY_ELEMENT_ADDRESS_MSB
  sta LOAD_ELEMENT_ADDRESS_LENGTH_MSB
  sta LOAD_ELEMENT_ADDRESS_LSB_MSB
  sta LOAD_ELEMENT_ADDRESS_MSB_MSB

  ; Byte #0 = Length
  ; Byte #1 = LSB
  ; Byte #2 = MSB
LOAD_ELEMENT_ADDRESS_LENGTH
LOAD_ELEMENT_ADDRESS_LENGTH_LSB=LOAD_ELEMENT_ADDRESS_LENGTH+1
LOAD_ELEMENT_ADDRESS_LENGTH_MSB=LOAD_ELEMENT_ADDRESS_LENGTH+2
  lda $FFFF
  sta STRING_FOUND_LENGTH
  
  ldx #1
LOAD_ELEMENT_ADDRESS_LSB
LOAD_ELEMENT_ADDRESS_LSB_LSB=LOAD_ELEMENT_ADDRESS_LSB+1
LOAD_ELEMENT_ADDRESS_LSB_MSB=LOAD_ELEMENT_ADDRESS_LSB+2
  lda $FFFF,x
  sta STRING_FOUND_ADDRESS_LSB
  
  inx
LOAD_ELEMENT_ADDRESS_MSB
LOAD_ELEMENT_ADDRESS_MSB_LSB=LOAD_ELEMENT_ADDRESS_MSB+1
LOAD_ELEMENT_ADDRESS_MSB_MSB=LOAD_ELEMENT_ADDRESS_MSB+2
  lda $FFFF,x
  sta STRING_FOUND_ADDRESS_MSB
  rts
  
FindMenuChoices
!if(FindMenuChoices-SPRITE_MENU_FIND_MENU_CHOICES) {
  !ERROR "FindMenuChoices does not match"
}

  lda #"M"
  sta VARIABLE_NAME_1
  lda #"C" +$80       ; $80 means string
  sta VARIABLE_NAME_2
  jsr ScanForArrayVariable
  rts
  
FindMenuPrompt
  lda #"M"
  sta VARIABLE_NAME_1
  lda #"P" +$80       ; $80 means string
  sta VARIABLE_NAME_2
  jsr ScanForSimpleVariable
  rts
  
ScanForArrayVariable
  lda START_OF_ARRAY_STORAGE_AREA_LSB
  sta WORKING_VARIABLE_ADDRESS_LSB
  lda START_OF_ARRAY_STORAGE_AREA_MSB
  sta WORKING_VARIABLE_ADDRESS_MSB
ScanArrayVariableLoop  
  ldy #0
  lda (WORKING_VARIABLE_ADDRESS),y
  cmp VARIABLE_NAME_1
  bne ScanArrayVariableNotMatch
  iny
  lda (WORKING_VARIABLE_ADDRESS),y
  cmp VARIABLE_NAME_2
  bne ScanArrayVariableNotMatch
  ; if here - variable matches the search
  
ArrayVariableMatches
  ; The Array size - assume single byte (not reality - but ok for us
  ldy #6
  lda (WORKING_VARIABLE_ADDRESS),y
  sta ARRAY_SIZE
  lda WORKING_VARIABLE_ADDRESS_LSB
  sta ARRAY_BASE_ADDRESS_LSB
  lda WORKING_VARIABLE_ADDRESS_MSB
  sta ARRAY_BASE_ADDRESS_MSB
  ; Array itself starts 7 bytes later
  clc
  lda ARRAY_BASE_ADDRESS_LSB
  adc #7
  sta ARRAY_BASE_ADDRESS_LSB
  bcc ArrayBaseAddressMSBNoInc
  inc ARRAY_BASE_ADDRESS_MSB
ArrayBaseAddressMSBNoInc
  ; At this point the ARRAY_BASE_ADDRESS has been set to the appropriate value
  rts
ScanArrayVariableNotMatch
  ; Array Variable does not match the name - so we need to skip passed this to the next one
  ldy #2  ; LSB to add to working address
  lda (WORKING_VARIABLE_ADDRESS),y
  sta NEXT_ARRAY_ADDRESS_LSB
  iny
  lda (WORKING_VARIABLE_ADDRESS),y
  sta NEXT_ARRAY_ADDRESS_MSB
  
  clc
  lda WORKING_VARIABLE_ADDRESS_LSB
  adc NEXT_ARRAY_ADDRESS_LSB
  sta WORKING_VARIABLE_ADDRESS_LSB

  lda WORKING_VARIABLE_ADDRESS_MSB
  adc NEXT_ARRAY_ADDRESS_MSB
  sta WORKING_VARIABLE_ADDRESS_MSB
  jmp ScanArrayVariableLoop
  

ScanForSimpleVariable
  lda START_OF_VARIABLE_STORAGE_AREA_LSB
  sta WORKING_VARIABLE_ADDRESS_LSB
  lda START_OF_VARIABLE_STORAGE_AREA_MSB
  sta WORKING_VARIABLE_ADDRESS_MSB
ScanVariableLoop
  ldy #0
  lda (WORKING_VARIABLE_ADDRESS),y
  cmp VARIABLE_NAME_1
  bne ScanVariableNotMatch
  iny
  lda (WORKING_VARIABLE_ADDRESS),y
  cmp VARIABLE_NAME_2
  bne ScanVariableNotMatch
  ; if here - variable matches the search
VariableMatches
  ldy #2
  lda(WORKING_VARIABLE_ADDRESS),y
  sta STRING_FOUND_LENGTH
  iny
  lda(WORKING_VARIABLE_ADDRESS),y
  sta STRING_FOUND_ADDRESS_LSB
  iny
  lda(WORKING_VARIABLE_ADDRESS),y
  sta STRING_FOUND_ADDRESS_MSB
  rts
  
  ; Move on to the next variable
ScanVariableNotMatch
  clc
  lda WORKING_VARIABLE_ADDRESS_LSB
  adc #7    ; 7 bytes per variable
  sta WORKING_VARIABLE_ADDRESS_LSB
  bcc SkipVariableIncrementMSB
  inc WORKING_VARIABLE_ADDRESS_MSB
SkipVariableIncrementMSB
  ; Check if reached end of variables
  lda WORKING_VARIABLE_ADDRESS_LSB
  cmp START_OF_ARRAY_STORAGE_AREA_LSB
  beq ScanEndOfVariableCheckMSB
  ; not matching LSB - not reached end
  jmp ScanVariableLoop
ScanEndOfVariableCheckMSB
  lda WORKING_VARIABLE_ADDRESS_MSB
  cmp START_OF_ARRAY_STORAGE_AREA_MSB
  bne ScanVariableLoop; not matching msb - not reached end
  ; reached end of variables - nothing found
  lda #0
  sta STRING_FOUND_LENGTH
  rts
  
  
DisplaySpriteLine
  ; a# = Line # (0 or 1)
  sta CHARACTER_Y
  lda #<STRING_LINE_STORAGE
  sta SOURCE_CHARACTER_LSB
  lda #>STRING_LINE_STORAGE
  sta SOURCE_CHARACTER_MSB

  jsr WRITE_LINE
   
WRITE_LINE
  lda #0
  sta CHARACTER_X
  lda SOURCE_CHARACTER_MSB
  sta CHARACTER_LOAD_ADDRESS_MSB
  lda SOURCE_CHARACTER_LSB
  sta CHARACTER_LOAD_ADDRESS_LSB

X_START
CHARACTER_LOAD_ADDRESS
CHARACTER_LOAD_ADDRESS_LSB=CHARACTER_LOAD_ADDRESS+1
CHARACTER_LOAD_ADDRESS_MSB=CHARACTER_LOAD_ADDRESS+2
  lda $0340
  ; convert the ascii code to a screen code
  and #($ff-64)
  sta CHARACTER_CODE
  inc CHARACTER_LOAD_ADDRESS_LSB

  jsr UPDATE_CHARACTER_ROM_READ_ADDRESS
  jsr UPDATE_SPRITE_WRITE_ADDRESS
  ; the sprite write address and the rom character read address should
  ; now be set
  ; now to loop through 8 bytes and copy from character rom
  ; to sprite ram (sprites are 3 columns wide)
  ldx #0
  ldy #0

COPY_CHARACTER_BYTE
CHARACTER_ROM_READ_ADDRESS
CHARACTER_ROM_READ_ADDRESS_LSB=CHARACTER_ROM_READ_ADDRESS+1
CHARACTER_ROM_READ_ADDRESS_MSB=CHARACTER_ROM_READ_ADDRESS+2
  lda $ffff,x
  eor EOR_BYTE

SPRITE_WRITE_ADDRESS
SPRITE_WRITE_ADDRESS_LSB=SPRITE_WRITE_ADDRESS+1
SPRITE_WRITE_ADDRESS_MSB=SPRITE_WRITE_ADDRESS+2
  sta $ffff,y
SKIP_STORE
  inx; char rom - advance one byte
  iny; sprite ram - advance 3 bytes
  iny
  iny
  clc
  cpx #8
  bcc COPY_CHARACTER_BYTE
  inc CHARACTER_X
  lda CHARACTER_X
  clc
  cmp #24
  bcc X_START
  rts

UPDATE_CHARACTER_ROM_READ_ADDRESS
  lda #0
  sta CHARACTER_ROM_READ_ADDRESS_MSB
  lda CHARACTER_CODE
  sta CHARACTER_ROM_READ_ADDRESS_LSB
  ; initialise the read address to just be the screen code (msb=0,lsb-screencode)
  
  ; rotate left 3 times the MSB and LSB (including carry from LSB -> MSB) to multiply by 8
  ldx #3
MULTIPLY_BY_8
  clc
  lda CHARACTER_ROM_READ_ADDRESS_MSB
  rol
  sta CHARACTER_ROM_READ_ADDRESS_MSB
  clc
  lda CHARACTER_ROM_READ_ADDRESS_LSB
  rol
  sta CHARACTER_ROM_READ_ADDRESS_LSB
  lda CHARACTER_ROM_READ_ADDRESS_MSB
  adc #0
  sta CHARACTER_ROM_READ_ADDRESS_MSB
  dex
  bne MULTIPLY_BY_8
  ; CHARACTER_ROM_READ_ADDRESS should now represent the screen code offset
  ; increment the MSB by the base of the character rom
  clc
  lda CHARACTER_ROM_READ_ADDRESS_MSB
  adc #>CHARACTER_ROM_BASE
  sta CHARACTER_ROM_READ_ADDRESS_MSB
  rts

UPDATE_SPRITE_WRITE_ADDRESS
  ldx CHARACTER_X
  lda CHARACTER_Y
  bne SPRITE_LINE_1
  lda SPRITE_ADDRESS_LSB_LOOKUP_LINE_0,x
  sta SPRITE_WRITE_ADDRESS_LSB
  lda SPRITE_ADDRESS_MSB_LOOKUP_LINE_0,x
  sta SPRITE_WRITE_ADDRESS_MSB
  rts
SPRITE_LINE_1
  lda SPRITE_ADDRESS_LSB_LOOKUP_LINE_1,x
  sta SPRITE_WRITE_ADDRESS_LSB
  lda SPRITE_ADDRESS_MSB_LOOKUP_LINE_1,x
  sta SPRITE_WRITE_ADDRESS_MSB
  rts
  
CHARACTER_X           !byte 0
CHARACTER_Y           !byte 0
CHARACTER_CODE        !byte 0
SOURCE_CHARACTER_LSB  !byte 0
SOURCE_CHARACTER_MSB  !byte 0

*=$a500
  lda $1
  ora #4; Turn on VIC Registers
  sta $1
  ldx #0
BACKUP_SPRITE_MOBS
  lda SPRITE_MEMORY_LOCATION_BASE,x
  sta SPRITE_BACKUP_MOBS_LOCATION,x
  
  lda SPRITE_MEMORY_LOCATION_BASE+256,x
  sta SPRITE_BACKUP_MOBS_LOCATION+256,x
  inx
  bne BACKUP_SPRITE_MOBS
  
  ldx #0
  clc
BACKUP_SPRITE_COORDINATES
  lda $d000,x
  sta SPRITE_BACKUP_COORDINATE_LOCATION,x
  inx
  cpx #17
  bcc BACKUP_SPRITE_COORDINATES

  ldx #0
  clc
BACKUP_SPRITE_COLOURS
  lda $d027,x
  sta SPRITE_BACKUP_COLOUR_LOCATION,x
  inx
  cpx #8
  bcc BACKUP_SPRITE_COLOURS
  
BACKUP_SPRITE_PRIORITY
  lda $d01b
  sta SPRITE_BACKUP_PRIORITY_LOCATION

BACKUP_SPRITE_ENABLED
  lda $d015
  sta SPRITE_BACKUP_ENABLED_LOCATION
  
  rts

*=$a540
  lda $1
  ora #4; Turn on VIC Registers
  sta $1
  ldx #0
RESTORE_SPRITE_MOBS
  lda SPRITE_BACKUP_MOBS_LOCATION,x
  sta SPRITE_MEMORY_LOCATION_BASE,x

  lda SPRITE_BACKUP_MOBS_LOCATION+256,x
  sta SPRITE_MEMORY_LOCATION_BASE+256,x
  inx
  bne RESTORE_SPRITE_MOBS
  
  ldx #0
  clc
RESTORE_SPRITE_COORDINATES
  lda SPRITE_BACKUP_COORDINATE_LOCATION,x
  sta $d000,x
  inx
  cpx #17
  bcc RESTORE_SPRITE_COORDINATES

  ldx #0
  clc
RESTORE_SPRITE_COLOURS
  lda SPRITE_BACKUP_COLOUR_LOCATION,x
  sta $d027,x
  inx
  cpx #8
  bcc RESTORE_SPRITE_COLOURS
  
RESTORE_SPRITE_PRIORITY
  lda SPRITE_BACKUP_PRIORITY_LOCATION
  sta $d01b

RESTORE_SPRITE_ENABLED
  lda SPRITE_BACKUP_ENABLED_LOCATION
  sta $d015

  rts
  
SPRITE_BACKUP_MOBS_LOCATION
  !fill 64*8,$ff
SPRITE_BACKUP_COORDINATE_LOCATION
  !fill 17,$ff
SPRITE_BACKUP_COLOUR_LOCATION
  !fill 8,$ff
SPRITE_BACKUP_PRIORITY_LOCATION !byte $ff
SPRITE_BACKUP_ENABLED_LOCATION !byte $ff
  
