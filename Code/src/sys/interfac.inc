@/****************************************************************************/
@/*                                                                          */
@/*                                INTERFAC.H                                */
@/*                           Interface Definitions                          */
@/*                               Include File                               */
@/*                          VoIP Telephone Project                          */
@/*                                 EE/CS 52                                 */
@/*                                                                          */
@/****************************************************************************/

@   This file contains the constants for interfacing between the C code and
@   the assembly code/hardware.  This is a sample interface file to allow test
@   compilation and linking of the code.


@   Revision History:
@      6/3/06   Glen George       Initial revision.
@      6/7/06   Glen George       Added ETHER_INTF definition.
@      3/8/11   Glen George       Added MAC_ADDR_H and MAC_ADDR_L definitions.


        .equ  DRAM_START,      0x30000000
        .equ  MEMORY_SIZE,     32
        .equ  SAMPLE_RATE,    8000

        .equ  MAC_ADDR_H,      0xEA09
        .equ  MAC_ADDR_L,      0x87654321

        @.equ  ETHER_INTF,      "et0"

        .equ  KEY_0,           0
        .equ  KEY_1,           1
        .equ  KEY_2,           2
        .equ  KEY_3,           3
        .equ  KEY_4,           4
        .equ  KEY_5,           5
        .equ  KEY_6,           6
        .equ  KEY_7,           7
        .equ  KEY_8,           8
        .equ  KEY_9,           9
        .equ  KEY_ESC,         10
        .equ  KEY_BACKSPACE,   11
        .equ  KEY_SEND,        12
        .equ  KEY_OFFHOOK,     13
        .equ  KEY_ONHOOK,      14
        .equ  KEY_SET_IP,      15
        .equ  KEY_SET_SUBNET,  16
        .equ  KEY_SET_GATEWAY, 17
        .equ  KEY_MEM_SAVE,    18
        .equ  KEY_MEM_RECALL,  19
        .equ  KEY_ILLEGAL,     20

        .equ  STATUS_IDLE,         0
        .equ  STATUS_OFFHOOK,      1
        .equ  STATUS_RINGING,      2
        .equ  STATUS_CONNECTING,   3
        .equ  STATUS_CONNECTED,    4
        .equ  STATUS_SET_IP,       5
        .equ  STATUS_SET_SUBNET,   6
        .equ  STATUS_SET_GATEWAY,  7
        .equ  STATUS_MEM_SAVE,     8
        .equ  STATUS_MEM_RECALL,   9
        .equ  STATUS_RECALLED,     10
        .equ  STATUS_ILLEGAL,      11

        .equ  AUDIO_BUFLEN,    256

