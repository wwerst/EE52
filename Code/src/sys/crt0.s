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
	
Buf1_rx:
	LDR		r0, =Buf1
	BL	update_rx
	CMP	r0,	#TRUE
	BNE	Buf1_rx
	
	LDR 	r0,	=Buf3
	BL	update_tx

Buf2_rx:
	LDR		r0, =Buf2
	BL	update_rx
	CMP	r0,	#TRUE
	BNE	Buf2_rx
	
	LDR 	r0,	=Buf4
	BL	update_tx

Buf3_rx:
	LDR		r0, =Buf3
	BL	update_rx
	CMP	r0,	#TRUE
	BNE	Buf3_rx
	
	LDR 	r0,	=Buf5
	BL	update_tx

Buf4_rx:
	LDR		r0, =Buf4
	BL	update_rx
	CMP	r0,	#TRUE
	BNE	Buf4_rx
	
	LDR 	r0,	=Buf1
	BL	update_tx

Buf5_rx:
	LDR		r0, =Buf5
	BL	update_rx
	CMP	r0,	#TRUE
	BNE	Buf5_rx
	
	LDR 	r0,	=Buf2
	BL	update_tx
	
	
    B loop
    @BL		main			@ run the main function (no arguments)

    B		low_level_init		@ if main returns (shouldn't)
    					@   reinitialize everything and start
					@   over
					
.data

.balign	4
Buf1:
	.skip 256
Buf2:
	.skip 256
Buf3:
	.skip 256
Buf4:
	.skip 256
Buf5:
	.skip 256
.end
