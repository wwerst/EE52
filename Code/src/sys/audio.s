@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@                                                                            @
@ crt0.s                                                                     @
@                                                                            @
@ Initialization file for EE52 ARM VoIP phone project.  It sets up the IRQ   @
@ vector table, initializes the stacks for both the IRQ and System modes,    @
@ sets up the Master Clock, all of the chip selects for external memories,   @
@ and will eventually call all of the intialization functions for each       @
@ hardware block.  Finally it invokes the main user interface code.          @
@                                                                            @
@                                                                            @
@ Revision History:                                                          @
@                                                                            @
@   2008/02/02  Joseph Schmitz  Modified code from Arthur Chang to make it   @
@                               available to the students.                   @
@   2011/01/27  Joseph Schmitz  Split into crt0.s and boot.s.                @
@   2011/01/31  Joseph Schmitz  Removed unused comments.                     @
@   2012/01/24  Glen George     Updated comments, modified included files,   @
@                               and cleaned up the code a little.            @
@   2012/01/29  Glen George     Added comments explaining initialization.    @
@                                                                            @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

.include    "at91rm9200.inc"
.include    "system.inc"
.include	"interfac.inc"
.include	"audio.inc"
.include	"macro.inc"


.text
.arm

.global audio_init
audio_init:
	mSTARTFNC
	mSET_HREG	PMC_PCER,	(1 << 14)
	mSET_HREG	SSC0_CR,	SSC0_CR_VAL
	mSET_HREG	SSC0_CMR,	SSC0_CMR_VAL
	mSET_HREG	SSC0_RCMR,	SSC0_RCMR_VAL
	mSET_HREG	SSC0_RFMR,	SSC0_RFMR_VAL
	mSET_HREG	SSC0_TCMR,	SSC0_TCMR_VAL
	mSET_HREG	SSC0_TFMR,	SSC0_TFMR_VAL
	mSET_HREG	PIOB_ASR,	0xF
	mSET_HREG	PIOB_PDR,	0xF
	mSET_HREG	PIOB_OER,	0xF
	mSET_HREG	SSC0_CR,	0x00000101
	mSET_HREG	SSC0_PTCR,	0x00000101
	mRETURNFNC
	

.global call_start
call_start:
	mSTARTFNC
	mRETURNFNC
	
.global call_halt
call_halt:
	mSTARTFNC
	mRETURNFNC
	
.global update_rx
update_rx:
	mSTARTFNC
	mLOADTOREG	r1,	SSC0_RNCR
	CMP		r1,		#0					@Check if next receive buffer is empty
	LDRNE	r1,		=FALSE				@If memory is not empty
	BNE		endUpdate_RX				@return false since new buffer not needed
	@BEQ	rx_empty
rx_empty:
	mSTOREFROMREG	r0,	r1,	SSC0_RNPR
	mSET_HREG	SSC0_RNCR,	(AUDIO_BUFLEN /2) - 1
	LDR		r0,		=TRUE
endUpdate_RX:
	mRETURNFNC
	
.global update_tx
update_tx:
	mSTARTFNC
	mLOADTOREG	r1,	SSC0_TNCR
	CMP		r1,		#0					@Check if next transmit buffer is empty
	LDRNE	r1,		=FALSE				@If memory is not empty
	BNE		endUpdate_TX				@return false since new buffer not needed
	@BEQ	tx_empty
tx_empty:
	PUSH	{r0-r3}
	LDR		r1,	=(AUDIO_BUFLEN -2)
	LDR		r2,	=AUDIO_VOLUME
	BL		setVolume
	POP		{r0-r3}
	mSTOREFROMREG	r0,	r1,	SSC0_TNPR
	mSET_HREG	SSC0_TNCR,	(AUDIO_BUFLEN / 2) - 1
	LDR		r0,		=TRUE
endUpdate_TX:
	mRETURNFNC

	
setVolume:
	mSTARTFNC
updateValue:
	LDRH r3, [r0,r1]
	ORR	 r3, r3, r2
	STRH r3, [r0,r1]
	SUB r1, #2
	CMP r1, #0
	BGE updateValue
	mRETURNFNC

.data
