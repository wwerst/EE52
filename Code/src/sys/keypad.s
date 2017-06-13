@
@
@     Keypad
@



.include    "at91rm9200.inc"
.include    "system.inc"
.include    "keypad.inc"
.include    "macro.inc"

.text
.arm

.global keypad_init
keypad_init:
    
    PUSH {lr}
    SetHReg AIC_SVR4, KeypadHandler
    SetHReg AIC_SMR4, 0x00000060        @Positive edge, Priority 0 (lowest)
    SetHReg AIC_IECR, 0x00000010
    SetHReg PIOC_IER, 1 << Keypad_RDY_Pin
    LDR r0, LastKeypress
    LDR r1, =20
    STR r1, [r0]
    POP {pc}
    
KeypadHandler:
    
    PUSH {r0-r4, lr}
    LDR r0, =PIOC_PDSR
    LDR r0, [r0]
    AND r0, #0xFF000000
    STR r0, LastKeypress
    LDR r0, =PIOC_ISR
    LDR r0, [r0]
    SetHReg AIC_EOICR, 4
    POP {r0-r4, pc}
    
LastKeypress:
    .word 0x0000000