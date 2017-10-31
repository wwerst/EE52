@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@
@
@
@
@
@
@
@
@
@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@ Description:
@
@
@ Table of Contents:
@   - audio_init:
@   - call_start:
@   - call_halt:
@   - update_rx:
@   - update_tx:
@   - setVolume:
@   - audioDemo:
@
@
@
@
@
@ Revision History:
@ Name			Comment					Date
@ Will Werst	Initial version			Some lonely night around 6/10/17
@ Will Werst	Comment					October 2017

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
	mSET_HREG	PMC_PCER,	(1 << 14)       @Enable the peripheral clock
	mSET_HREG	SSC0_CR,	SSC0_CR_VAL     @Setup the serial controller
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
    BL  update_tx
	mRETURNFNC
	
.global call_halt
call_halt:
	mSTARTFNC
    @Clear the counters in all DMA registers for audio
    mSET_HREG	SSC0_RNCR, 0
    mSET_HREG	SSC0_RCR, 0
    mSET_HREG	SSC0_TNCR, 0
    mSET_HREG	SSC0_TCR, 0
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

.global	audioDemo
audioDemo:
	mSTARTFNC
loopAudioDemo:
	Buf1_rx:
	LDR		r0, =Buf1
	BL	update_rx
	CMP	r0,	#TRUE
	BNE	Buf1_rx
	
	LDR 	r0,	=Buf3
	BL	update_tx

Buf2_rx:
	LDR		r0, =Buf2
	BL	update_rx
	CMP	r0,	#TRUE
	BNE	Buf2_rx
	
	LDR 	r0,	=Buf4
	BL	update_tx

Buf3_rx:
	LDR		r0, =Buf3
	BL	update_rx
	CMP	r0,	#TRUE
	BNE	Buf3_rx
	
	LDR 	r0,	=Buf5
	BL	update_tx

Buf4_rx:
	LDR		r0, =Buf4
	BL	update_rx
	CMP	r0,	#TRUE
	BNE	Buf4_rx
	
	LDR 	r0,	=Buf1
	BL	update_tx

Buf5_rx:
	LDR		r0, =Buf5
	BL	update_rx
	CMP	r0,	#TRUE
	BNE	Buf5_rx
	
	LDR 	r0,	=Buf2
	BL	update_tx
	
    B   loopAudioDemo
	mRETURNFNC
	
.data

.balign	4
Buf1:
	.skip 256
Buf2:
	.skip 256
Buf3:
	.skip 256
Buf4:
	.skip 256
Buf5:
	.skip 256
	
.end