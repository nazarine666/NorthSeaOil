!source "common.asm"
PROGRAM_START=FILE_LOADER_PROGRAM_START
*=PROGRAM_START
FILENAME_LENGTH = FILE_LOADER_FILENAME_LENGTH
FILENAME        = FILE_LOADER_FILENAME
START
        sei
        LDA FILENAME_LENGTH
        LDX #<FILENAME
        LDY #>FILENAME
        JSR $FFBD     ; call SETNAM

        LDA #$02      ; file number 2
        TAY           ; secondary address set to 2
        LDX #$08      ; default to device 8
        JSR $FFBA     ; call SETLFS
        JSR $FFC0     ; call OPEN
        ;BCS ERROR    ; if carry set, the file could not be opened
        BCS CLOSE     ; if carry set, the file could not be opened

        ; check drive error channel here to test for
        ; FILE NOT FOUND error etc.

        LDX #$02      ; filenumber 2
        JSR $FFC6     ; call CHKIN (file 2 now used as input)
        
        ; read first 2 bytes of file, these are the load address
        JSR $FFCF
        STA $AE
        JSR $FFCF
        STA $AF

        LDY #$00
LOOP    JSR $FFB7     ; call READST (read status byte)
        BNE EOF       ; either EOF or read error
        JSR $FFCF     ; call CHRIN (get a byte from file)
        STA ($AE),Y   ; write byte to memory
        INC $AE
        BNE SKIP
        INC $AF
SKIP    JMP LOOP     ; next byte

EOF
        ;AND #$40      ; end of file?
        ;BEQ READERROR
CLOSE
        LDA #$02      ; filenumber 2
        JSR $FFC3     ; call CLOSE
        JSR $FFCC     ; call CLRCHN
        cli
        RTS
;ERROR2
;  jmp CLOSE
;ERROR
        ; Akkumulator contains BASIC error code

        ; most likely errors:
        ; A = $05 (DEVICE NOT PRESENT)

        ;... error handling for open errors ...
;        JMP CLOSE    ; even if OPEN failed, the file has to be closed
;READERROR
        ; for further information, the drive error channel has to be read

        ;... error handling for read errors ...
;        JMP CLOSE
