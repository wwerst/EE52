@
@
@     Keypad
@



.include    "at91rm9200.inc"
.include    "system.inc"
.include    "keypad.inc"
.include    "macro.inc"
.include    "interfac.inc"

.text
.arm

.global keypad_init
keypad_init:
    
    PUSH {lr}
    SetHReg AIC_SVR4, KeypadHandler
    SetHReg AIC_SMR4, 0x00000060        @Positive edge, Priority 0 (lowest)
    SetHReg AIC_IECR, 0x00000010
    SetHReg PIOC_IER, (1 << RDY_PIN) | (1 << HANGUP_BTN)
    LDR r0, =20
    STR r0, LastKeypress
    LDR r0, =FALSE
    STR r0, NewKey
    LDR r0, =PIOC_ISR                   @Clear any changed values in PIOC_ISR
    LDR r0, [r0]
    POP {pc}

    
.global key_available
key_available:
    PUSH    {lr}
    LDR     r0,     NewKey
    POP     {pc}

.global getkey
getkey:
    PUSH    {lr}
waitkey:
    LDR     r0,     NewKey
    CMP     r0,     #FALSE
    BEQ     waitkey
    
    @ Continue and get key
    LDR     r0,     =FALSE
    STR     r0,     NewKey
    LDR     r0,     LastKeypress
    POP     {pc}
    

KeypadHandler:
    
    PUSH {r0-r4, lr}
	
	LDR 	r2, 	=PIOC_ISR
    LDR 	r2, 	[r2]
	
    LDR 	r0, 	=PIOC_PDSR
    LDR		r0, 	[r0]
	
    
    @Now, r0 contains the raw IO input, need to decipher button pressed
    TST     r0, 	#(1 << HANGUP_BTN)
    BEQ     HangupBtnPressed
	
	@If the hangup button isn't pressed, reset its' debounce count.
	LDR		r1,		=MAXDEBCOUNT
	STR		r1,		HangupBtnDebounce
	
    TST     r0, 	#(1 << RDY_PIN)
    BNE     KeypadBTNPressed
    @If neither of these are triggered, then it was a button release, so ignore it
    B       EndKeypadHandler
HangupBtnPressed:
	LDR		r0,		HangupBtnDebounce
	SUBS	r0, #1
	CMP		r0, #-1
	
	STRHS	r0,		HangupBtnDebounce
    LDR     r0,     HookState
    CMP     r0,     #KEY_ONHOOK
    LDREQ   r0,     =KEY_OFFHOOK
    LDRNE   r0,     =KEY_ONHOOK
    B       StoreButtonPress
KeypadBTNPressed:
    LSR     r0, 	r0, 	#26
    LDR     r1, 	=KeyTable
    LDR     r0, 	[r1, r0, LSL #2]
    @B      StoreButtonPress
StoreButtonPress:
    STR 	r0, 	LastKeypress
    LDR 	r0, 	=TRUE
    STR 	r0, 	NewKey
    @B 		EndKeypadHandler
EndKeypadHandler:
    STR 	r0, 	LastKeypress
    LDR 	r0, 	=TRUE
    STR 	r0, 	NewKey
    SetHReg AIC_EOICR, 4
    POP 	{r0-r4, lr}
    SUBS 	pc, 	lr, 	#4
    
    
LastKeypress:
    .word 	0x00000000
NewKey:
    .word 	0x00000000

HookState:
    .word 	0x00000000

HangupBtnDebounce:
	.word 	0x00000000
KeyTable:
    .word 	0x00000000         @0
    .word 	0x00000001         @1
    .word 	0x00000002         @2
    .word 	0x00000003         @3
    .word 	0x00000004         @4
    .word 	0x00000005         @5
    .word 	0x00000006         @6
    .word 	0x00000007         @7
    .word 	0x00000008         @8
    .word 	0x00000009         @9
    .word 	0x0000000A         @10
    .word 	0x0000000B         @11
    .word 	0x0000000C         @12
    .word 	0x0000000D         @13
    .word 	0x0000000E         @14
    .word 	0x0000000F         @15
    .word 	0x00000010         @16
    .word 	0x00000011         @17
    .word 	0x00000012         @18
    .word 	0x00000013         @19
    .word 	0x00000014         @20
    .word 	0x00000015         @21
    .word 	0x00000016         @22
    .word 	0x00000017         @23
    .word 	0x00000018         @24
    .word 	0x00000019         @25
    .word 	0x0000001A         @26
    .word 	0x0000001B         @27
    .word 	0x0000001C         @28
    .word 	0x0000001D         @29
    .word 	0x0000001E         @30
    .word 	0x0000001F         @31