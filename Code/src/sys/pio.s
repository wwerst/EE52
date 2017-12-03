@Done
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@
@ Pio.s
@ Contains code for configuring the PIO pins
@
@ Description:
@
@
@ Table of Contents:
@ 	- configPIOPin: Configures PIO pins using arguments passed to it for 
@					PIO
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
	CMP		r1,	#PIO_A   					@Check if PIOA
	LDREQ	r1,	=PIOABase					@If so, load PIOA
	BEQ		StartConfig						@And go to config section
	CMP		r1, #PIO_B 						@Check if PIOB
	LDREQ	r1,	=PIOBBase 					@If so, load PIOB
	BEQ		StartConfig 					@And go to config section
	CMP		r1,	#PIO_C 						@Check if PIOC
	LDREQ	r1,	=PIOCBase 					@If so, load PIOC
	BEQ		StartConfig 					@And go to config section
	BNE		Error							@Catch the case that r1 does not match any of PIO banks
StartConfig:
	@Start configuration by first configuring the pin's peripheral
	AND		r3,	r2,	#PIO_TYPE_MASK 			@Mask out the PIO type
	CMP		r3,	#PIO_NORM					@Check if PIO is normal type
	BEQ		NormalPin						@If so, configure it
	CMP		r3,	#PIO_PERA                   @Check if PIO is peripheral A type
	BEQ		PerAPin                         @If so, configure it
	CMP		r3,	#PIO_PERB                   @Check if PIO is peripheral B type
	BEQ		PerBPin                         @If so, configure it
NormalPin:
	@Config pin as normal pin
	ADD		r3,	r1,	#PIO_PER                @Load PIO_PER address
	STR		r0,	[r3]                        @Configure PIO pin type
	B		ConfigInputOutput 				@Go configure as input/output
PerAPin:
	@Config pin as peripheral A pin
	ADD		r3,	r1,	#PIO_PDR          		@Load PIO_PDR address
	STR		r0,	[r3]                        @Disable PIO pin normal mode
	ADD		r3,	r1,	#PIO_ASR                @Load PIO_ASR address
	STR		r0,	[r3] 						@Enable PIO pin peripheral A mode
	B		ConfigInputOutput              	@Go configure as input/output
PerBPin:
	@Config pin as peripheral B pin
	ADD		r3,	r1,	#PIO_PDR 				@Load PIO_PDR address
	STR		r0,	[r3]  						@Disable PIO pin normal mode
	ADD		r3,	r1,	#PIO_BSR  				@Load PIO_BSR address
	STR		r0,	[r3] 						@Enable PIO pin peripheral B mode
	B		ConfigInputOutput 				@Go configure as input/output
ConfigInputOutput:
	AND		r3, r2, #PIO_OUTPUT_MASK 		@Mask out the output type
	CMP		r3, #PIO_OUTPUT 				@Check if PIO is output
	BEQ		OutputPin 						@If so, set as output
	BNE		InputPin 						@Else, set as input
OutputPin:
	ADD		r3,	r1,	#PIO_OER   				@Load output enable register
	STR		r0,	[r3]  						@Enable pin as output
	B		ConfigInterrupt 				@Go configure interrupt
InputPin:
	ADD		r3,	r1,	#PIO_ODR   				@Load output disable register
	STR		r0,	[r3] 						@Enable pin as input
	B		ConfigInterrupt  				@Go configure interrupt
ConfigInterrupt:
	AND		r3, r2, #PIO_INT_MASK  			@Mask out interrupt settings
	CMP		r3, #PIO_INT_EN    				@If interrupt is set to be enabled,
	BEQ		EnableInterrupt  				@Go enable it
	BNE		DisableInterrupt 				@Else, disable it
EnableInterrupt:
	ADD		r3,	r1,	#PIO_IER  				@Load interrupt enable register
	STR		r0,	[r3]  						@Enable interrupt
	B		EndConfigPIOPin					@Done with config
DisableInterrupt:
	ADD		r3,	r1,	#PIO_IDR 				@Load interrupt disable register
	STR		r0,	[r3]  						@Disable interrupt
	@B		EndConfigPIOPin    				@Done with config
EndConfigPIOPin:
	POP {r4-r7} 							@Restore registers
	mRETURNFNC 								@Return
	
	
Error:
    B   Error
    
.end