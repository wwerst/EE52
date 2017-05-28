

@Macro for setting Hardware register at destination with value val
@Registers modified: r0, r1
.macro SetHReg dest, value

LDR r0, =\dest
LDR r1, =\value
STR r1, [r0]

.endm
