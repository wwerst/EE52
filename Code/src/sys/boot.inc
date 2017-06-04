@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@                                                                            @
@ boot.inc                                                                   @
@                                                                            @
@ General control register address definitions for the Atmel AT91RM9200      @
@                                                                            @
@ Revision History:                                                          @
@                                                                            @
@   2008/04/23  Arthur Chang    Initial Revision                             @
@   2010/02/01  Joseph Schmitz  Modified file I received from Arthur Chang   @
@                                  to distribute to students                 @
@   2011/02/13  Glen George     Cleaned up commenting, removed definitions   @
@                                  not related to the AT91RM9200 chip.       @
@                                                                            @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


    .equ SMC_CSR1_VAL, 0x00000000
    .equ SMC_CSR2_VAL, 0x00000000
    .equ SMC_CSR7_VAL, 0x00000000