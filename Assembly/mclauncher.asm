*=$2f0
  sei
  ; Bit     Bank
  ; 0       $A000     0=RAM       1=Basic       LORAM
  ; 1       $E000     0=RAM       1=Kernal      HIRAM
  ; 2       $D000     0=Char ROM  1=VIC RAM     CHAREN
  
CHAREN  HIREM   LORAM   $A000-$BFFF   $D000-$DFFF   $E000-$EFFF
0       0       0       RAM           RAM           RAM             0
0       0       1       RAM           CHAR ROM      KERNAL          1
0       1       0       RAM           CHAR ROM      KERNAL          2 (50/$32)
0       1       1       BASIC ROM     CHAR ROM      KERNAL          3
1       0       0       RAM           RAM           RAM             4
1       0       1       RAM           I/O           RAM             5
1       1       0       RAM           I/O           KERNAL          6 (54/$36)
1       1       1       BASIC ROM     I/O           KERNAL          7 (55/$37)

  lda #50   ; 0101 0010 
  sta 01
  jsr $ffff
  lda #55   ; 0011 0111
  sta 01
  cli
  rts
  nop
  
