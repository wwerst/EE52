
@System.s


.include    "at91rm9200.inc"
.include	"macro.inc"
.include    "system.inc"


.text
.arm

.global init_system
init_system:
	mSTARTFNC
	mSET_HREG	AIC_SMR1,	0x00000021
	mSET_HREG AIC_SVR1,	timerHandler
	mSET_HREG	ST_PIMR, 	PIT_INTERVAL
	mSET_HREG	ST_IER,		0x00000001
	mSET_HREG AIC_IECR, 	0x00000002
	LDR		r0,		=ST_SR
	LDR		r0, 	[r0]
	LDR		r0, 	=RTC_SR
	LDR		r0, 	[r0]
	LDR		r0, 	=PMC_SR
	LDR		r0, 	[r0]
	mRETURNFNC

@ returns: number of milliseconds since last function call
.global elapsed_time
elapsed_time:
	mSTARTFNC
	mLoadToReg	r0,	millis				@load current milliseconds
	mLoadToReg	r1,	last_millis			@load last milliseconds
	mStoreFromReg	r0,	r2, last_millis		@store current milliseconds into last milliseconds
	SUB 	r0,	r0,	r1					@get difference
	
	mRETURNFNC

@ variables:
@	r1 - timer_counter
timerHandler:
	mSTARTINT
	LDR		r0,		=ST_SR
	LDR		r0, 	[r0]
	LDR		r0, 	=RTC_SR
	LDR		r0, 	[r0]
	LDR		r0, 	=PMC_SR
	LDR		r0, 	[r0]
	LDR		r0,		=(PIT_INTERVAL*MILLIS_IN_SEC)
	mLoadToReg	r1,	timer_counter
	ADD		r1, r1, r0
transferFullMillisCounts:
	CMP		r1,	#SLCK_CNT_SEC
	BLO		endTimerHandler				@No full milliseconds to transfer
	PUSH	{r1}
	BL		oneMillisElapsed			@Call the function to increment millis
										@and also take any action that should
										@be done when a millisecond has elapsed
	POP		{r1}
	SUB		r1, #SLCK_CNT_SEC			@Take off the number of counts in timer_counter
										@associated with one millisecond elapsing
	B		transferFullMillisCounts	@Go back and check if more milliseconds to transfer
endTimerHandler:
	mStoreFromReg	r1, r0,	timer_counter
	mRETURNINT



@ oneMillisElapsed 
@ Description: Function used to increment millisecond, and also do any other
@				actions such as refresh DRAM
@ 

oneMillisElapsed:
	mSTARTFNC
	mLoadToReg	r0,	millis
	ADD		r0,	#1
	mStoreFromReg	r0,	r2,	millis
	
	@Refresh DRAM, need to refresh 1024 rows every 16 ms
	LDR		r0, 	=((DRAM_NUM_ROWS / DRAM_MILLIS_PER_REF))
	LDR 	r1,		=DRAM_START
	mLoadToReg	r2,		dramRefreshRow	
dramRefresh:
	LDRB	r3,	[r1, r2]
	ADD		r2,		#1
	CMP		r2,		#DRAM_NUM_ROWS	@Check if gone through all rows
	LDRHS	r2,		=0				@If so, go back to row 0
	SUBS	r0,		#1
	BHI		dramRefresh
	@B		endDRAMRefresh
	
endDRAMRefresh:
	mStoreFromReg	r2, r0,	dramRefreshRow
	@B	endOneMillisElapsed
endOneMillisElapsed:
	mRETURNFNC
.data

millis:
	.word 0x00000000
last_millis:
	.word 0x00000000
timer_counter:
	.word 0x00000000
dramRefreshRow:
	.word 0x00000000