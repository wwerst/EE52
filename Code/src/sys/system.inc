@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@
@
@                                   system.inc
@                       Contains general system-level definitions
@                           and definitions used by system.s
@
@
@
@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@ Description: Defines system-level constants, like TRUE or FALSE, and
@               also defines constants used by system.s
@
@ Revision History:
@ Name			Comment					Date
@ Will Werst	Initial version			Some lonely night around 6/10/17
@ Will Werst	Comment					October 2017

@ Memory definitions
	.equ	SRAM_START,		0x20000000
	.equ	SRAM_SIZE,		0x20000
	
	.equ	DRAM_START,		0x30000000
	.equ	DRAM_SIZE,		0x100000
	.equ	DRAM_NUM_ROWS,	1024
	.equ	DRAM_MILLIS_PER_REF, 256
	.equ	ROM_START,		0x80000000
	.equ	ROM_SIZE,		0x80000

@ Stack definitions

@ top of the stack, usually the end of the external SRAM
	.equ	TOP_STACK, 0x2001FFF0
   
@ interrupt stack size (see chapter 13 of the manual)
        .equ	IRQ_STACK_SIZE, 128

@ supervisor mode stack size (see chapter 13 of the manual)
	.equ	SVC_STACK_SIZE,	128

    
@ General Definitions
    .equ    TRUE,   1
    .equ    FALSE,  0
	
	
@ System function definitions
	@ timer definitions
	.equ	SLCK_CNT_SEC,	32768
	.equ	PIT_INTERVAL,	33
	.equ	MILLIS_IN_SEC,	1000