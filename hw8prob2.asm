
    .ORG $1000

    LI r1, $0
    LI r4, $0
    LI r5, $0
    LI r6, $0

LOOP
    LI r2, $8
    SUB r2, r1, r2
    BRZ VALID

    LI r2, $4
    SLT r7, r1, r2
    BRAZ SEC

FIRST
    LI r2, BOARD
    LW r2, r2, $0
    SUB r7, r1, r0
    BRZ SHIFT12
    BRA CHECK1

SEC
    LI r2, BOARD
    LW r2, r2, $2
    LI r7, $4
    SUB r7, r1, r7
    BRZ SHIFT12

CHECK1
    LI r3, $1
    SUB r3, r7, r3
    BRZ SHIFT8

CHECK2
    LI r3, $2
    SUB r3, r7, r3
    BRZ SHIFT4

SHIFT0
    BRA MASK_NIBBLE

SHIFT4
    SRLI r2, r2, $4

SHIFT8
    SRLI r2, r2, $8
    BRA MASK_NIBBLE

SHIFT12
    SRLI r2, r2, $C

MASK_NIBBLE
    LI r7, $F
    AND r3, r2, r7

    LI r7, $1
    SLL r7, r7, r3
    AND r2, r4, r7
    BRZ COL_OK
    BRA INVALID

COL_OK
    OR r4, r4, r7
    ADD r2, r1, r3
    LI r7, $1
    SLL r7, r7, r2
    AND r2, r5, r7
    BRZ DIAG1_OK
    BRA INVALID

DIAG1_OK
    OR r5, r5, r7
    LI r2, $7
    ADD r2, r2, r3
    SUB r2, r2, r1
    LI r7, $1
    SLL r7, r7, r2
    AND r2, r6, r7
    BRZ DIAG2_OK
    BRA INVALID

DIAG2_OK
    OR r6, r6, r7
    ADDI r1, r1, $1
    BRA LOOP

VALID
    LI r7, $1
    STOP

INVALID
    LI r7, $0
    STOP

    .ORG $1234
BOARD .DW $1324
      .DW $0657





