@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@                                                                            @
@ system.inc                                                                 @
@                                                                            @
@ Include file for the system hardware definitions for the EE/CS 52 VoIP     @
@ phone project.  This file should contain all of the hardware specific      @
@ definitions (chip select register values, control words, etc).             @
@                                                                            @
@ Revision History:                                                          @
@                                                                            @
@   2012/01/29  Glen George     Initial revision.                            @
@                                                                            @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@ Memory definitions
	.equ	SRAM_START,		0x20000000
	.equ	SRAM_SIZE,		0x20000
	
	.equ	DRAM_START,		0x30000000
	.equ	DRAM_SIZE,		0x100000
	
	.equ	ROM_START,		0x80000000
	.equ	ROM_SIZE,		0x80000

@ Stack definitions

@ top of the stack, usually the end of the external SRAM
	.equ	TOP_STACK, 0x00203000
   
@ interrupt stack size (see chapter 13 of the manual)
        .equ	IRQ_STACK_SIZE, 128

@ supervisor mode stack size (see chapter 13 of the manual)
	.equ	SVC_STACK_SIZE,	128

    
@ General Definitions
    .equ    TRUE,   1
    .equ    FALSE,  0