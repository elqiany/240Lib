;hw9prob6 temp sensor
    .ORG $0000
    BRA START

    .ORG $1000

START
    LI r1, $0012
    LI r2, $0014
    LI r3, $0020
    LI r4, $2000

    ;enable sensor
    LI r7, $0001
    SW r1, r7, $0

MAINLOOP
    LI r7, $0003
    SW r1, r7, $0

    ;3 attempts
    LI r6, $0003

WAITREADY
    LW r7, r2, $0
    LI r5, $8000
    AND r7, r7, r5
    BRZ WAITREADY

    ;r5 working copy for parity
    LW r5, r3, $0

    LI r7, $000D
    SW r1, r7, $0

    ;r7 parity accumulator
    LW r7, r3, $0

PARITYLOOP
    LI r0, $0000
    ADD r5, r5, r0
    BRZ PARITYDONE
    LI r2, $0001
    AND r2, r5, r2
    BRZ NOTOG

    LI r2, $0001
    XOR r7, r7, r2

NOTOG
    LI r2, $0001
    SRL r5, r5, r0
    BRA PARITYLOOP

PARITYDONE
    ADD r7, r7, r0
    BRZ GOODDATA

BADDATA
    ;one attempt failed
    LI r2, $0001
    SUB r6, r6, r2
    BRZ FAILED

    LI r7, $0005
    SW r1, r7, $0

    LI r2, $0014
    BRA WAITREADY

GOODDATA
    LI r7, $0001
    SW r1, r7, $0

    LW r5, r3, $0
    LI r7, $00FF
    AND r5, r5, r7
    SW r4, r5, $0

    BRA ADVANCEPTR

FAILED
    LI r7, $0009
    SW r1, r7, $0

    LI r5, $00FF
    SW r4, r5, $0

ADVANCEPTR
    LI r2, $0001
    ADD r4, r4, r2

    LI  r7, $2008 ;wrap
    SUB r7, r4, r7
    BRZ WRAPPTR

    LI r2, $0014
    BRA MAINLOOP

WRAPPTR
    LI r4, $2000
    LI r2, $0014
    BRA MAINLOOP

