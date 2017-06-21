@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@                                                                            @
@ crt0.s                                                                     @
@                                                                            @
@ Initialization file for EE52 ARM VoIP phone project.  It sets up the IRQ   @
@ vector table, initializes the stacks for both the IRQ and System modes,    @
@ sets up the Master Clock, all of the chip selects for external memories,   @
@ and will eventually call all of the intialization functions for each       @
@ hardware block.  Finally it invokes the main user interface code.          @
@                                                                            @
@                                                                            @
@ Revision History:                                                          @
@                                                                            @
@   2008/02/02  Joseph Schmitz  Modified code from Arthur Chang to make it   @
@                               available to the students.                   @
@   2011/01/27  Joseph Schmitz  Split into crt0.s and boot.s.                @
@   2011/01/31  Joseph Schmitz  Removed unused comments.                     @
@   2012/01/24  Glen George     Updated comments, modified included files,   @
@                               and cleaned up the code a little.            @
@   2012/01/29  Glen George     Added comments explaining initialization.    @
@                                                                            @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

.include    "at91rm9200.inc"
.include    "system.inc"
.include	"macro.inc"
.include	"interfac.inc"

.text
.arm

@ In this file you must do at least the following:
@
@   - As you write other functions/code for the various hardware blocks, you
@     will call the initialization functions for them from here as well.



.global low_level_init
low_level_init:
	
	@Uncomment instruction below to prevent ROM code from executing after
	@bootloader runs. This effectively creates a dummy ROM code that does nothing.
	@B low_level_init

@ Stack and IRQ Initialization

    LDR		r0, =TOP_STACK		@ get the location of the top of the stack

    @ put the CPU in interrupt mode and set the stack pointer for this mode
    MSR		cpsr_c, #ARM_MODE_IRQ | I_BIT | F_BIT
    MOV		sp, r0

    @ adjust the starting stack address for the interrupt stack just setup
    SUB		r0, r0, #IRQ_STACK_SIZE

    @ put the CPU in supervisor mode and set the stack pointer for this mode
    MSR		cpsr_c, #ARM_MODE_SVC | I_BIT | F_BIT
    MOV		sp, r0

    @ adjust the starting stack address for the supervisor mode stack just setup
    SUB		r0, r0, #SVC_STACK_SIZE

    @ finally, put the CPU in user mode and set the stack pointer for this mode
    MSR		cpsr_c, #ARM_MODE_USR | F_BIT
    MOV		sp, r0



@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@  user initialization goes here  @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	BL init_system
	BL keypad_init
	BL audio_init
    
loop:
	mLOADTOREG	r4,	Cur_RXBuf
	
	LDR	r0,	=Bufs
	ADD	r0,	r0,	r4,	LSL #8
	BL	update_rx
	CMP	r0,	#TRUE
	ADDEQ	r4,	#1
	CMP		r4, #32
	LDREQ	r4, =0
	mSTOREFROMREG	r4, r0, Cur_RXBuf
	
	mLOADTOREG	r5,	Cur_TXBuf
	LDR	r0, =Bufs
	ADD	r0,	r0,	r5,	LSL #8
	LDR	r1, =AUDIO_BUFLEN
	LDR r2, =0x0007
	PUSH {r0-r3}
	BL setVolume
	POP {r0-r3}
	BL	update_tx
	CMP	r0,	#TRUE
	ADDEQ	r5,	#1
	CMP		r5, #32
	LDREQ	r5, =0
	mSTOREFROMREG	r5,	r0,	Cur_TXBuf
	
	
    B loop
    @BL		main			@ run the main function (no arguments)

    B		low_level_init		@ if main returns (shouldn't)
    					@   reinitialize everything and start
					@   over

setVolume:
	mSTARTFNC
updateValue:
	LDRH r3, [r0,r1]
	ORR	 r3, r3, r2
	STRH r3, [r0,r1]
	SUB r1, #2
	CMP r1, #0
	BGT updateValue
	mRETURNFNC
					
.data
Cur_RXBuf:
	.word 0x00000000
Cur_TXBuf:
	.word 0x00000005
Bufs:
	.skip 32768
.end
