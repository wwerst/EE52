

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
	mSET_HREG	PMC_PCER,	(1 << 13)
	LDR		r0, =(0xE)			@MOSI, SPCK, NPCS0
	LDR		r1, =PIO_A
	LDR		r2, =(PIO_PERA | PIO_OUTPUT)
	BL		configPIOPin
	
	LDR		r0, =(1 << DISP_A0) | (1 << DISP_BCKLIGHT) | (1 << DISP_RST)
	LDR		r1, =PIO_A
	LDR		r2, =(PIO_NORM | PIO_OUTPUT)
	BL		configPIOPin
	
	mSET_HREG PIOA_CODR,	(1 << DISP_RST)
	LDR r0, =0xFFFF
count:
	SUB r0, #1
	CMP r0, #0
	BNE	count
	mSET_HREG PIOA_SODR,	(1 << DISP_RST)
	
	LDR		r0,	=FALSE
	BL		setBacklight
	
	@Enqueue all of the commands for initializing display now
	LDR		r0,	=NHD_RESET
	BL		queueDisplayCommand
	@LDR		r0,	=NHD_ON
	@BL		queueDisplayCommand
	@LDR		r0,	=0x2F
	@BL		queueDisplayCommand
	@LDR		r0,	=0x26
	@BL		queueDisplayCommand
	@LDR		r0, =NHD_RMW
	@BL		queueDisplayCommand
	@LDR		r0, =0xA4
	@BL		queueDisplayCommand
	@LDR		r0, =0x81
	@BL		queueDisplayCommand
	@LDR		r0, =0x2F
	@BL		queueDisplayCommand
	
	LDR		r0,	=0xA0
	BL		queueDisplayCommand
	LDR		r0,	=0xAE
	BL		queueDisplayCommand

	LDR		r0,	=0xC0
	BL		queueDisplayCommand
	LDR		r0,	=0xA2
	BL		queueDisplayCommand
	
	LDR		r0,	=0x2F
	BL		queueDisplayCommand
	LDR		r0,	=0x26
	BL		queueDisplayCommand
	
	LDR		r0,	=0x81
	BL		queueDisplayCommand
	LDR		r0,	=0x2F
	BL		queueDisplayCommand
	
	mSET_HREG	SPI_CR,	SPI_CR_RESET
	mSET_HREG	SPI_MR, SPI_MR_VAL
	mSET_HREG	SPI_CSR0, SPI_CSR0_VAL
	mSET_HREG	AIC_SVR13, displayHandler
	mSET_HREG	AIC_SMR13, AIC_SMR13_VAL
	mSET_HREG	AIC_IECR, (1 << 13)
	mSET_HREG	SPI_CR,	SPI_CR_RUN
	LDRB r0, =0xF0
	LDR r1, =DispBuffer
	LDR	r2, =(NUM_COLS*NUM_PAGES)
fillDBuffer:
	STRB r0, [r1, r2]
	SUB r2, #1
	CMP r2, #0
	BNE	fillDBuffer
	mSET_HREG	SPI_PTCR,	SPI_DMA_ENABLE	@Enable the DMA controller
	mSET_HREG	SPI_IER, SPI_IER_VAL
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

queueDisplayCommand:
	mSTARTFNC
	mSTARTCRITCODE						@Enter critical code, r7 used by this macro
	mLOADTOREG	r1, CommandQueueSize
	CMP	r1, #COM_QUEUE_LENGTH
	BLO addCommandToQ
	@B	CommandQFull
CommandQFull:
	LDR	r0,	=FALSE
	B	sDCEndCritCode
addCommandToQ:
	LDR	r2, =ActiveCommandQueue			@Load pointer to activeCommandQueue
	LDR r2, [r2]						@Load the queue pointed to by activeCommandQueue
	STRB r0, [r2,r1]
	ADD r1, #1
	mSTOREFROMREG r1, r0, CommandQueueSize
	LDR r0, =TRUE
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


@ displayHandler
@
@ Description: Handles sending commands to the display
@
@ Operational Description: This interrupt routine handles a state machine that
@							updates the display. This state machine has two
@							states: Commands, and Data. The different states
@							are handled as follows:
@							Commands: The ActiveCommandQueue is switched to the other queue. The command to
@										switch to the next page of data is enqueued if possible.
@										If there is space for this command, then the state transitions
@										to Data next, and the current page is updated to the next page, else the state stays at Commands.
@										The display is transitioned to command mode (DISP_A0 pin is set to 0 in PIO). Then, the DMA controller
@										is set to transmit all commands in the now-inactive command queue.
@							Data: The DMA controller is setup to transmit the next page of data from DispBuffer.
@										
@							
@
@ Arguments: 
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
	
displayHandler:
	mSTARTINT
	mSET_HREG	SPI_PTCR,	SPI_DMA_DISABLE	@Disable the DMA controller
	mLOADTOREG	r0,	SPI_SR
	mLOADTOREG	r0,	displayHandlerState
	CMP	r0,	#STATE_COMMANDS
	BEQ	stateCommand
	CMP	r0, #STATE_DATA
	BEQ stateData
	B	endDisplayHandler					@Should never hit this state
stateCommand:
	mLOADTOREG	r0,	displayCurPage			@Add the page address set command
	ORR	r0,	r0, #NHD_PAGE_PREF
	BL	queueDisplayCommand					
	CMP r0, #TRUE							@Check if command added
	LDREQ	r0,	=STATE_DATA					@If it was, transition states
	LDREQ	r1, =displayHandlerState		@Else, the state is left as STATE_COMMANDS
	STREQ	r0,	[r1]
	LDR	r0,	=ActiveCommandQueue				@Load the address of activeCommandQueue pointer
	LDR r1, [r0]							@Dereference activeCommandQueue to get
											@pointer to active queue's start.
	PUSH {r1}								@Save pointer to current active queue for later.
	LDR	r2, =CommandQueue1					@Load pointer to CommandQeueu1 to
											@compare to active command queue
	CMP	r1, r2								@Compare the queues
	LDREQ	r2,	=CommandQueue2				@If active queue is 1, switch to queue 2.
											@Else, queue 2 is active and want to switch to queue 1
	STR		r2, [r0]						@switch to the new queue
	
	@Setup DMA for sending commands
	mSET_HREG	PIOA_CODR,	(1 << DISP_A0)	@Clear A0 (sending commands)
	POP {r1}								@Get the queue of commands to send
	mSTOREFROMREG	r1,	r0,	SPI_TNPR		@Set pointer to now inactive command queue
	mLOADTOREG	r1, CommandQueueSize		@Set count of bytes to send to command queue size
	mSTOREFROMREG	r1,	r0,	SPI_TNCR
	
	LDR	r1, =CommandQueueSize				@clear command queue size since now using different queue
	LDR r0, =0
	STR	r0, [r1]
	B	endDisplayHandler					
stateData:

	@Setup DMA for sending data
	mSET_HREG	PIOA_SODR,	(1 << DISP_A0)	@Set A0 (sending data)
	mLOADTOREG r0, displayCurPage			@Calculate the pointer to the current
											@buffer page
	
	LDR r1, =NUM_COLS
	MUL r0, r0, r1
	LDR r1, =DispBuffer
	ADD r0, r0, r1
	mSTOREFROMREG	r0,	r2,	SPI_TNPR			@Set pointer to now inactive command queue
	LDR r1, =NUM_COLS
	mSTOREFROMREG	r1, r2, SPI_TNCR		
	
	LDR	r0,	=STATE_COMMANDS					@Transition states
	LDR	r1, =displayHandlerState
	STR	r0,	[r1]
	@B endDisplayHandler
endDisplayHandler:
	mSET_HREG	SPI_PTCR,	SPI_DMA_ENABLE	@Enable the DMA controller
	mRETURNINT


.data
.balign 4

TextMessage:
	.word 0x00000000
displayHandlerState:
	.word STATE_COMMANDS
displayUpdated:
	.word TRUE
displayCurPage:
	.word 0

CommandQueueSize:
	.word 0x00000000
ActiveCommandQueue:
	.word CommandQueue1
CommandQueue1:
	.skip	(COM_QUEUE_LENGTH)
CommandQueue2:
	.skip	(COM_QUEUE_LENGTH)
DispBuffer:
	.skip (NUM_COLS*NUM_PAGES)
	
.end