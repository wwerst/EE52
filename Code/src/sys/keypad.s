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
    
    PUSH 	{lr}
    SetHReg AIC_SVR4, KeypadHandler
    SetHReg AIC_SMR4, 0x00000060        @Positive edge, Priority 0 (lowest)
    SetHReg AIC_IECR, 0x00000010
    SetHReg PIOC_IER, (1 << RDY_PIN)
    LDR 	r0, =KEY_ILLEGAL
    STR 	r0, LastKeypress
    LDR 	r0, =FALSE
    STR 	r0, NewKey
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
	
    
	
    TST     r0, 	#(1 << RDY_PIN)
    BNE     KeypadBTNPressed
    @Interrupt caused by a button release, so ignore it
    B       EndKeypadHandler

KeypadBTNPressed:
    LSR     r0, 	r0, 	#27
	CMP		r0,		#HANGUPBTN
	BEQ		HangupBtnPressed
    LDR     r1, 	=KeyTable
    LDR     r0, 	[r1, r0, LSL #2]
    B      StoreButtonPress
HangupBtnPressed:
    LDR     r0,     HookState			@Check what state phone is in (on or off hook)
    CMP     r0,     #KEY_ONHOOK			@Check the current value
    LDREQ   r0,     =KEY_OFFHOOK		@Toggle it
    LDRNE   r0,     =KEY_ONHOOK
	STR		r0,		HookState
    @B       StoreButtonPress			@Store button press.
StoreButtonPress:
    STR 	r0, 	LastKeypress
    LDR 	r0, 	=TRUE
    STR 	r0, 	NewKey
    @B 		EndKeypadHandler
EndKeypadHandler:
    SetHReg AIC_EOICR, 4
    POP 	{r0-r4, lr}
    SUBS 	pc, 	lr, 	#4
    
    
LastKeypress:
    .word 	0x00000000
NewKey:
    .word 	0x00000000

HookState:
    .word 	KEY_ONHOOK

KeyTable:
    .word 	0x00000000         @0
    .word 	0x00000001         @1
    .word 	0x00000002         @2
    .word 	0x00000003         @3
    .word 	KEY_1		         @4
    .word 	0x00000005         @5
    .word 	KEY_3		         @6
    .word 	KEY_2		         @7
    .word 	KEY_4		         @8
    .word 	0x00000009         @9
    .word 	KEY_6		         @10
    .word 	KEY_5		         @11
    .word 	KEY_7		         @12
    .word 	0x0000000D         @13
    .word 	KEY_9		         @14
    .word 	KEY_8		         @15
    .word 	0x00000010         @16
    .word 	0x00000011         @17
    .word 	0x00000012         @18
    .word 	0x00000013         @19