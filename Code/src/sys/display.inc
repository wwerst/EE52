@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@                                                                            @
@ display.inc                                                                @
@                                                                            @
@                                                                            @
@ Revision History:                                                          @
@                                                                            @
@   2017/06/18  Glen George     Initial revision.                            @
@                                                                            @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@Pin definitions
	.equ	DISP_MOSI,	1
	.equ	DISP_SPCK,	2
	.equ	DISP_CS,	3
	.equ	DISP_A0,	4
	.equ	DISP_BCKLIGHT, 5
	.equ	DISP_RST,	6
	
@SPI Status register bit definitions
	.equ	SPI_SR_TXBUFE,	0x80

@SPI Handler definitions
	.equ	COM_QUEUE_LENGTH,	16
	
@Register definitions

	@ 0000 0000 0000 0000 0000 0000 ---- ---- Reserved
	@ ---- ---- ---- ---- ---- ---- 1--- ---- SWRST
	@ ---- ---- ---- ---- ---- ---- -000 00--
	@ ---- ---- ---- ---- ---- ---- ---- --10 Disable
	@ 0000 0000 0000 0000 0000 0000 1000 0010 
	.equ 	SPI_CR_RESET, 0x00000082
	
	@ 0000 0000 0000 0000 0000 0000 ---- ---- Reserved
	@ ---- ---- ---- ---- ---- ---- 0--- ---- SWRST
	@ ---- ---- ---- ---- ---- ---- -000 00--
	@ ---- ---- ---- ---- ---- ---- ---- --01 Enable
	@ 0000 0000 0000 0000 0000 0000 0000 0001 
	.equ 	SPI_CR_EN, 0x00000001
    
    @ 0000 0000 0000 0000 0000 0000 ---- ---- Reserved
	@ ---- ---- ---- ---- ---- ---- 0--- ---- SWRST
	@ ---- ---- ---- ---- ---- ---- -000 00--
	@ ---- ---- ---- ---- ---- ---- ---- --10 Disable
	@ 0000 0000 0000 0000 0000 0000 0000 0010 
	.equ 	SPI_CR_DIS, 0x00000002
	
	@ 0000 0000 ---- ---- ---- ---- ---- ---- DLYBCS: 0
	@ ---- ---- 0000 ---- ---- ---- ---- ---- Reserved
	@ ---- ---- ---- 1110 ---- ---- ---- ---- PCS: NPCS0 is where display is
	@ ---- ---- ---- ---- 0000 0000 ---- ---- Reserved
	@ ---- ---- ---- ---- ---- ---- 0--- ---- Local Loopback: Disabled
	@ ---- ---- ---- ---- ---- ---- -00- ---- Reserved
	@ ---- ---- ---- ---- ---- ---- ---1 ---- Mode fault detection: Disabled
	@ ---- ---- ---- ---- ---- ---- ---- 1--- DIV32: SPI clocks at MCK/32
	@ ---- ---- ---- ---- ---- ---- ---- -0-- PCSDEC: Chip selects directly connected
	@ ---- ---- ---- ---- ---- ---- ---- --0- PS: Fixed Peripheral select
	@ ---- ---- ---- ---- ---- ---- ---- ---1 MSTR: SPI is in Master mode
	@ 0000 0000 0000 1110 0000 0000 0001 1001
	.equ	SPI_MR_VAL,	0x000E0019
	
	@ 0000 0000 ---- ---- ---- ---- ---- ---- DLYBCT: 0
	@ ---- ---- 0000 0000 ---- ---- ---- ---- DLYBS: 0
	@ ---- ---- ---- ---- 0000 0100 ---- ---- SCBR: SPCK Baudrate = MCK/(2*4) = 5.5 MHz. Device max is 20 MHz
	@ ---- ---- ---- ---- ---- ---- 0000 ---- BITS: 8 bits
	@ ---- ---- ---- ---- ---- ---- ---- 00-- Reserved
	@ ---- ---- ---- ---- ---- ---- ---- --0- NCPHA: 1
	@ ---- ---- ---- ---- ---- ---- ---- ---1 CPOL: 1
	@ 0000 0000 0000 0000 1111 0100 0000 0001
	.equ	SPI_CSR0_VAL, 0x00000401
	
	@ 0000 0000 0000 0000 0000 0000 ---- ---- Reserved
	@ ---- ---- ---- ---- ---- ---- 1000 0000 Only enable ENDTX
	@ 0000 0000 0000 0000 0000 0000 0010 0000 
	.equ	SPI_IER_VAL, 0x00000080
	
	@ 0000 0000 0000 0000 0000 00-- ---- ---- Reserved
	@ ---- ---- ---- ---- ---- --01 ---- ---- Enable Transmit
	@ ---- ---- ---- ---- ---- ---- 0000 00-- Reserved
	@ ---- ---- ---- ---- ---- ---- ---- --10 Disable Receive (no receiving for display)
	@ 0000 0000 0000 0000 0000 0001 0000 0010 
	
	.equ	SPI_DMA_ENABLE, 0x00000101
	
	@ 0000 0000 0000 0000 0000 00-- ---- ---- Reserved
	@ ---- ---- ---- ---- ---- --10 ---- ---- Disable Transmit
	@ ---- ---- ---- ---- ---- ---- 0000 00-- Reserved
	@ ---- ---- ---- ---- ---- ---- ---- --10 Disable Receive
	@ 0000 0000 0000 0000 0000 0001 0000 0010 
	
	.equ	SPI_DMA_DISABLE, 0x00000202
	
	
	@ 0000 0000 0000 0000 0000 0000 0--- ---- Reserved
	@ ---- ---- ---- ---- ---- ---- -11- ---- SCRTYPE: Positive edge
	@ ---- ---- ---- ---- ---- ---- ---0 0--- Reserved
	@ ---- ---- ---- ---- ---- ---- ---- -010 Priority: 2 
	@ 0000 0000 0000 0000 0000 0000 0110 0010 
	.equ	AIC_SMR13_VAL, 0x00000062
	
	@ ---- ---- ---- ---- ---- ---- ---- ---- 
	

@State definitions for the display redrawing

	.equ	STATE_COMMANDS,	0
	.equ	STATE_DATA,	1


@NHD-C12832 Definitions

	.equ	NUM_PAGES,		4
	.equ	NUM_COLS,		128
	.equ	NHD_ON,			0xAF		@Enable display command
	.equ	NHD_OFF,		0xAE		@Disable display command
	.equ	NHD_RMW,		0xE0		@Read-modify-write command
	.equ	NHD_RESET,		0xE2		@Reset command
	.equ	NHD_PAGE_PREF, 	0xB0		@Prefix for page address set command
	.equ	NHD_COLU_PREF, 	0x10		@Prefix for upper column address set command
	.equ	NHD_COLL_PREF, 	0x00		@Prefix for lower column address set command

	
	
	
	
	
	
	
	
	
	
	
	
	