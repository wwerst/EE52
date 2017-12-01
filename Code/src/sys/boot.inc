@Done
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@
@
@                                   Boot.inc
@                       Contains definitions used by boot.s
@
@
@
@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Revision History:
@ Name			Comment					Date
@ Will Werst	Initial version			Some lonely night around 6/10/17
@ Will Werst	Comment					October 2017

@@@@@ SMC Definitions


	@ SRAM
	@ RWHOLD,RWSETUP 	0x00------		1/2 cycle setup and hold
	@ ACSS				0x--00----		Standard chip select waveform
	@					0x----30--		connected to 16-bit device
	@ 1 Wait state		0x------81		Enable 1 wait state
    .equ SMC_CSR1_VAL,	0x00003081
	
    @ DRAM
	@ RWHOLD,RWSETUP 	0x30------ 		3 RWHOLD
	@ ACSS				0x--00----		Standard chip select waveform
	@ 8 bit				0x----43--		Connected to 8-bit device with 3 clock cycles data float
	@ 7 Wait state		0x------87		Enable 7 wait state
    .equ SMC_CSR2_VAL, 	0x30004387
	
	@ ROM
	@ RWHOLD,RWSETUP 	0x00------		1/2 cycle setup and hold
	@ ACSS				0x--00----		Standard chip select waveform
	@					0x----40--		Connected to 8-bit device
	@ 3 Wait state		0x------83		Enable 3 wait state
    .equ SMC_CSR7_VAL, 	0x00004083
	
	
	
@@@@@ PMC Definitions


	.equ PMC_PLLAR_VAL, 0x20153F05  @ MULA = 21 + 1, DIVA = 5, PLLACOUNT =63, OUTA = 00
    .equ PMC_MCKR_VAL,  0x00000006  @0x0000000E for dram
	.equ PMC_PCK0_VAL,	0x00000006
    .equ PMC_PCER_VAL,  0x0000001C  @Enable PIOA, PIOB
    .equ PMC_PCK1_VAL,  0x00000019  @MCK source, Pre-scale by 64
	
	.equ PMC_MCKR_MDIV,	0			@Run cpu 1+1 times faster than MCK
	
@@@@@ PIOA Definitions

    .equ PIOA_BSR_VAL,  0x01000000
    .equ PIOA_OER_VAL,  0x01000000
    .equ PIOA_PDR_VAL,  0x01000000
    
@@@@@ PIOB Definitions

    .equ PIOB_ASR_VAL,  0x08000000
    .equ PIOB_OER_VAL,  0x08000000
    .equ PIOB_PDR_VAL,  0x08000000