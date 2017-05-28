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

	.equ STATUS_IDLE,		0	 	current status (for display) is Idle
	.equ STATUS_OFFHOOK,	1	 	current status (for display) is Off Hook
	.equ STATUS_RINGING,	2	 	current status (for display) is Ringing
	.equ STATUS_CONNECTING,	3	 	current status (for display) is Connecting
	.equ STATUS_CONNECTED,	4	 	current status (for display) is Connected
	.equ STATUS_SET_IP,		5	 	current status (for display) is Set IP
	.equ STATUS_SET_SUBNET,	6	 	current status (for display) is Set Subnet
	.equ STATUS_SET_GATEWAY,7	 	current status (for display) is Set Gateway
	.equ STATUS_MEM_SAVE,	8	 	current status (for display) is Memory Save
	.equ STATUS_MEM_RECALL,	9	 	current status (for display) is Memory Recall
	.equ STATUS_RECALLED,	10	 	current status is a memory address was just recalled, otherwise status is like Idle
	.equ STATUS_ILLEGAL, 	11		illegal status, different from any valid status