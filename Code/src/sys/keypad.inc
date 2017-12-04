@Done
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@
@
@                                   keypad.inc
@                       Contains definitions used by keypad.s
@
@
@
@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@ Description: Defines register values used by the keypad
@
@ Revision History:
@ Name			Comment					Date
@ Will Werst	Initial version			Some lonely night around 6/10/17
@ Will Werst	Comment					October 2017



    .equ RDY_PIN,    26 				@Ready pin location for interrupts
	.equ MAXDEBCOUNT,	10000  			
	.equ  KEY_HANGUPBTN, 21
	.equ  KEY_SHIFT,	 22