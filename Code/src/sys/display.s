

.include	"macro.inc"
.include	"display.inc"
.include	"pio.inc"
.include	"at91rm9200.inc"
.include	"system.inc"


.arm
.text

.global display_init
display_init:
	mSTARTFNC
	LDR		r0, =(0xE)			@MOSI, SPCK, NPCS0
	LDR		r1, =PIO_A
	LDR		r2, =(PIO_PERA | PIO_OUTPUT)
	BL		configPIOPin
	
	LDR		r0, =(1 << DISP_A0) | (1 << DISP_BCKLIGHT) | (1 << DISP_RST)
	LDR		r1, =PIO_A
	LDR		r2, =(PIO_NORM | PIO_OUTPUT)
	BL		configPIOPin
	
	LDR		r0,	=FALSE
	BL		setBacklight
	
	mSET_HREG	SPI_CR,	SPI_CR_RESET
	mSET_HREG	SPI_MR, SPI_MR_VAL
	mSET_HREG	SPI_CSR0, SPI_CSR0_VAL
	mSET_HREG	SPI_CR,	SPI_CR_RUN
	mRETURNFNC

.global display_memory_addr
display_memory_addr:
	mSTARTFNC
	mRETURNFNC

.global display_IP
display_IP:
	mSTARTFNC
	mRETURNFNC

.global display_status
display_status:
	mSTARTFNC
	mRETURNFNC



.global redraw
redraw:
	mSTARTFNC
	LDR r0, =DispBuffer
	LDR r1, =(128*32)
	LDR r2, =255
	
fillBuffer:
	STRH r2, [r0,r1]
	SUBS r1, #1
	BPL	fillBuffer
	
	mRETURNFNC

	
@ queueDisplayCommand
@
@ Description: queues the command passed in r0 to be sent to the display.
@
@ Operational Description: 
@
@ Arguments: r0 - command to send over SPI
@
@ Return values: r0 - TRUE if added successfully, FALSE if not added.
@
@ Local variables: 
@
@ Shared variables: 
@
@ Global Variables: 
@
@ Inputs: 
@
@ Outputs: 
@
@ Error Handling: 
@
@ Algorithms: 
@
@ Data Structures: 
@
@ Limitations: 
@
@ Registers Changed: 
@
@ Known Bugs: 
@
@ Special notes: 
@
@ Revision History:
@ Name             Comment              Date
@ Will Werst        Initial version     6/22/2017

sendDisplayCommand:
	mSTARTFNC
	mSTARTCRITCODE						@Enter critical code, r7 used by this macro
	mLOADTOREG	r1, CommandQueueSize
	CMP	r1, #COM_QUEUE_LENGTH
	BLO addCommandToQ
	@B	CommandQFull
CommandQFull:
	LDR	r0,	#FALSE
	B	sDCEndCritCode
addCommandToQ:
	LDR	r2, =CommandQueue
	STR r0, [r2,r1]
	ADD r1, #1
	mSTOREFROMREG r1, r0, CommandQueueSize
	LDR r0, #TRUE
sDCEndCritCode:
	mENDCRITCODE						@Exit critical code, r7 used by this macro
	
	mRETURNFNC

@ setBacklight
@
@ Description: Enables or disables the backlight.
@
@ Operational Description: 
@
@ Arguments: r0 - TRUE if backlight should be enabled, otherwise backlight disabled.
@
@ Return values: 
@
@ Local variables: 
@
@ Shared variables: 
@
@ Global Variables: 
@
@ Inputs: 
@
@ Outputs: 
@
@ Error Handling: 
@
@ Algorithms: 
@
@ Data Structures: 
@
@ Limitations: 
@
@ Registers Changed: 
@
@ Known Bugs: 
@
@ Special notes: 
@
@ Revision History:
@ Name             Comment              Date
@ Will Werst        Initial version     6/22/2017

setBacklight:
	mSTARTFNC
	CMP		r0, #TRUE
	BEQ		backlightOn
	BNE		backlightOff
backlightOn:
	mSET_HREG	PIOA_SODR,	(1 << DISP_BCKLIGHT)
	B		endSetBacklight
backlightOff:
	mSET_HREG	PIOA_CODR,	(1 << DISP_BCKLIGHT)
	B		endSetBacklight
endSetBacklight:
	mRETURNFNC


.data
.balign 4
TextMessage:
	.word 0x00000000

CommandQueueSize:
	.word 0x00000000
CommandQueue:
	.skip	COM_QUEUE_LENGTH
DispBuffer:
	.skip (NUM_COLS*NUM_PAGES)
	
.end