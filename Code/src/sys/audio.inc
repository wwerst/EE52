@ Done
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@
@
@                                   Audio.inc
@                       Contains definitions used by audio.s
@
@
@
@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@ Description: Defines register values used by the audio system.
@
@ Revision History:
@ Name			Comment					Date
@ Will Werst	Initial version			Some lonely night around 6/10/17
@ Will Werst	Comment					October 2017

    @ 0000 0000 0000 0000 ---- ---- ---- ----       Reserved
    @ ---- ---- ---- ---- 1--- ---- ---- ----       Software reset
    @ ---- ---- ---- ---- -000 00-- ---- ----       Reserved
    @ ---- ---- ---- ---- ---- --01 ---- ----       Enable transmit
    @ ---- ---- ---- ---- ---- ---- 0000 00--       Reserved
    @ ---- ---- ---- ---- ---- ---- ---- --01       Enable receive
	.equ	SSC0_CR_VAL, 0x00008101
    
	.equ	SSC0_CMR_VAL, 0x0000000B				@CLK = 48 MHz / (2*(10+1) = 2 MHz
	@ 0111 1111 ---- ---- ---- ---- ---- ----		Period: 2*(127+1) = 256 bits
	@ ---- ---- 0000 0000 ---- ---- ---- ----		STTDLY: No delay
	@ ---- ---- ---- ---- 0000 ---- ---- ----		Reserved
	@ ---- ---- ---- ---- ---- 0001 ---- ----		START: Transmit Start
	@ ---- ---- ---- ---- ---- ---- 00-- ----		Reserved
	@ ---- ---- ---- ---- ---- ---- --0- ----		CKI: Rising edge
	@ ---- ---- ---- ---- ---- ---- ---0 00--		CKO: No clock output
	@ ---- ---- ---- ---- ---- ---- ---- --01		CKS: TK Clock signal
	@ ---- ---- ---- ---- ---- ---- ---- ----		Reserved
	@ 0111 1111 0000 0001 0000 0001 0000 0001
	.equ	SSC0_RCMR_VAL, 0x7F000101			@Period 256 bits, 0 start delay, start on transmit, Clock on falling edge, TK Clock signal is clock
	
	
	@ 0000 000- ---- ---- ---- ---- ---- ----		Reserved
	@ ---- ---0 ---- ---- ---- ---- ---- ----		FSEDGE: Positive Edge
	@ ---- ---- 0--- ---- ---- ---- ---- ----		Reserved
	@ ---- ---- -000 ---- ---- ---- ---- ----		FSOS: None
	@ ---- ---- ---- 0000 ---- ---- ---- ----		FSLEN: 0
	@ ---- ---- ---- ---- 0000 ---- ---- ----		Reserved
	@ ---- ---- ---- ---- ---- 0000 ---- ----		DATNB: 0+1
	@ ---- ---- ---- ---- ---- ---- 1--- ----		MSBF: Most significant Bit first
	@ ---- ---- ---- ---- ---- ---- -0-- ----		Reserved
	@ ---- ---- ---- ---- ---- ---- --0- ----		LOOP: False
	@ ---- ---- ---- ---- ---- ---- ---0 1111		DATLEN: 16 bits per bit stream
	@ 0000 0000 0010 0000 0000 0000 1000 1111
	.equ	SSC0_RFMR_VAL, 0x0020008F			@Positive edge frame sync, positive pulse 1 clock, 16 DATNB

	@ 0111 1111 ---- ---- ---- ---- ---- ----		Period: 2*(127+1) = 256 bits
	@ ---- ---- 0000 0000 ---- ---- ---- ----		STTDLY: No delay
	@ ---- ---- ---- ---- 0000 ---- ---- ----		Reserved
	@ ---- ---- ---- ---- ---- 0011 ---- ----		START: High TF Signal
	@ ---- ---- ---- ---- ---- ---- 00-- ----		Reserved
	@ ---- ---- ---- ---- ---- ---- --1- ----		CKI: Rising edge
	@ ---- ---- ---- ---- ---- ---- ---0 01--		CKO: Continuous Transmit Clock
	@ ---- ---- ---- ---- ---- ---- ---- --00		CKS: Divided clock
	@ ---- ---- ---- ---- ---- ---- ---- ----		Reserved
	@ 0111 1111 0000 0000 0000 0011 0020 0100
	.equ	SSC0_TCMR_VAL, 0x7F000324

	@ 0000 000- ---- ---- ---- ---- ---- ----		Reserved
	@ ---- ---0 ---- ---- ---- ---- ---- ----		FSEDGE: Positive Edge
	@ ---- ---- 1--- ---- ---- ---- ---- ----		FSDEN: Shift during transmit frame sync signal
	@ ---- ---- -010 ---- ---- ---- ---- ----		FSOS: Positive pulse
	@ ---- ---- ---- 0000 ---- ---- ---- ----		FSLEN: 0
	@ ---- ---- ---- ---- 0000 ---- ---- ----		Reserved
	@ ---- ---- ---- ---- ---- 0000 ---- ----		DATNB: 0+1
	@ ---- ---- ---- ---- ---- ---- 1--- ----		MSBF: Most significant Bit first
	@ ---- ---- ---- ---- ---- ---- -0-- ----		Reserved
	@ ---- ---- ---- ---- ---- ---- --0- ----		DATDEF: 0 is default bit
	@ ---- ---- ---- ---- ---- ---- ---0 1111		DATLEN: 16 bits per bit stream
	@ 0000 0000 1010 0000 0000 0000 0000 1111
	.equ	SSC0_TFMR_VAL, 0x0020008F
	
	
	
	.equ	AUDIO_VOLUME,	0x07					@Define system volume