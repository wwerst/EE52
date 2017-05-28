@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@                                                                            @
@ keypad.inc                                                                 @
@                                                                            @
@                                                                            @
@ Revision History:                                                          @
@                                                                            @
@   2012/01/29  Glen George     Initial revision.                            @
@                                                                            @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



@ Stack definitions

@ 

	.equ KEY_0,				0	 	@keycode for the <0> key
	.equ KEY_1,				1	 	keycode for the <1> key
	.equ KEY_2,				2	 	keycode for the <2> key
	.equ KEY_3,				3	 	keycode for the <3> key
	.equ KEY_4,				4	 	keycode for the <4> key
	.equ KEY_5,				5	 	keycode for the <5> key
	.equ KEY_6,				6	 	keycode for the <6> key
	.equ KEY_7,				7	 	keycode for the <7> key
	.equ KEY_8,				8	 	keycode for the <8> key
	.equ KEY_9,				9	 	keycode for the <9> key
	.equ KEY_ESC,			10	 	keycode for the <ESC> key
	.equ KEY_BACKSPACE,		11 		keycode for the <Backspace> key
	.equ KEY_SEND,	 		12	 	keycode for the <Send> key
	.equ KEY_OFFHOOK 		13 		keycode for the <Off Hook> key
	.equ KEY_ONHOOK, 		14	 	keycode for the <On Hook> key
	.equ KEY_SET_IP,		15	 	keycode for the <Set IP> key
	.equ KEY_SET_SUBNET,	16	 	keycode for the <Set Subnet> key
	.equ KEY_SET_GATEWAY,	17	 	keycode for the <Set Gateway> key
	.equ KEY_MEM_SAVE,		18	 	keycode for the <Memory Save> key
	.equ KEY_MEM_RECALL,	19	 	keycode for the <Memory Recall> key
	.equ KEY_ILLEGAL,		20	 	illegal keycode, different from any valid keycode
