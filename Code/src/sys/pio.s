@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@
@ Pio.s
@ Contains code for configuring the PIO pins
@
@ Description:
@
@
@ Table of Contents:
@ 
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
.include	"pio.inc"
.include	"macro.inc"

.text
.arm

@ configPIOPin
@
@ Description: Configures PIO pins. 
@
@ Operational Description: First the pin peripheral is configured.
@						   Then, the input or output configuration is set.
@						   Then, the interrupt is enabled or disabled
@
@ Arguments: 	r0 - bit numbers for pins to configure are set to 1.
@						For example, to configure pin 3, passed value is 0x8
@						If multiple bits are 1 in passed register, all these
@						pins are configured.
@				r1 - PIO bank
@				r2 - configType
@
@ Return values: None
@
@ Local variables: 	r0 - PIO pin number bit is 1
@					r1 - PIO base offset for given PIO bank
@
@ Shared variables: None
@
@ Global Variables: None
@
@ Inputs: Interfaces with PIO controller
@
@ Outputs: Interfaces with PIO controller
@
@ Error Handling: None
@
@ Algorithms: None
@
@ Data Structures: None
@
@ Limitations: None
@
@ Registers Changed (besides ARM convention r0-r3): None
@
@ Known Bugs: None
@
@ Special notes: None
@
@ Revision History:
@ Name             Comment              Date
@ Will Werst        Initial version     6/22/2017

.global configPIOPin
configPIOPin:
	mSTARTFNC
	PUSH {r4-r7}
	
	@Load PIO bank base offset into r1
	CMP		r1,	#PIO_A
	LDREQ	r1,	=PIOABase
	BEQ		StartConfig
	CMP		r1, #PIO_B
	LDREQ	r1,	=PIOBBase
	BEQ		StartConfig
	CMP		r1,	#PIO_C
	LDREQ	r1,	=PIOCBase
	BEQ		StartConfig
	BNE		Error							@Catch the case that r1 does not match any of PIO banks
StartConfig:
	@Start configuration by first configuring the pin's peripheral
	AND		r3,	r2,	#PIO_TYPE_MASK
	CMP		r3,	#PIO_NORM
	BEQ		NormalPin
	CMP		r3,	#PIO_PERA
	BEQ		PerAPin
	CMP		r3,	#PIO_PERB
	BEQ		PerBPin
NormalPin:
	@Config pin as normal pin
	ADD		r3,	r1,	#PIO_PER
	STR		r0,	[r3]
	B		ConfigInputOutput
PerAPin:
	@Config pin as peripheral A pin
	ADD		r3,	r1,	#PIO_PDR
	STR		r0,	[r3]
	ADD		r3,	r1,	#PIO_ASR
	STR		r0,	[r3]
	B		ConfigInputOutput
PerBPin:
	@Config pin as peripheral B pin
	ADD		r3,	r1,	#PIO_PDR
	STR		r0,	[r3]
	ADD		r3,	r1,	#PIO_ASR
	STR		r0,	[r3]
	B		ConfigInputOutput
ConfigInputOutput:
	AND		r3, r2, #PIO_OUTPUT_MASK
	CMP		r3, #PIO_OUTPUT
	BEQ		OutputPin
	BNE		InputPin
OutputPin:
	ADD		r3,	r1,	#PIO_OER
	STR		r0,	[r3]
	B		ConfigInterrupt
InputPin:
	ADD		r3,	r1,	#PIO_ODR
	STR		r0,	[r3]
	B		ConfigInterrupt
ConfigInterrupt:
	AND		r3, r2, #PIO_INT_MASK
	CMP		r3, #PIO_INT_EN
	BEQ		EnableInterrupt
	BNE		DisableInterrupt
EnableInterrupt:
	ADD		r3,	r1,	#PIO_IER
	STR		r0,	[r3]
	B		EndConfigPIOPin
DisableInterrupt:
	ADD		r3,	r1,	#PIO_IDR
	STR		r0,	[r3]
	@B		EndConfigPIOPin
EndConfigPIOPin:
	POP {r4-r7}
	mRETURNFNC
	
	
Error:
    B   Error
    
.end