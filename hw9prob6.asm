    .ORG $1000

START:
    LI r1, CTRL
    LI r2, STAT
    LI r3, DATA
    LI r4, ARRAY

    ;enable sensor
    LI r6, $0001
    SW r1, r6, $0

MAIN_LOOP:
    LI r6, $0003
    SW r1, r6, $0

    ;3 attempts
    LI r7, $0003

TRY_READ:
WAIT_READY:
    LW r6, r2, $0
    LI r5, $8000
    AND r6, r6, r5
    BRZ WAIT_READY

    LW r5, r3, $0

    LI r6, $000D
    SW r1, r6, $0

    MV r6, r5
    LI r5, $0000
    LI r7, $0010

PARITY_LOOP:
    LI r0, $0001
    AND r0, r6, r0
    BRZ SKIP_TOGGLE
    LI r0, $0001
    XOR r5, r5, r0

SKIP_TOGGLE:
    SRL r6, r6, $1
    LI r0, $0001
    SUB r7, r7, r0
    BRZ PARITY_DONE
    BRA PARITY_LOOP

PARITY:DONE
    BRZ GOOD_DATA

BAD_DATA:
    ;one attempt failed
    LI r0, $0001
    SUB r7, r7, r0
    BRZ GIVE_UP

    LI r6, $0005
    SW r1, r6, $0
    BRA TRY_READ

GOOD_DATA:
    LI r6, $0001
    SW r1, r6, $0

    LW r5, r3, $0
    LI r6, $00FF
    AND r5, r5, r6
    SW r4, r5, $0

    BRA ADVANCE_PTR

GIVE_UP:
    LI r6, $0009
    SW r1, r6, $0

    LI r5, $00FF
    SW r4, r5, $0

ADVANCE_PTR:
    LI r6, $0001
    ADD r4, r4, r6

    LI  r6, ARRAY_END
    SUB r5, r4, r6
    BRZ WRAP_PTR
    BRA MAIN_LOOP

WRAP_PTR:
    LI r4, ARRAY
    BRA MAIN_LOOP

CTRL:   .DW $0012
STAT:   .DW $0014
DATA:   .DW $0020
ARRAY:  .DW $2000
ARRAY_END: .DW $2008

