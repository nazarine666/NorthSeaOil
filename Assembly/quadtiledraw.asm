!source "common.asm" 
 
*=QUAD_MENU_PROGRAM_START

START
  ; need to set BOARD_X,Y so it is pointing to the appropriate quadrant of the weather back square
  lda #133              ; weather back
  sta DRAW_TILE_BOARD_X
  lda #0                ; nw
  sta DRAW_TILE_BOARD_Y

  jsr SPRITE_MENU_FIND_MENU_CHOICES
  ; at this point ARRAY_BASE_ADDRESS points to element 0 of the array
  ; We are need to start at element #1
  lda #1
  sta SPRITE_MENU_MENU_INDEX
  
ARRAY_ENTRY_LOOP
  jsr SPRITE_MENU_FIND_ARRAY_ENTRY
  jsr CopyStringToFilename
  lda #55
  sta $1
  jsr FILE_LOADER_PROGRAM_START
  ; LoadFile does a cli so we need to re-disable the interrupts
  sei
  lda #50
  sta $1
  ; At this point the quad tile is loaded
  jsr DRAW_TILE_PROGRAM_START

  
  inc DRAW_TILE_BOARD_Y       ; move to the next quadrant
  inc SPRITE_MENU_MENU_INDEX  ; move to the next tile filename
  lda SPRITE_MENU_MENU_INDEX
  cmp #5                      ; if reached 5 then done all 4 quadrants
  bne ARRAY_ENTRY_LOOP
  
END_PROGRAM
  rts
  
  
  
CopyStringToFilename
  lda SPRITE_MENU_STRING_FOUND_LENGTH
  sta FILE_LOADER_FILENAME_LENGTH
  
  ldy #0
CopyStringToFilenameLoop
  lda (SPRITE_MENU_STRING_FOUND_ADDRESS),y
  sta FILE_LOADER_FILENAME,y
  clc
  iny
  cpy FILE_LOADER_FILENAME_LENGTH
  bne CopyStringToFilenameLoop
  rts
  

  
  
  
