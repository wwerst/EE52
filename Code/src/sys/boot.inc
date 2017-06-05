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


	@ PLLA
	@
	
	