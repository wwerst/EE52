@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@
@
@                                   pio.inc
@                       Contains definitions used by pio.s
@
@
@
@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@ Description: Defines register values used by the pio controller
@                   for this project
@
@ Revision History:
@ Name			Comment					Date
@ Will Werst	Initial version			Some lonely night around 6/10/17
@ Will Werst	Comment					October 2017

@PIO Bank definitions
	.equ	PIO_A,		0           @Constant for specifying PIOA in config func
	.equ	PIO_B,		1           @Constant for specifying PIOB in config func
	.equ	PIO_C,		2           @Constant for specifying PIOA in config func
	
@PIO pin configuration definitions
@	Bit use for defining configurations:
@	Bit [1:0] 	- PIO type (PIO_NORM, PIO_PerA, PIO_PerB)
@	Bit [2]		- PIO input or output (PIO_OUTPUT)
@	Bit [3]		- PIO interrupt	enable (PIO_INT_EN)
	
	@ Bit [1:0]
	.equ	PIO_TYPE_MASK,	0x3		@Used to mask out PIO type config bits
	.equ	PIO_NORM,	0x0
	.equ	PIO_PERA,	0x1
	.equ	PIO_PERB,	0x2
	
	@ Bit [2]
	.equ	PIO_OUTPUT_MASK,	0x4	@Used to mask out PIO output config bits
	.equ	PIO_OUTPUT,	0x4
	
	@ Bit [3]
	.equ	PIO_INT_MASK,		0x8 @Used to mask out PIO interrupt config bits
	.equ	PIO_INT_EN,	0x8