@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@
@
@
@
@
@
@
@
@
@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@ Description:
@
@
@ Table of Contents:
@ 
@
@
@
@
@
@ Revision History:
@ Name			Comment					Date
@ Will Werst	Initial version			Some lonely night around 6/10/17
@ Will Werst	Comment					October 2017



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
    mSET_HREG AIC_SVR4, KeypadHandler
    mSET_HREG AIC_SMR4, 0x00000060        @Positive edge, Priority 0 (lowest)
    mSET_HREG AIC_IECR, 0x00000010
    mSET_HREG PIOC_IER, (1 << RDY_PIN)
    LDR 	r0, =KEY_ILLEGAL
    mStoreFromReg 	r0, r1, LastKeypress
    LDR 	r0, =FALSE
    mStoreFromReg 	r0, r1, NewKey
    LDR r0, =PIOC_ISR                   @Clear any changed values in PIOC_ISR
    LDR r0, [r0]
    POP {pc}

    
.global key_available
key_available:
    PUSH    {lr}
    mLoadToReg     r0,     NewKey
    POP     {pc}

.global getkey
getkey:
    PUSH    {lr}
waitkey:
    mLoadToReg     r0,     NewKey
    CMP     r0,     #FALSE
    BEQ     waitkey
    
    @ Continue and get key
    LDR     r0,     =FALSE
    mStoreFromReg     r0, r1,     NewKey
    mLoadToReg     r0,     LastKeypress
    POP     {pc}
    

KeypadHandler:
    
    PUSH {r0-r4, lr}
	
	mLoadToReg	r2,	PIOC_ISR
	
    mLoadToReg	r0,	PIOC_PDSR
	
    
	
    TST     r0, 	#(1 << RDY_PIN)
    BNE     KeypadBTNPressed
    @Interrupt caused by a button release, so ignore it
    B       EndKeypadHandler

KeypadBTNPressed:
    LSR     r0, 	r0, 	#27			@Shift the data to extract the key value
	mLoadToReg r1, ShiftEnabled			@Check if in shift mode
	CMP		r1,		#TRUE				@Make comparison to see if in shift mode
	LDREQ	r1,		=ShiftKeyTable		@If in shift mode, load shift key table
    LDRNE   r1, 	=KeyTable			@Else, load the ordinary key table
    LDR     r0, 	[r1, r0, LSL #2]	@Load the key value from the key table
	
	@Now, check for various special buttons and handle those
	
	CMP		r0,		#KEY_HANGUPBTN
	BEQ		HangupBtnPressed
	
	CMP		r0,		#KEY_SHIFT
	BEQ		ShiftBtnPressed
	
    B      StoreButtonPress				@Button pressed was normal, no
										@special handling behaviour, store the
										@button press
HangupBtnPressed:
    mLoadToReg     r0, HookState			@Check what state phone is in (on or off hook)
    CMP     r0,     #KEY_ONHOOK			@Check the current value
    LDREQ   r0,     =KEY_OFFHOOK		@Toggle it
    LDRNE   r0,     =KEY_ONHOOK
	mStoreFromReg	r0,	r1,	HookState
    B       StoreButtonPress			@Store button press.
ShiftBtnPressed:
	mLoadToReg	r0,	ShiftEnabled
	CMP		r0,		#TRUE
	LDREQ	r0,		=FALSE
	LDRNE	r0,		=TRUE
	mStoreFromReg	r0, r1,	ShiftEnabled
	B 		EndKeypadHandler
StoreButtonPress:
    mStoreFromReg 	r0, r1,	LastKeypress
    LDR 	r0, 	=TRUE
    mStoreFromReg 	r0, r1,	NewKey
    @B 		EndKeypadHandler
EndKeypadHandler:
    mSET_HREG AIC_EOICR, 4
    POP 	{r0-r4, lr}
    SUBS 	pc, 	lr, 	#4
    
.data

LastKeypress:
    .word 	0x00000000
NewKey:
    .word 	0x00000000

ShiftEnabled:
	.word	FALSE

HookState:
    .word 	KEY_ONHOOK

KeyTable:
    .word 	0x00000000         	@0
    .word 	0x00000001         	@1
    .word 	0x00000002         	@2
    .word 	KEY_HANGUPBTN      	@3
    .word 	KEY_SET_SUBNET     	@4
    .word 	KEY_8         	   	@5
    .word 	KEY_5		   		@6
    .word 	KEY_2		        @7
    .word 	KEY_0       		@8
    .word 	KEY_9         		@9
    .word 	KEY_6		        @10
    .word 	KEY_3		        @11
    .word 	KEY_SEND   			@12
    .word 	KEY_MEM_RECALL     	@13
    .word 	KEY_BACKSPACE		@14
    .word 	KEY_ESC				@15
    .word 	KEY_SHIFT         	@16
    .word 	KEY_7         		@17
    .word 	KEY_4         		@18
    .word 	KEY_1	         	@19
	
ShiftKeyTable:
    .word 	0x00000000         	@0
    .word 	0x00000001         	@1
    .word 	0x00000002         	@2
    .word 	KEY_HANGUPBTN       @3
    .word 	KEY_SET_IP	     	@4
    .word 	KEY_8         	   	@5
    .word 	KEY_5		   		@6
    .word 	KEY_2		        @7
    .word 	KEY_SET_GATEWAY		@8
    .word 	KEY_9         		@9
    .word 	KEY_6		        @10
    .word 	KEY_3		        @11
    .word 	KEY_SEND			@12
    .word 	KEY_MEM_SAVE     	@13
    .word 	KEY_BACKSPACE		@14
    .word 	KEY_ESC				@15
    .word 	KEY_SHIFT         	@16
    .word 	KEY_7         		@17
    .word 	KEY_4         		@18
    .word 	KEY_1	         	@19