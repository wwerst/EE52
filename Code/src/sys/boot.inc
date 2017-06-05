@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@                                                                            @
@ boot.inc                                                                   @
@                                                                            @
@ Definitions for boot.s file												 @
@                                                                            @
@ Revision History:                                                          @
@                                                                            @
@   2008/04/23  Will Werst    Initial Revision                               @
@                                                                            @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@@@@@ SMC Definitions


	@ SRAM
	@ RWHOLD,RWSETUP 	0x00------
	@ ACSS				0x--00----
	@					0x----30--
	@ 1 Wait state		0x------81
    .equ SMC_CSR1_VAL,	0x00003081
	
	
	@ ROM
	@ RWHOLD,RWSETUP 	0x00------
	@ ACSS				0x--00----
	@					0x----40--
	@ 3 Wait state		0x------83
    .equ SMC_CSR2_VAL, 	0x00004083
	
	@ DRAM
	@ RWHOLD,RWSETUP 	0x00------
	@ ACSS				0x--00----
	@ 8 bit				0x----43--
	@ 6 Wait state		0x------86
    .equ SMC_CSR7_VAL, 	0x00004386
	
@@@@@ PMC Definitions


	.equ PMC_PLLAR_VAL, 0x20160005
    .equ PMC_MCKR_VAL,  0x00000006
    .equ PMC_PCER_VAL,  0x0000000C  @Enable PIOA, PIOB
    .equ PMC_PCK0_VAL,  0x00000006
    .equ PMC_PCK1_VAL,  0x00000019  @MCK source, Pre-scale by 64
	
@@@@@ PIOA Definitions

    .equ PIOA_BSR_VAL,  0x01000000
    .equ PIOA_OER_VAL,  0x01000000
    .equ PIOA_PDR_VAL,  0x01000000
    
@@@@@ PIOB Definitions

    .equ PIOB_ASR_VAL,  0x08000000
    .equ PIOB_OER_VAL,  0x08000000
    .equ PIOB_PDR_VAL,  0x08000000