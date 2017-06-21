

@Macro for setting Hardware register at destination with value val
@Registers modified: r0, r1
.macro mSET_HREG dest, value

LDR r0, =\dest
LDR r1, =\value
STR r1, [r0]

.endm

.macro mLOADTOREG reg, mem_loc 

	LDR \reg,	=\mem_loc
	LDR \reg,	[\reg]

.endm

.macro mSTOREFROMREG reg, temp_reg, mem_loc

	LDR \temp_reg, =\mem_loc
	STR \reg, [\temp_reg]

.endm

.macro mSTARTFNC
	PUSH {lr}
.endm

.macro mRETURNFNC
	POP {pc}
.endm

.macro mSTARTINT
	PUSH {r0-r3, lr}
.endm

.macro mRETURNINT
	mSET_HREG AIC_EOICR, 1
	POP {r0-r3, lr}
	SUBS pc, lr, #WORD_SIZE
.endm