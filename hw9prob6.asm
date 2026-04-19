    .ORG $1000

START:
    LI r1, $0012
    LI r2, $0014
    LI r3, $0020
    LI r4, $2000

    ;enable sensor
    LI r7, $0001
    SW r1, r7, $0

MAIN_LOOP:
    LI r7, $0003
    SW r1, r7, $0

    ;3 attempts
    LI r6, $0003

TRY_READ:
WAIT_READY:
    LW r7, r2, $0
    LI r5, $8000
    AND r7, r7, r0
    BRZ WAIT_READY

    LW r5, r3, $0

    LI r7, $000D
    SW r1, r7, $0

    LI r7, $0000

PARITY_LOOP:
    LI r0, $0000
    AND r5, r5, r0
    BRZ PARITY_DONE
    LI r0, $0001
    AND r0, r5, r0
    BRZ NO_TOG

    LI r0, $0001
    XOR r7, r7, r0

NO_TOG:
    SRL r5, r5, $1
    BRA PARITY_LOOP

PARITY:DONE
    LI r0, $0000
    ADD r7, r7, r0
    BRZ GOOD_DATA

BAD_DATA:
    ;one attempt failed
    LI r0, $0001
    SUB r6, r6, r0
    BRZ FAILED

    LI r7, $0005
    SW r1, r7, $0
    BRA TRY_READ

GOOD_DATA:
    LI r7, $0001
    SW r1, r7, $0

    LW r5, r3, $0
    LI r7, $00FF
    AND r5, r5, r7
    SW r4, r5, $0

    BRA ADVANCE_PTR

FAILED:
    LI r7, $0009
    SW r1, r7, $0

    LI r5, $00FF
    SW r4, r5, $0

ADVANCE_PTR:
    LI r0, $0001
    ADD r4, r4, r0

    LI  r7, $2008 ;wrap
    SUB r7, r4, r7
    BRZ WRAP_PTR
    BRA MAIN_LOOP

WRAP_PTR:
    LI r4, $2000
    BRA MAIN_LOOP

        .DW $0012
        .DW $0014
        .DW $0020
        .DW $2000
        .DW $2008

