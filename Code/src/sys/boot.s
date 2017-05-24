@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@                                                                              @
@ boot.s                                                                       @
@                                                                              @
@ Bootloader for the EE52 ARM VoIP phone project.  It sets up any registers    @
@ needed to copy the main program from the external parallel ROM to the        @
@ external SRAM.  This includes the following peripherals:                     @
@                                                                              @
@   - Clock                                                                    @
@   - ROM and SRAM chips selects                                               @
@                                                                              @
@ It then copies the main program from the ROM to the SRAM and jumps to the    @
@ beginning of code in the SRAM.                                               @
@                                                                              @
@ Revision History:                                                            @
@                                                                              @
@   2010/02/02  Joseph Schmitz  Modified code from Arthur Chang to make it     @
@                               available to the students.                     @
@                                                                              @
@   2011/01/27  Joseph Schmitz  Split from crt0.s to boot.s                    @
@                                                                              @
@   2011/01/31  Joseph Schmitz  Updated exception vectors to include special   @
@                               word value at ARM vector 6. (see 13.3.2)       @
@                                                                              @
@   2011/02/06  Joseph Schmitz  Added documentation on exception vectors.      @
@                                                                              @
@   2017/05/21  William Werst   Modified to work for this project              @
@                                                                              @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

.include    "at91rm9200.inc"
.include    "system.inc"
.include    "macro.inc"


.text
.arm


@@@ Exception Vectors @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@
@ Start of the IRQ vector table.  This defines the interrupt hander for each
@ type of interrupt.  Must be at the memory address 0x0 (remapped at boot).
@
@ Exception 	            Description
@
@ Reset 	                Occurs when the processor reset pin is asserted. 
@                           This exception is only expected to occur for 
@                           signalling power-up, or for resetting as if the 
@                           processor has just powered up. A soft reset can be 
@                           done by branching to the reset vector (0x0000).
@
@ Undefined Instruction     Occurs if neither the processor, or any attached 
@                           coprocessor, recognizes the currently executing 
@                           instruction.  Software Interrupt (SWI) This is a 
@                           user-defined synchronous interrupt instruction. It 
@                           allows a program running in User mode, for example, 
@                           to request privileged operations that run in 
@                           Supervisor mode, such as an RTOS function.
@
@ Sofwarte Interrupt        Occurs when the processor generates a software 
@                           interrupt.
@
@ Prefetch Abort            Occurs when the processor attempts to execute an 
@                           instruction that has prefetched from an illegal 
@                           address.  
@
@ Data Abort                Occurs when a data transfer instruction attempts to 
@                           load or store data at an illegal address.
@
@ Vector 6                  Used to specify the number of bytes to download from
@                           and external boot memory into internal SRAM on
@                           reset.
@
@ IRQ                       Occurs when the processor external interrupt request 
@                           pin is asserted (LOW) and the I bit in the CPSR is 
@                           clear.
@
@ FIQ                       Occurs when the processor external fast interrupt 
@                           request pin is asserted (LOW) and the F bit in the 
@                           CPSR is clear.
@
@
@ The format is as follows:
@
@   reset:    Reset vector
@   undef:    Undefine instruction
@   swi:      Software interrupt
@   abort:    Prefect abort
@   data:     Data abort
@   btldr:    Defines how much data to download from the boot memory
@   irq:      Normal interrupt (low priority).  Actual ISR address loaded from AIC
@   fiq:      Fast interrupt (high priority)

IRQTable:
.org 0x0

    reset:
        B   _start
    undef:
        B   undef
    swi:
        B   swi
    prefetch:
        B   prefetch
    data:
        B   data
    btldr:
		.word 0x00000000
    irq:
        LDR PC, [PC, #-0xF20]
    fiq:
        B   fiq  



@@@ Startup Code (system reset restarts here) @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
.org 0x20

.global _start
_start:

@ In this file you must do the following (at least for now):
@
@   - Switch to the master clock
@
@   - Wait for it to stabilize.  The datasheet tells you how long this will
@     take.  You will need to force your CPU to do no external memory  
@     operations during this time.  There is an easy way to do this, but
@     think about it and only ask me if you still can't come up with anything.
@
@   - Set up the chip selects for SRAM/ROM
@
@   - As you write other functions/code for the various hardware blocks, you
@     will need to initialize them here as well.


@@@ Clock Initialization @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@Configure PLLA for DIVA = 5, MULA = 22
LDR r0,=0xFFFFFC28
LDR r1,=0x20160005
STR r1, [r0]

@Configure MCK
LSR 0xFFFFFC30, =0x00000006     @MDIV = 00, PRES = 001, CSS = 10

@Configure Peripheral clock

LSR 0xFFFFFC10, =0x00000008
@Configure PCK0
LSR 0xFFFFFC40, =0x00000006
LSR 0xFFFFF670, =0x08000000
LSR 0xFFFFF610, =0x08000000
LSR 0xFFFFF604, =0x08000000
;Enable PCK0 output
LSR 0xFFFFFC00, =0x00000100


@@@ CS Initialization @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



@@@ Future Code for Copying Code from External ROM -> External SRAM @@@@@@@@@@@@


  
@@@ Branch to the Main Body of Code Now Located in the External SRAM @@@@@@@@@@@

    @BL      low_level_init

BootEndLoop:
    B BootEndLoop    
    
.end
