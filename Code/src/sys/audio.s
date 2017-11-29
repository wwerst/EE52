@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@
@
@ Audio.s
@ 
@ Description: Contains code for controlling the audio component of
@ the EE52 VoIP Project
@
@ Table of Contents:
@   - audio_init: Call to initialize this code file before
@                   calling anything else
@   - call_start: Call to initiate a call
@   - call_halt:  Call to halt a call that has been started with call_start
@   - update_rx:  Handler used to update the receive buffer
@   - update_tx:  Handler used to update the transmit buffer
@   - setVolume:  Call to set the volume
@   - audioDemo:  A test function used to demo the audio code on its own,
@                 by looping the audio input back to the audio output.
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
	mSET_HREG	SSC0_CMR,	SSC0_CMR_VAL    @Setup the serial clock rate
	mSET_HREG	SSC0_RCMR,	SSC0_RCMR_VAL   @Setup receive clock mode
	mSET_HREG	SSC0_RFMR,	SSC0_RFMR_VAL   @Setup receive frame mode
	mSET_HREG	SSC0_TCMR,	SSC0_TCMR_VAL   @Setup transmit clock mode
	mSET_HREG	SSC0_TFMR,	SSC0_TFMR_VAL   @Setup transmit frame mode
	mSET_HREG	PIOB_ASR,	0xF             @Setup serial output pins
	mSET_HREG	PIOB_PDR,	0xF             @Setup serial output pins
	mSET_HREG	PIOB_OER,	0xF             @Setup serial output pin
	mSET_HREG	SSC0_CR,	0x00000101      @Enable serial
	mSET_HREG	SSC0_PTCR,	0x00000101      @Enable DMA
	mRETURNFNC
	

.global call_start
call_start:
	mSTARTFNC                               @Call start function macro
    BL  update_tx
	mRETURNFNC                              @Call return from function macro
	
.global call_halt
call_halt:
	mSTARTFNC                               @Call start function macro
    @Clear the counters in all DMA registers for audio
    mSET_HREG	SSC0_RNCR, 0                @Clear the counter register for the
                                            @next DMA buffer receive
    mSET_HREG	SSC0_RCR, 0                 @Clear the counter register for the
                                            @buffer currently being received
    mSET_HREG	SSC0_TNCR, 0                @Clear the counter register for the
                                            @next DMA buffer transmit
    mSET_HREG	SSC0_TCR, 0                 @Clear the counter register for the
                                            @buffer currently being transmitted
	mRETURNFNC                              @Call return from function macro
	
.global update_rx
update_rx:
	mSTARTFNC                           @Call start function macro
	mLOADTOREG	r1,	SSC0_RNCR           @Load the length of the next receive
                                        @buffer currently queued up
	CMP		r1,		#0					@Check if next receive buffer is empty
	LDRNE	r1,		=FALSE				@If memory is not empty
                                        @Post-demo comment: I'm pretty sure this
                                        @should have been r0, not sure why this
                                        @worked
	BNE		endUpdate_RX				@return false since new buffer not needed
	@BEQ	rx_empty                    @Call return function macro
rx_empty:
	mSTOREFROMREG	r0,	r1,	SSC0_RNPR   @Store r0 (next pointer) into next
                                        @pointer register
	mSET_HREG	SSC0_RNCR,	(AUDIO_BUFLEN /2) - 1 @Store buffer length in half-words
	LDR		r0,		=TRUE               @Return success
endUpdate_RX:
	mRETURNFNC
	
.global update_tx
update_tx:
	mSTARTFNC
	mLOADTOREG	r1,	SSC0_TNCR
	CMP		r1,		#0					@Check if next transmit buffer is empty
	LDRNE	r1,		=FALSE				@If memory is not empty
                                        @Post-demo comment: I'm pretty sure this
                                        @should have been r0, not sure why this
                                        @worked
	BNE		endUpdate_TX				@return false since new buffer not needed
	@BEQ	tx_empty
tx_empty:
	PUSH	{r0-r3}                     @Store registers to free up for temp
	LDR		r1,	=(AUDIO_BUFLEN -2)      @Load buffer length
	LDR		r2,	=AUDIO_VOLUME           @Load the volume setpoint
	BL		setVolume                   @Set volume
	POP		{r0-r3}                     @Restore register
	mSTOREFROMREG	r0,	r1,	SSC0_TNPR   @Save next transmit register
	mSET_HREG	SSC0_TNCR,	(AUDIO_BUFLEN / 2) - 1 @Save length of next transmit
                                        @Register in half-words
	LDR		r0,		=TRUE               @Return true
endUpdate_TX:
	mRETURNFNC

	
setVolume:
	mSTARTFNC
updateValue:
	LDRH r3, [r0,r1]               @Get byte of audio
	ORR	 r3, r3, r2                @Mask out the high bits determined by volume
	STRH r3, [r0,r1]               @Store byte of audio
	SUB r1, #2                     @Decrement to next byte
	CMP r1, #0                     @Check if at last byte
	BGE updateValue                @If not, continue
	mRETURNFNC                     @Return


@Demo function to loopback audio with delay
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