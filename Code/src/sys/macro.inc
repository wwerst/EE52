

@Macro for setting Hardware register at destination with value val
@Registers modified: r0, r1
.macro SetHReg dest, value

LDR r0, =\dest
LDR r1, =\value
STR r1, [r0]

.endm

.macro LoadToReg reg, mem_loc 

	LDR \reg,	=\mem_loc
	LDR \reg,	[\reg]

.endm

.macro StoreFromReg reg, temp_reg, mem_loc

	LDR \temp_reg, =\mem_loc
	STR \reg, [\temp_reg]

.endm