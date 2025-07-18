!SOURCE "common.asm"

; DrawTile routine
; BX,BY are inputs (1-6,1-6)
; Tile already loaded at address $c700
TILE_ADDRESS          =$c700
BITMAP_BASE_ADDRESS   =$e000
;BITMAP_BASE_ADDRESS   =$c800


*=DRAW_TILE_LOAD_START
BOARD_X  !byte 2
!if(BOARD_X-DRAW_TILE_BOARD_X) {
  !ERROR "BOARD_X does not match"
}
BOARD_Y  !byte 2
!if(BOARD_Y-DRAW_TILE_BOARD_Y) {
  !ERROR "BOARD_Y does not match"
}

SYS_START
!if(SYS_START-DRAW_TILE_PROGRAM_START) {
  !ERROR "PROGRAM_START does not match"
}

  lda #0              ; make sure we are doing full tile by default
  sta IS_QUARTER_TILE
  lda BOARD_X
  and #$80
  beq TILE_AT_COORDINATE

  ; special case coordinates - in the corners
TILE_AT_CORNERS
  clc
  lda BOARD_X
  cmp #133
  bne NOT_WEATHER_BACK
  
  ; Weather Back
  lda #1
  sta IS_QUARTER_TILE
  lda BOARD_Y
  clc
  rol; multiply by two
  tay
  lda WEATHER_BACK_QUADRANT_ADDRESS_LIST_LSB,y
  sta STORE_DESTINATION_ADDRESS_LSB
  lda WEATHER_BACK_QUADRANT_ADDRESS_LIST_MSB,y
  sta STORE_DESTINATION_ADDRESS_MSB
  jmp DRAW_TILES
  
NOT_WEATHER_BACK  
  and #$7f
  clc
  rol   ; multiply by two
  tay
  lda CORNER_ADDRESS_LIST_LSB,y
  sta STORE_DESTINATION_ADDRESS_LSB
  lda CORNER_ADDRESS_LIST_MSB,y
  sta STORE_DESTINATION_ADDRESS_MSB
  jmp DRAW_TILES
   
TILE_AT_COORDINATE
  ; BOARD_X and BOARD_Y will be in range 1 - 6
  ; make them both in range 0 - 5
  dec BOARD_X
  dec BOARD_Y

  ; position destination address to be the position of the top left byte where the tile will go
  lda #<BITMAP_BASE_ADDRESS
  sta STORE_DESTINATION_ADDRESS_LSB
  lda #>BITMAP_BASE_ADDRESS
  sta STORE_DESTINATION_ADDRESS_MSB
  
  ; skip downwards for each BOARD_Y
  ; BOARD_Y is made up of 32 lines
  lda BOARD_Y
  
  ;jsr DEBUG
  clc
  rol a
  rol a
  rol a
  rol a
  rol a
  
  ; also need a further 4 because the tiles don't start at #0 they start at #4
  clc
  adc #4
 
  ; A register now holds the amount of lines to skip downwards

  tax
  
SKIP_LINES
  jsr INCREMENT_LINE
  dex
  bne SKIP_LINES
  
  ; now need to move right by the appropriate BOARD_X and offset value
  lda BOARD_X
  ; muliply by 32 then divide by 8 = multiply by 4
  clc
  rol a
  rol a
  ; also need a further 8
  clc
  adc #8
  ; A register now holds the amount of columns (8 pixels per column) to skip rightwards
  tax
SKIP_COLUMNS
  jsr INCREMENT_COLUMN
  dex
  bne SKIP_COLUMNS
  
  ; the destination address is now exactly at the top left of where the tile should go
  ; copy tile in 4 columns
  ; initially we are copying column #0
DRAW_TILES
  lda #0 ; column
  sta COLUMN_BYTE
  
COPY_COLUMNS
  ; store the current address on the stack so we can get back to this after the column is done
  lda STORE_DESTINATION_ADDRESS_LSB
  pha
  lda STORE_DESTINATION_ADDRESS_MSB
  pha
  ldy COLUMN_BYTE ; tile offset (0 - 3)
  
COPY_COLUMN
  lda TILE_ADDRESS,y
STORE_DESTINATION_ADDRESS
STORE_DESTINATION_ADDRESS_LSB=STORE_DESTINATION_ADDRESS+1
STORE_DESTINATION_ADDRESS_MSB=STORE_DESTINATION_ADDRESS+2
  sta $E000
  jsr INCREMENT_LINE

  ; tiles are stored 4 bytes per row - so need to skip Y by 4 except on quadrant - which is 2
  iny
  iny
  lda IS_QUARTER_TILE
  
  ; Quandrant
  beq FULL_TILE_ROW_INC
  
  clc
  ; Only 32 bytes in a quarter tile
  cpy #32
  bcc COPY_COLUMN
  jmp COPIED_ENTIRE_COLUMN
  
FULL_TILE_ROW_INC
  iny
  iny
  clc
  ; 128 bytes in a full tile
  cpy #128
  bcc COPY_COLUMN
COPIED_ENTIRE_COLUMN
  ; copied an entire column
  
  ; load the destination address back from the stack
  pla

  sta STORE_DESTINATION_ADDRESS_MSB
  pla
  sta STORE_DESTINATION_ADDRESS_LSB
  ; we need to exit if we have copied 4 columns
  
  inc COLUMN_BYTE
  lda IS_QUARTER_TILE
  beq FULL_TILE_COLUMN_INC

  ; Quarter Tile
  lda COLUMN_BYTE
  clc
  cmp #2        ; Two columns in a quarter tile
  bcs SYS_EXIT
  jsr INCREMENT_COLUMN
  jmp COPY_COLUMNS

FULL_TILE_COLUMN_INC
  lda COLUMN_BYTE
  clc
  cmp #4        ; four columns in a full tile
  bcs SYS_EXIT
  jsr INCREMENT_COLUMN
  jmp COPY_COLUMNS

SYS_EXIT
  rts  
INCREMENT_LINE
  ; add one to the destination address
  inc STORE_DESTINATION_ADDRESS_LSB
  bne CHAR_CHECK
  inc STORE_DESTINATION_ADDRESS_MSB
  ; if destination address mod 8 is 0 then that means we didn't increment enough - we need to increment a futher 319 (13F) bytes
CHAR_CHECK
  lda STORE_DESTINATION_ADDRESS_LSB
  and #7
  beq CHAR_ROW_INCREASE
  rts
CHAR_ROW_INCREASE
  clc
  lda STORE_DESTINATION_ADDRESS_LSB
  adc #$3F-7
  sta STORE_DESTINATION_ADDRESS_LSB
  lda STORE_DESTINATION_ADDRESS_MSB
  adc #1
  sta STORE_DESTINATION_ADDRESS_MSB
  rts
  
INCREMENT_COLUMN
  clc
  lda STORE_DESTINATION_ADDRESS_LSB
  adc #8
  sta STORE_DESTINATION_ADDRESS_LSB
  bcc CHAR_COLUMN_FINISHED
  inc STORE_DESTINATION_ADDRESS_MSB
CHAR_COLUMN_FINISHED
  rts
  
COLUMN_BYTE !byte #0
IS_QUARTER_TILE !byte #0

CORNER_ADDRESS_LIST
CORNER_ADDRESS_LIST_LSB=CORNER_ADDRESS_LIST
CORNER_ADDRESS_LIST_MSB=CORNER_ADDRESS_LIST+1
; Government
!word BITMAP_BASE_ADDRESS+(320*1)+(8*1)     ; green 1
!word BITMAP_BASE_ADDRESS+(320*6)+(8*1)     ; green 2

; Money
!word BITMAP_BASE_ADDRESS+(320*15)+(8*1)    ; red 1
!word BITMAP_BASE_ADDRESS+(320*20)+(8*1)    ; red 2

; Weather
WEATHER_FRONT_BASE_ADDRESS=BITMAP_BASE_ADDRESS+(320*1)+(8*35)     ; brown 1
!word WEATHER_FRONT_BASE_ADDRESS     ; brown 1

WEATHER_BACK_BASE_ADDRESS=BITMAP_BASE_ADDRESS+(320*6)+(8*35)     ; brown 2
!word WEATHER_BACK_BASE_ADDRESS     ; brown 2

; Prospect
!word BITMAP_BASE_ADDRESS+(320*15)+(8*35)    ; blue 1
!word BITMAP_BASE_ADDRESS+(320*20)+(8*35)    ; blue 2

WEATHER_BACK_QUADRANT_ADDRESS_LIST
WEATHER_BACK_QUADRANT_ADDRESS_LIST_LSB=WEATHER_BACK_QUADRANT_ADDRESS_LIST
WEATHER_BACK_QUADRANT_ADDRESS_LIST_MSB=WEATHER_BACK_QUADRANT_ADDRESS_LIST+1
!word WEATHER_BACK_BASE_ADDRESS+(0*320)+(0*16)   ;NW
!word WEATHER_BACK_BASE_ADDRESS+(0*320)+(1*16)   ;NE
!word WEATHER_BACK_BASE_ADDRESS+(2*320)+(0*16)   ;SW
!word WEATHER_BACK_BASE_ADDRESS+(2*320)+(1*16)   ;SE





;DEBUG
;  stx 704
;  sty 705
;  sta 706
;  pha
;  lda BOARD_X
;  sta 707
;  lda BOARD_Y
;  sta 708
;  pla
;  rts

;DISPLAY_X
;  jsr STORE_REGISTERS
;  txa
;  jsr DISPLAY
;  jsr LOAD_REGISTERS
;  rts
  
;DISPLAY_Y
;  jsr STORE_REGISTERS
;  tya
;  jsr DISPLAY
;  jsr LOAD_REGISTERS
;  rts
;DISPLAY_A
;  jsr STORE_REGISTERS
;  jsr DISPLAY
;  jsr LOAD_REGISTERS
;  rts

;STORE_REGISTERS
;  sta $0400
;  stx $0401
;  sty $0402
;  rts
;LOAD_REGISTERS
;  lda $0400
;  ldx $0401
;  ldy $0402
;  rts
;ZERO_DISPLAY  
;  lda #$30
;  sta $0420
;  sta $0421
;  sta $0422
;  rts
;DISPLAY
;  tax
;  jsr ZERO_DISPLAY
;  txa
;  bne INCREMENT_COUNTER
;  rts
  
;INCREMENT_COUNTER
;  inc $0422
;  lda $0422
;  cmp #$3A
;  bne COUNTER_END
;  lda #$30
;  sta $0422
;  inc $0421
;  lda $0421
;  cmp #$3A
;  bne COUNTER_END
;  lda #$30
;  sta $0421
;  inc $0420
;COUNTER_END
;  dex
;  bne INCREMENT_COUNTER
;  rts
 
