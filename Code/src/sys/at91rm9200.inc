@ Done
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@                                                                            @
@ at91rm9200.inc                                                             @
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
@   2017/06/04  Will Werst      Added PCK0                                   @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


@ DMA Definitions
	.equ	DMA_RPR,			0x100			@ Receive Pointer Register
	.equ	DMA_RCR,			0x104			@ Receive Counter Register
	.equ	DMA_TPR,			0x108			@ Transmit Pointer Register
	.equ	DMA_TCR,			0x10C			@ Transmit Counter Register
	.equ	DMA_RNPR,			0x110			@ Receive Next Pointer Register
	.equ	DMA_RNCR,			0x114			@ Receive Next Counter Register
	.equ	DMA_TNPR,			0x118			@ Transmit Next Pointer Register
	.equ	DMA_TNCR,			0x11C			@ Transmit Next Counter Register
	.equ	DMA_PTCR,			0x120			@ Tranfer Control Register
	.equ	DMA_PTSR,			0x124			@ Transfer Status Register


@ System Mode Definitions

    .equ   	ARM_MODE_USR,    0x10                @ User Mode
    .equ   	ARM_MODE_FIQ,    0x11                @ FIQ Mode
    .equ   	ARM_MODE_IRQ,    0x12                @ IRQ Mode
    .equ   	ARM_MODE_SVC,    0x13                @ Supervisor Mode
    .equ   	ARM_MODE_ABT,    0x17                @ Abort Mode
    .equ   	ARM_MODE_UND,    0x1B                @ Undefined Mode
    .equ   	ARM_MODE_SYS,    0x1F                @ System Mode
    .equ   	I_BIT,           0x80                @ Interrupts disabled
    .equ   	F_BIT,           0x40                @ Fast Interrupts disabled


@ Static Memory Controller Definitions

    .equ    SMCBase,        0xFFFFFF70          @ base address

    .equ    SMC_CSR0,       SMCBase + 0x0       @ Chip Select 0 Register
    .equ    SMC_CSR1,       SMCBase + 0x4       @ Chip Select 1 Register
    .equ    SMC_CSR2,       SMCBase + 0x8       @ Chip Select 2 Register
    .equ    SMC_CSR3,       SMCBase + 0xC       @ Chip Select 3 Register
    .equ    SMC_CSR4,       SMCBase + 0x10      @ Chip Select 4 Register
    .equ    SMC_CSR5,       SMCBase + 0x14      @ Chip Select 5 Register
    .equ    SMC_CSR6,       SMCBase + 0x18      @ Chip Select 6 Register
    .equ    SMC_CSR7,       SMCBase + 0x1C      @ Chip Select 7 Register

@ Parallel I/O Definitions
	.equ    PIO_PER,       0x0      			@ PIO Enable
    .equ    PIO_PDR,       0x4      			@ PIO Disable
    .equ    PIO_OER,       0x10     			@ PIO Output Enable
	.equ	PIO_ODR,	   0x14					@ PIO Output Disable
	.equ	PIO_SODR,	   0x30					@ PIO Set Output data register
	.equ	PIO_CODR,	   0x34					@ PIO Clear Output data register
    .equ    PIO_PDSR,      0x3C     			@ Pin Data Status
	.equ	PIO_IER,	   0x40					@ Interrupt Enable
	.equ	PIO_IDR,	   0x44					@ Interrupt Disable
    .equ    PIO_IMR,       0x48     			@ IRQ Mask
	.equ	PIO_ISR,	   0x4C					@ IRQ Status
    .equ    PIO_ASR,       0x70     			@ PIO Peripheral A Select
    .equ    PIO_BSR,       0x74     			@ PIO Peripheral B Select

@ Parallel I/O A Definintions

    .equ    PIOABase,       0xFFFFF400          @ base address
    .equ    PIOA_PDSR,      PIOABase + PIO_PDSR @ Pin Data Status
	.equ	PIOA_SODR,		PIOABase + PIO_SODR	@ Set Output Data Register
	.equ	PIOA_CODR,		PIOABase + PIO_CODR	@ Clear Output Data Register

@ Parallel I/O B Definintions

    .equ    PIOBBase,       0xFFFFF600          @ base address
	.equ	PIOB_ASR,		PIOBBase + PIO_ASR	@ Peripheral A Select Register
	.equ	PIOB_PDR,		PIOBBase + PIO_PDR	@ Disable Register
	.equ	PIOB_OER,		PIOBBase + PIO_OER	@ Output Enable Register

@ Parallel I/O C Definintions

    .equ    PIOCBase,       0xFFFFF800          @ base address
    .equ    PIOC_PDSR,      PIOCBase + PIO_PDSR @ PIO Pin Data Status Register
    .equ    PIOC_ISR,       PIOCBase + PIO_ISR  @ IRQ Status
	.equ	PIOC_IER,		PIOCBase + PIO_IER	@ Interrupt Enable Register

@ Advanced Interrupt Ccontroller Definitions

    .equ    AICBase,        0xFFFFF000          @ base address
    
	.equ    AIC_SMR1,       AICBase + 0x04      @ System: Source Mode 1
    .equ    AIC_SVR1,       AICBase + 0x84      @ System: Source Vector 1
    .equ    AIC_SMR4,       AICBase + 0x10      @ PIOC: Source Mode 4
    .equ    AIC_SVR4,       AICBase + 0x90      @ PIOC: Source Vector 4
	.equ	AIC_SMR13,		AICBase + 0x34		@ SPI: Source Vector 13
	.equ	AIC_SVR13,		AICBase + 0xB4		@ SPI: Source Vector 13
    .equ    AIC_SMR14,      AICBase + 0x38      @ SSC0: Source Mode 14 
    .equ    AIC_SVR14,      AICBase + 0xB8      @ SSC0: Source Vector 14
    .equ    AIC_SMR17,      AICBase + 0x44      @ TC0: Source Mode 17
    .equ    AIC_SVR17,      AICBase + 0xC4      @ TC0: Source Vector 17
    .equ    AIC_SMR18,      AICBase + 0x44      @ TC1: Source Mode 18
    .equ    AIC_SVR18,      AICBase + 0xC4      @ TC1: Source Vector 18
    .equ    AIC_SMR24,      AICBase + 0x60      @ EMAC: Source Mode 24
    .equ    AIC_SVR24,      AICBase + 0xE0      @ EMAC: Source Vector 24
    .equ    AIC_SMR25,      AICBase + 0x64      @ IRQ0: Source Mode 25
    .equ    AIC_SVR25,      AICBase + 0xE4      @ IRQ0: Source Vector 25
    .equ    AIC_SMR26,      AICBase + 0x68      @ IRQ1: Source Mode 26
    .equ    AIC_SVR26,      AICBase + 0xE8      @ IRQ1: Source Vector 26
    .equ    AIC_ISR,        AICBase + 0x108     @ Interrupt Status
    .equ    AIC_IMR,        AICBase + 0x110     @ Interrupt Mask
    .equ    AIC_IPR,        AICBase + 0x10C     @ Interrupt Pending
    .equ    AIC_IECR,       AICBase + 0x120     @ Interrupt Enable Command
    .equ    AIC_IDCR,       AICBase + 0x124     @ Interrupt Disable Command
    .equ    AIC_ICCR,       AICBase + 0x128     @ Interrupt Clear Command
    .equ    AIC_EOICR,      AICBase + 0x130     @ End of Interrupt Command


@ Power Management Controller Definitions
   
    .equ    PMCBase,        0xFFFFFC00          @ base address

    .equ    PMC_SCER,       PMCBase + 0x0       @ System Clock Enable
    .equ    PMC_PCER,       PMCBase + 0x10      @ Peripheral Clock Enable
    .equ    PMC_MOR,        PMCBase + 0x20      @ Main Oscillator register
    .equ    PMC_PLLAR,      PMCBase + 0x28      @ PLL A Control
    .equ    PMC_PLLBR,      PMCBase + 0x2C      @ PLL B Control
    .equ    PMC_MCKR,       PMCBase + 0x30      @ Master Clock
    .equ    PMC_PCK0,       PMCBase + 0x40      @ Programmable Clock 0
    .equ    PMC_PCK1,       PMCBase + 0x44      @ Programmable Clock 1
    .equ    PMC_SR,         PMCBase + 0x68      @ Status Register


@ Serial Synchronous Controller 0 Definitions

    .equ    SSC0Base,       0xFFFD0000          @ base address

    .equ    SSC0_CR,        SSC0Base + 0x0      @ Control
    .equ    SSC0_CMR,       SSC0Base + 0x4      @ Clock Mode
    .equ    SSC0_RCMR,      SSC0Base + 0x10     @ Receive Clock Mode
    .equ    SSC0_RFMR,      SSC0Base + 0x14     @ Receive Frame Mode
    .equ    SSC0_TCMR,      SSC0Base + 0x18     @ Transmit Clock Mode
    .equ    SSC0_TFMR,      SSC0Base + 0x1C     @ Transmit Frame Mode
    .equ    SSC0_RHR,       SSC0Base + 0x20     @ Receive Holding
    .equ    SSC0_THR,       SSC0Base + 0x24     @ Transmit Holding
    .equ    SSC0_SR,        SSC0Base + 0x40     @ Status 
    .equ    SSC0_IER,       SSC0Base + 0x44     @ Interrupt Enable
    .equ    SSC0_IDR,       SSC0Base + 0x48     @ Interrupt Disable
	.equ	SSC0_RPR,		SSC0Base + DMA_RPR	@ Receive Pointer Register
	.equ	SSC0_RCR,		SSC0Base + DMA_RCR	@ Receive Counter Register
	.equ	SSC0_TPR,		SSC0Base + DMA_TPR	@ Transmit Pointer Register
	.equ	SSC0_TCR,		SSC0Base + DMA_TCR	@ Transmit Counter Register
	.equ	SSC0_RNPR,		SSC0Base + DMA_RNPR	@ Receive Next Pointer Register
	.equ	SSC0_RNCR,		SSC0Base + DMA_RNCR	@ Receive Next Counter Register
	.equ	SSC0_TNPR,		SSC0Base + DMA_TNPR	@ Transmit Next Pointer Register
	.equ	SSC0_TNCR,		SSC0Base + DMA_TNCR	@ Transmit Next Counter Register
	.equ	SSC0_PTCR,		SSC0Base + DMA_PTCR	@ Transfer Control Register
	.equ	SSC0_PTSR,		SSC0Base + DMA_PTSR	@ Transfer Status Register
	

@ SPI Definitions
	
	.equ	SPIBase,		0xFFFE0000			@ base address
	
	.equ	SPI_CR,			SPIBase + 0x0		@ SPI Control Register
	.equ	SPI_MR,			SPIBase + 0x4		@ SPI Mode Register
	.equ	SPI_RDR,		SPIBase + 0x8		@ Receive Data Register
	.equ	SPI_TDR,		SPIBase + 0xC		@ Transmit Data Register
	.equ	SPI_SR,			SPIBase + 0x10		@ Status Register
	.equ	SPI_IER,		SPIBase + 0x14		@ Interrupt Enable Register
	.equ	SPI_IDR,		SPIBase + 0x18		@ Interrupt Disable Register
	.equ	SPI_IMR,		SPIBase + 0x1C		@ Interrupt Mask Register
	.equ	SPI_CSR0,		SPIBase + 0x30		@ Chip Select 0 Register
	
	.equ	SPI_RPR,		SPIBase + DMA_RPR	@ Receive Pointer Register
	.equ	SPI_RCR,		SPIBase + DMA_RCR	@ Receive Counter Register
	.equ	SPI_TPR,		SPIBase + DMA_TPR	@ Transmit Pointer Register
	.equ	SPI_TCR,		SPIBase + DMA_TCR	@ Transmit Counter Register
	.equ	SPI_RNPR,		SPIBase + DMA_RNPR	@ Receive Next Pointer Register
	.equ	SPI_RNCR,		SPIBase + DMA_RNCR	@ Receive Next Counter Register
	.equ	SPI_TNPR,		SPIBase + DMA_TNPR	@ Transmit Next Pointer Register
	.equ	SPI_TNCR,		SPIBase + DMA_TNCR	@ Transmit Next Counter Register
	.equ	SPI_PTCR,		SPIBase + DMA_PTCR	@ Transfer Control Register
	.equ	SPI_PTSR,		SPIBase + DMA_PTSR	@ Transfer Status Register
	
	
@ System Timer Definitions

	.equ	STBase,			0xFFFFFD00			@ base address
	
	.equ	ST_CR,			STBase + 0x0 		@ Control Register
	.equ	ST_PIMR,		STBase + 0x4 		@ Period Interval Mode Register
	.equ	ST_SR,			STBase + 0x10		@ Status Register
	.equ	ST_IER,			STBase + 0x14		@ Interrupt Enable Register
	.equ	ST_IDR,			STBase + 0x18 		@ Interrupt Disable Register
	.equ	ST_IMR,			STBase + 0x1C 		@ Interrupt Mask Register

@ Real Time Clock Definitions
	
	.equ	RTCBase,		0xFFFFFE00			@ base address
	.equ	RTC_SR,			RTCBase + 0x18		@ Status Register

@ Timer Counter 0 Definitions

    .equ    TC0Base,        0xFFFA0000          @ base address

    .equ    TC0_CCR,        TC0Base + 0x0       @ Channel Control
    .equ    TC0_CMR,        TC0Base + 0x4       @ Channel Mode
    .equ    TC0_RC,         TC0Base + 0x1C      @ Register C
    .equ    TC0_CV,         TC0Base + 0x10      @ Counter Value
    .equ    TC0_SR,         TC0Base + 0x20      @ Status Register
    .equ    TC0_IER,        TC0Base + 0x24      @ Interrupt Enable
    .equ    TC0_IDR,        TC0Base + 0x28      @ Interrupt Disable


@ Timer Counter 1 Definitions

    .equ    TC1Base,        0xFFFA0040          @ base address

    .equ    TC1_CCR,        TC1Base + 0x0       @ Channel Control
    .equ    TC1_CMR,        TC1Base + 0x4       @ Channel Mode
    .equ    TC1_RC,         TC1Base + 0x1C      @ Register C
    .equ    TC1_CV,         TC1Base + 0x10      @ Counter Value
    .equ    TC1_SR,         TC1Base + 0x20      @ Status Register
    .equ    TC1_IER,        TC1Base + 0x24      @ Interrupt Enable
    .equ    TC1_IDR,        TC1Base + 0x28      @ Interrupt Disable


@ EMAC Definitions

    .equ    EMAC_RSR,       0xFFFBC020          @ Receive Status
    .equ    EMAC_MAN,       0xFFFBC034          @ PHY Maintenance
    .equ    EMAC_HSH,       0xFFFBC090          @ Hash Address High[63:32]
    .equ    EMAC_MCOL,      0xFFFBC048          @ Multiple Collision Frame
    .equ    EMAC_ISR,       0xFFFBC024          @ Interrupt Status Register
    .equ    EMAC_IER,       0xFFFBC028          @ Interrupt Enable
    .equ    EMAC_SA2H,      0xFFFBC0A4          @ Specific Address 2 High, Last 2 bytes
    .equ    EMAC_HSL,       0xFFFBC094          @ Hash Address Low[31:0]
    .equ    EMAC_LCOL,      0xFFFBC05C          @ Late Collision
    .equ    EMAC_OK,        0xFFFBC04C          @ Frames Received OK
    .equ    EMAC_CFG,       0xFFFBC004          @ Network Configuration
    .equ    EMAC_SA3L,      0xFFFBC0A8          @ Specific Address 3 Low, First 4 bytes
    .equ    EMAC_SEQE,      0xFFFBC050          @ Frame Check Sequence Error
    .equ    EMAC_ECOL,      0xFFFBC060          @ Excessive Collision
    .equ    EMAC_ELR,       0xFFFBC070          @ Excessive Length Error
    .equ    EMAC_SR,        0xFFFBC008          @ Network Status
    .equ    EMAC_RBQP,      0xFFFBC018          @ Receive Buffer Queue Pointer
    .equ    EMAC_CSE,       0xFFFBC064          @ Carrier Sense Error
    .equ    EMAC_RJB,       0xFFFBC074          @ Receive Jabber
    .equ    EMAC_USF,       0xFFFBC078          @ Undersize Frame
    .equ    EMAC_IDR,       0xFFFBC02C          @ Interrupt Disable
    .equ    EMAC_SA1L,      0xFFFBC098          @ Specific Address 1 Low, First 4 bytes
    .equ    EMAC_IMR,       0xFFFBC030          @ Interrupt Mask
    .equ    EMAC_FRA,       0xFFFBC040          @ Frames Transmitted OK
    .equ    EMAC_SA3H,      0xFFFBC0AC          @ Specific Address 3 High, Last 2 bytes
    .equ    EMAC_SA1H,      0xFFFBC09C          @ Specific Address 1 High, Last 2 bytes
    .equ    EMAC_SCOL,      0xFFFBC044          @ Single Collision Frame
    .equ    EMAC_ALE,       0xFFFBC054          @ Alignment Error
    .equ    EMAC_TAR,       0xFFFBC00C          @ Transmit Address
    .equ    EMAC_SA4L,      0xFFFBC0B0          @ Specific Address 4 Low, First 4 bytes
    .equ    EMAC_SA2L,      0xFFFBC0A0          @ Specific Address 2 Low, First 4 bytes
    .equ    EMAC_TUE,       0xFFFBC068          @ Transmit Underrun Error
    .equ    EMAC_DTE,       0xFFFBC058          @ Deferred Transmission Frame
    .equ    EMAC_TCR,       0xFFFBC010          @ Transmit Control
    .equ    EMAC_CTL,       0xFFFBC000          @ Network Control
    .equ    EMAC_SA4H,      0xFFFBC0B4          @ Specific Address 4 High, Last 2 bytes
    .equ    EMAC_CDE,       0xFFFBC06C          @ Code Error
    .equ    EMAC_SQEE,      0xFFFBC07C          @ SQE Test Error
    .equ    EMAC_TSR,       0xFFFBC014          @ Transmit Status
    .equ    EMAC_DRFC,      0xFFFBC080          @ Discarded RX Frame


@ General Definitions

    .equ    WORD_SIZE,      0x4                 @ size of a word in bytes
    .equ    HALFWORD_SIZE,  0x2                 @ size of a halfword in bytes
    .equ    BYTE_SIZE,      0x1                 @ size of a byte in bytes
