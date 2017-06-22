

.include	"macro.inc"



.arm
.text


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



.data
TextMessage:
	.word 0x00000000
DispBuffer:
	.skip (128*32)
	
.end