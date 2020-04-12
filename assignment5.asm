;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Andrew Shim
; Email: ashim020@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 26
; TA: Jang-Shing Enoch Lin
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
	
	BEGIN_PROGRAM
	LD	R6,	SUB_MENU_PTR
	JSRR	R6
	
	LD	R3,	TEST_1
	ADD	R1,	R1,	R3
	BRz	SUB_ALL_MACHINES_BUSY
	BRnp	END_SUB_ALL_MACHINES_BUSY
	SUB_ALL_MACHINES_BUSY
		LD	R6,	SUB_ALL_MACHINES_BUSY_PTR
		JSRR	R6
		BR	BEGIN_PROGRAM
	END_SUB_ALL_MACHINES_BUSY
	LD	R3,	TEST_1_1
	ADD	R1,	R1,	R3
	
	LD	R3,	TEST_2
	ADD	R1,	R1,	R3
	BRz	SUB_ALL_MACHINES_FREE
	BRnp	END_SUB_ALL_MACHINES_FREE
	SUB_ALL_MACHINES_FREE
		LD	R6,	SUB_ALL_MACHINES_FREE_PTR
		JSRR	R6
		BR	BEGIN_PROGRAM
	END_SUB_ALL_MACHINES_FREE
	LD	R3,	TEST_2_1
	ADD	R1,	R1,	R3
	
	LD	R3,	TEST_3
	ADD	R1,	R1,	R3
	BRz	SUB_NUM_BUSY_MACHINES
	BRnp	END_SUB_NUM_BUSY_MACHINES
	SUB_NUM_BUSY_MACHINES
		LD	R6,	SUB_NUM_BUSY_MACHINES_PTR
		JSRR	R6
		BR	BEGIN_PROGRAM
	END_SUB_NUM_BUSY_MACHINES
	LD	R3,	TEST_3_1
	ADD	R1,	R1,	R3
	
	LD	R3,	TEST_4
	ADD	R1,	R1,	R3
	BRz	SUB_NUM_FREE_MACHINES
	BRnp	END_SUB_NUM_FREE_MACHINES
	SUB_NUM_FREE_MACHINES
		LD	R6,	SUB_NUM_FREE_MACHINES_PTR
		JSRR	R6
		BR	BEGIN_PROGRAM
	END_SUB_NUM_FREE_MACHINES
	LD	R3,	TEST_4_1
	ADD	R1,	R1,	R3
	
	LD	R3,	TEST_5
	ADD	R1,	R1,	R3
	BRz	SUB_MACHINE_STATUS
	BRnp	END_SUB_MACHINE_STATUS
	SUB_MACHINE_STATUS
		LD	R6,	SUB_MACHINE_STATUS_PTR
		JSRR	R6
		BR	BEGIN_PROGRAM
	END_SUB_MACHINE_STATUS
	LD	R3,	TEST_5_1
	ADD	R1,	R1,	R3
	
	LD	R3,	TEST_6
	ADD	R1,	R1,	R3
	BRz	SUB_FIRST_FREE
	BRnp	END_SUB_FIRST_FREE
	SUB_FIRST_FREE
		LD	R6,	SUB_FIRST_FREE_PTR
		JSRR	R6
		BR	BEGIN_PROGRAM
	END_SUB_FIRST_FREE
	LD	R3,	TEST_6_1
	ADD	R1,	R1,	R3
	
	LD	R3,	TEST_7
	ADD	R1,	R1,	R3
	BRz	QUIT
	QUIT
		LEA	R0,	goodbye
		PUTS
	END_QUITS
	
	;LD	R6,	SUB_NUM_BUSY_MACHINES_PTR
	;JSRR	R6
	
	;LD	R6,	SUB_FIRST_FREE_PTR
	;JSRR	R6

	HALT
;---------------	
;Data
;---------------
;Subroutine pointers
	
	SUB_MENU_PTR				.FILL	x3200
	SUB_ALL_MACHINES_BUSY_PTR	.FILL	x3400
	SUB_ALL_MACHINES_FREE_PTR	.FILL	x3600
	SUB_NUM_BUSY_MACHINES_PTR	.FILL	x3800
	SUB_NUM_FREE_MACHINES_PTR	.FILL	x4000
	SUB_MACHINE_STATUS_PTR		.FILL	x4200
	SUB_FIRST_FREE_PTR			.FILL	x4400
	TEST_1						.FILL	#-1
	TEST_2						.FILL	#-2
	TEST_3						.FILL	#-3
	TEST_4						.FILL	#-4
	TEST_5						.FILL	#-5
	TEST_6						.FILL	#-6
	TEST_7						.FILL	#-7
	TEST_1_1					.FILL	#1
	TEST_2_1					.FILL	#2
	TEST_3_1					.FILL	#3
	TEST_4_1					.FILL	#4
	TEST_5_1					.FILL	#5
	TEST_6_1					.FILL	#6
	TEST_7_1					.FILL	#7
	
;Other data 

newline_0 		.fill '\n'

; Strings for reports from menu subroutines:
goodbye         .stringz "\nGoodbye!\n"
allbusy         .stringz "All machines are busy\n"
allnotbusy      .stringz "Not all machines are busy\n"
allfree         .stringz "All machines are free\n"
allnotfree		.stringz "Not all machines are free\n"
busymachine1    .stringz "There are "
busymachine2    .stringz " busy machines\n"
freemachine1    .stringz "There are "
freemachine2    .stringz " free machines\n"
status1         .stringz "Machine "
status2		    .stringz " is busy\n"
status3		    .stringz " is free\n"
firstfree1      .stringz "The first available machine is number "
firstfree2      .stringz "No machines are free\n"


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
	.ORIG	x3200
;HINT back up 
	
	ST	R0,	backup_r0_3200
	ST	R2,	backup_r2_3200
	ST	R7,	backup_r7_3200
	
;Algorithm
	
	START
		LD		R0,	MENU_PTR			;Print menu
		PUTS
		GETC							;Get user input
		OUT
		LD		R2,	NEG_DEC_1			;Load register with -1
		ADD		R0,	R0,	R2				;Add -1 to user input
		BRn		ERROR_MESSAGE			;If the result is negative, the user input was less than 1, so error
		BRzp	END_ERROR_MESSAGE		;If neither, see if user input is greater than 7
		ERROR_MESSAGE
			LEA	R0,	Error_msg_1			;Error message printed
			PUTS
			BR	START					;Loops back to beginning
		END_ERROR_MESSAGE
		LD		R2,	DEC_1				;Resets user input to original value
		ADD		R0,	R0,	R2				
		LD		R2,	NEG_DEC_7			;Load register with -7
		ADD		R0,	R0,	R2				;Add -7 to user input
		BRp		ERROR_MESSAGE			;If positive, user input is greater than 7, so error
		LD		R2,	DEC_7				;Resets user input to original value
		ADD		R0,	R0,	R2
		LD		R2,	NEG_DEC_48
		ADD		R0,	R0,	R2
		ADD		R1,	R0,	#0				;If not, the user input is accepted and loaded into R1
	END_START
	

;HINT Restore

	LD	R0,	backup_r0_3200
	LD	R2,	backup_r2_3200
	LD	R7,	backup_r7_3200
	
	RET

;--------------------------------
;Data for subroutine MENU
;--------------------------------
	
	MENU_PTR		.FILL		x6A00
	NEG_DEC_1		.FILL		#-49
	DEC_1			.FILL		#49
	NEG_DEC_7		.FILL		#-55
	DEC_7			.FILL		#55
	NEG_DEC_48		.FILL		#-48
	Error_msg_1 	.STRINGZ 	"\nINVALID INPUT\n"
	backup_r0_3200	.BLKW		#1
	backup_r2_3200	.BLKW		#1
	backup_r7_3200	.BLKW		#1
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;--------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
	.ORIG	x3400
;HINT back up 
	
	ST	R0,	backup_r0_3400
	ST	R3,	backup_r3_3400
	ST	R7,	backup_r7_3400

;Algorithm
	
	LDI		R3,	BUSYNESS_ADDR_ALL_MACHINES_BUSY
	BRz		IS_BUSY
	BRnp	NOT_BUSY
	IS_BUSY
		LD	R2,	DEC_1_AGAIN
		LEA	R0,	BUSYNESS_YES
		PUTS
		BR	END_NOT_BUSY
	END_IS_BUSY
	NOT_BUSY
		LD	R2,	DEC_0_AGAIN
		LEA	R0,	BUSYNESS_NO
		PUTS
	END_NOT_BUSY
	
;HINT Restore

	LD	R0,	backup_r0_3400
	LD	R3, backup_r3_3400
	LD	R7,	backup_r7_3400

	RET

;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------

	BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill 		xBA00
	backup_r0_3400					.BLKW		#1
	backup_r3_3400					.BLKW		#1
	backup_r7_3400					.BLKW		#1
	DEC_0_AGAIN						.FILL		#0
	DEC_1_AGAIN						.FILL		#1
	BUSYNESS_YES					.STRINGZ	"\nAll machines are busy\n"
	BUSYNESS_NO						.STRINGZ	"\nNot all machines are busy\n"
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
	.ORIG	x3600
;HINT back up 
	
	ST	R0,	backup_r0_3600
	ST	R3,	backup_r3_3600
	ST	R7,	backup_r7_3600
	
;Algorithm

	LDI		R3,	BUSYNESS_ADDR_ALL_MACHINES_FREE
	NOT		R3,	R3
	BRz		IS_FREE
	BRnp	NOT_FREE
	IS_FREE
		LD	R2,	ANOTHER_DEC_1
		LEA	R0,	FREE_YES
		PUTS
		BR	END_NOT_FREE
	END_IS_FREE
	NOT_FREE
		LD	R2,	ANOTHER_DEC_0
		LEA	R0,	FREE_NO
		PUTS
	END_NOT_FREE
	
;HINT Restore

	LD	R0,	backup_r0_3600
	LD	R3,	backup_r3_3600
	LD	R7,	backup_r7_3600
	
	RET

;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------

	BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill 		xBA00
	backup_r0_3600					.BLKW		#1
	backup_r3_3600					.BLKW		#1
	backup_r7_3600					.BLKW		#1
	ANOTHER_DEC_0					.FILL		#0
	ANOTHER_DEC_1					.FILL		#1
	FREE_YES						.STRINGZ	"\nAll machines are free\n"
	FREE_NO							.STRINGZ	"\nNot all machines are free\n"
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy (0)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
	.ORIG x3800
;HINT back up 

;(1) Register Backups
    
    ST	R3,	backup_r3_3800
    ST	R4,	backup_r4_3800
    ST	R7,	backup_r7_3800
    
;(2) Algorithm
	
	AND	R2,	R2,	#0
	LD	R4,	DEC_16
	LDI	R3,	BUSYNESS_ADDR_NUM_BUSY_MACHINES
	;NOT	R3,	R3
	;ADD	R3,	R3,	#1
	
	CHECK_LOOP
		ADD		R4,	R4,	#0				;Make R4 the LMR
		BRnz	END_CHECK_LOOP			;If R4 reaches 0, exit the loop
		ADD		R3,	R3,	#0				;Make the value the LMR
		BRn		DONT_INCREMENT_COUNTER	;If a 1 is the MSB, go to DONT_INCREMENT_COUNTER routine
		BRzp	INCREMENT_COUNTER		;If a 0 is the MSB, go to INCREMENT_COUNTER routine
		DONT_INCREMENT_COUNTER			
			ADD	R4,	R4,	#-1				;Decrement R4
			ADD	R3,	R3,	R3				;Left-shift
			BR	CHECK_LOOP				;Loop back to the beginning
		END_INCREMENT_COUNTER
		INCREMENT_COUNTER
			ADD	R2,	R2,	#1				;Add 1 to the counter
			ADD	R4,	R4,	#-1				;Decrement R4
			ADD	R3,	R3,	R3				;Left shift
			BR	CHECK_LOOP				;Loop back to the beginning
		END_DONT_INCREMENT_COUNTER
	END_CHECK_LOOP
	
	LEA	R0,	thereare_1
	PUTS
	
	ADD	R1,	R2,	#0
	LD	R6,	printnumptr
	JSRR	R6
	
	LEA	R0,	busymachines
	PUTS
    
;(3) Register Restoration
	
    LD	R3,	backup_r3_3800
    LD	R4,	backup_r4_3800
    LD	R7,	backup_r7_3800

;(4) Return

    RET

;========================
; Subroutine Data
;========================

	DEC_16							.FILL	#16
	backup_r3_3800					.BLKW	#1
	backup_r4_3800					.BLKW	#1
	backup_r7_3800					.BLKW	#1
	BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill 	xBA00
	thereare_1    					.stringz 	"\nThere are "
	busymachines					.stringz	" busy machines\n"
	printnumptr						.FILL		x4800
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free (1)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
	.ORIG	x4000
;HINT back up 

	ST	R3,	backup_r3_4000
    ST	R4,	backup_r4_4000
    ST	R7,	backup_r7_4000
    
;Algorithm

	AND	R2,	R2,	#0
	LD	R4,	DEC_16_1
	LDI	R3,	BUSYNESS_ADDR_NUM_FREE_MACHINES
	
	CHECK_LOOP_1
		ADD		R4,	R4,	#0					;Make R4 the LMR
		BRnz	END_CHECK_LOOP_1			;If R4 reaches 0, exit the loop
		ADD		R3,	R3,	#0					;Make the value the LMR
		BRn		DONT_INCREMENT_COUNTER_1	;If a 1 is the MSB, go to DONT_INCREMENT_COUNTER routine
		BRzp	INCREMENT_COUNTER_1			;If a 0 is the MSB, go to INCREMENT_COUNTER routine
		DONT_INCREMENT_COUNTER_1			
			ADD	R4,	R4,	#-1					;Decrement R4
			ADD	R3,	R3,	R3					;Left-shift
			BR	CHECK_LOOP_1				;Loop back to the beginning
		END_INCREMENT_COUNTER_1
		INCREMENT_COUNTER_1
			ADD	R2,	R2,	#1					;Add 1 to the counter
			ADD	R4,	R4,	#-1					;Decrement R4
			ADD	R3,	R3,	R3					;Left shift
			BR	CHECK_LOOP_1				;Loop back to the beginning
		END_DONT_INCREMENT_COUNTER_1
	END_CHECK_LOOP_1
	
	NOT	R2,	R2
	ADD	R2,	R2,	#1
    LD	R4,	DEC_16_1
    ADD	R2,	R4,	R2
    
    LEA	R0,	thereare_2
	PUTS
	
	ADD	R1,	R2,	#0
	LD	R6,	printnumptr_1
	JSRR	R6
	
	LEA	R0,	freemachines
	PUTS
	
;HINT Restore

	LD	R3,	backup_r3_4000
    LD	R4,	backup_r4_4000
    LD	R7,	backup_r7_4000
    
	RET
    
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES 
;--------------------------------
	
	BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xBA00
	DEC_16_1						.FILL	#16
	backup_r3_4000					.BLKW	#1
	backup_r4_4000					.BLKW	#1
	backup_r7_4000					.BLKW	#1
	thereare_2    					.stringz 	"\nThere are "
	freemachines					.stringz	" free machines\n"
	printnumptr_1					.FILL		x4800

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
	.ORIG	x4200
;HINT back up 

	ST	R3,	backup_r3_4200
    ST	R4,	backup_r4_4200
    ST	R7,	backup_r7_4200
	
;Algorithm
	
	AND		R1,	R1,	#0		
	LD		R6,	SUB_GET_MACHINE_NUM			;Executes helper function to get machine number in binary in R1
	JSRR	R6
	ADD		R4,	R1,	#0						;Copies R1 over to R4
	LDI		R3,	BUSYNESS_ADDR_MACHINE_STATUS

	MACHINE_CHECK
		ADD	R4,	R4,	#0						;Make R4 the LMR
		BRz	CHECK_AVAILABILITY				;Check if the current machine is the correct one
		BRp	LEFT_SHIFT						;If not, left shift
		CHECK_AVAILABILITY
			ADD	R3,	R3,	#0					;Make the value the LMR
			BRn	FREE_RESULT					;If the value is negative, go to FREE_RESULT
			BRzp	BUSY_RESULT					;If the value is positve, go to BUSY_RESULT
			FREE_RESULT
				LD	R2,	DEC_1_ONCE_AGAIN	;Load R2 with 1
				BR	END_MACHINE_CHECK		;End the loop
			END_FREE_RESULT
			BUSY_RESULT
				LD	R2,	DEC_0_ONCE_AGAIN	;Load R2 with 1
				BR	END_MACHINE_CHECK		;End the loop
			END_BUSY_RESULT
		END_CHECK_AVAILABILITY
		LEFT_SHIFT
			ADD	R3,	R3,	R3					;Left-shift
			ADD	R4,	R4,	#-1					;Decrement the countdown
			BR	MACHINE_CHECK				;Loop back to the beginning
		END_LEFT_SHIFT
	END_MACHINE_CHECK
	
	LEA	R0,	status1_1
	PUTS
	
	;ADD	R1,	R2,	#0
	LD	R6,	printnumptr_2
	JSRR	R6
	
	ADD	R2,	R2,	#0
	BRz	PRINT_BUSY
	BRp	PRINT_FREE
	PRINT_BUSY
		LEA	R0,	status2_1
		PUTS
		BR	END_PRINT_FREE
	END_PRINT_BUSY
	PRINT_FREE
		LEA	R0,	status3_1
		PUTS
		BR	END_PRINT_FREE
	END_PRINT_FREE
	
;HINT Restore

	LD	R3,	backup_r3_4200
    LD	R4,	backup_r4_4200
    LD	R7,	backup_r7_4200

	RET
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
	
	BUSYNESS_ADDR_MACHINE_STATUS	.Fill 	xBA00
	SUB_GET_MACHINE_NUM				.FILL	x4600
	DEC_0_ONCE_AGAIN				.FILL	#0
	DEC_1_ONCE_AGAIN				.FILL	#1
	backup_r3_4200					.BLKW	#1
	backup_r4_4200					.BLKW	#1
	backup_r7_4200					.BLKW	#1
	status1_1         				.stringz "Machine "
	status2_1		   				.stringz " is busy\n"
	status3_1	    				.stringz " is free\n"
	printnumptr_2					.FILL	x4800

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
	.ORIG	x4400
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
;HINT back up 

	ST	R3,	backup_r3_4400
	ST	R5,	backup_r5_4400
	ST	R7,	backup_r7_4400
	
;Instruction
	
	LD		R2,	NUM_0
	LDI		R3,	BUSYNESS_ADDR_FIRST_FREE
	FREE_MACHINE_LOOP
	ADD		R2,	R2,	#-15
	BRp		REVERT_AND_END_NEXT_FREE
	;BRp		END_NEXT_FREE
	ADD		R2,	R2,	#15
	ADD		R3,	R3,	#0
	BRn		END_NEXT_FREE
	BRzp	NEXT_FREE
	REVERT_AND_END_NEXT_FREE
			ADD	R2,	R2,	#15
			BR END_NEXT_FREE
	END_REVERT_AND_END_NEXT_FREE
	NEXT_FREE
		ADD	R3,	R3,	R3
		ADD	R2,	R2,	#1
		BR	FREE_MACHINE_LOOP
	END_NEXT_FREE
	
	LD	R5,	NEG_NEG_16
	ADD	R2,	R2,	R5
	BRz	NONE_FREE
	BRn	MACHINE_FREE
	NONE_FREE
		LEA	R0,	firstfree4
		PUTS
		LD	R5,	POS_POS_16
		ADD	R2,	R2,	R5
		BR	END_MACHINE
	END_NONE_FREE
	MACHINE_FREE
		LD	R5,	POS_POS_16
		ADD	R2,	R2,	R5
		;NOT	R2,	R2
		;ADD	R2,	R2,	#1
		;LD	R5,	DEC_DEC_15
		;ADD	R2,	R2,	R5
		LEA	R0,	firstfree3
		PUTS
		ADD	R1,	R2,	#0
		LD	R6,	printnumptr_3
		JSRR	R6
		BR	END_MACHINE
	END_MACHINE_FREE
	END_MACHINE
	
	LD	R0,	newline_1
	OUT
	
;HINT Restore

	LD	R3,	backup_r3_4400
	LD	R5,	backup_r5_4400
	LD	R7,	backup_r7_4400
	
	RET
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
	
	BUSYNESS_ADDR_FIRST_FREE 	.Fill	xBA00
	NUM_0						.FILL	#0
	backup_r3_4400				.BLKW	#1
	backup_r5_4400				.BLKW	#1
	backup_r7_4400				.BLKW	#1
	firstfree3      			.stringz "\nThe first available machine is number "
	firstfree4      			.stringz "\nNo machines are free"
	NEG_NEG_16					.FILL	#-16
	POS_POS_16					.FILL	#16
	printnumptr_3				.FILL	x4800
	newline_1					.FILL	'\n'
	DEC_DEC_15					.FILL	#15

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------
	.ORIG	x4600
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------

	ST	R0,	backup_r0_4600
	ST	R3,	backup_r3_4600
	ST	R4,	backup_r4_4600
	ST	R5,	backup_r5_4600
	ST	R7,	backup_r7_4600
	
;Instructions
	; output intro prompt
	START_PROGRAM
	LEA	R0,	prompt
	PUTS
; Set up flags, counters, accumulators as needed
	AND	R1,	R1,	#0
	;AND	R6,	R6,	#0
	LD	R4,	DEC_3
; Get first character, test for '\n', '+', '-', digit/non-digit 	
	GETC
	OUT				
					; is very first character = '\n'? if so, just quit (no message)!
	NEWLINE_CHECK
		LD		R3,	neg_newline
		ADD		R0,	R0, R3
		BRnp	END_NEWLINE_CHECK
		BRz		END_PROGRAM
	END_NEWLINE_CHECK
	LD	R3,	pos_newline
	ADD	R0,	R0,	R3
					; is it = '+'? if so, ignore it, go get digits
	POS_CHECK
		LD		R3,	neg_plus
		ADD		R0,	R0,	R3
		BRnp	END_POS_CHECK
		BRz		RESET_AND_GET_1
		RESET_AND_GET_1
			LD	R3,	pos_plus
			ADD	R0,	R0,	R3
			BR	GET_OTHER_DIGITS
		END_RESET_AND_GET_1
	END_POS_CHECK
	LD	R3,	pos_plus
	ADD	R0,	R0,	R3
					; is it = '-'? if so, set neg flag, go get digits
	NEG_CHECK
		LD		R3,	neg_minus
		ADD		R0,	R0,	R3
		BRnp	END_NEG_CHECK
		BRz		NEG_FLAG
		NEG_FLAG
			;LD	R6,	neg_one
			BR	RESET_AND_GET_2
			RESET_AND_GET_2
				;LD	R3,	pos_minus
				;ADD	R0,	R0,	R3
				;BR GET_OTHER_DIGITS
				;LD	R0,	newline
				;OUT
				LEA	R0,	Error_msg_2
				PUTS
				BR	START_PROGRAM
			END_RESET_AND_GET_2
		END_NEG_FLAG
	END_NEG_CHECK
	LD	R3,	pos_minus
	ADD	R0,	R0,	R3
					; is it < '0'? if so, it is not a digit	- o/p error message, start over
	BELOW_DIGIT_CHECK
		LD		R3,	neg_48
		ADD		R0,	R0,	R3
		BRn		ERROR_1
		BRzp	END_BELOW_DIGIT_CHECK
		ERROR_1
			;LD	R0,	newline
			;OUT
			LEA	R0,	Error_msg_2
			PUTS
			BR	START_PROGRAM
		END_ERROR_1
	END_BELOW_DIGIT_CHECK
	LD	R3,	pos_48
	ADD	R0,	R0,	R3
					; is it > '9'? if so, it is not a digit	- o/p error message, start over
	ABOVE_DIGIT_CHECK
		LD		R3,	neg_57
		ADD		R0,	R0,	R3
		BRp		ERROR_2
		BRnz	END_ABOVE_DIGIT_CHECK
		ERROR_2
			;LD	R0,	newline
			;OUT
			LEA	R0,	Error_msg_2
			PUTS
			BR	START_PROGRAM
		END_ERROR_2
	END_ABOVE_DIGIT_CHECK
	LD	R3,	pos_57
	ADD	R0,	R0,	R3
					; if none of the above, first character is first numeric digit - convert it to number & store in target register!
	LD	R3,	neg_48
	ADD	R0,	R0,	R3
	ADD	R1,	R1,	R0
	ADD	R4,	R4,	#-1
; Now get remaining digits (max 5) from user, testing each to see if it is a digit, and build up number in accumulator
	GET_OTHER_DIGITS
		ADD		R4,	R4,	#0
		BRnz	NEG_FLAG_CHECK
		;BRp		START_PROGRAM
		GETC
		OUT
					; remember to end with a newline!
					; is very first character = '\n'? if so, just quit (no message)!
	NEWLINE_CHECKER
		LD		R3,	neg_newline
		ADD		R0,	R0, R3
		BRnp	END_NEWLINE_CHECKER
		BRz		RESET_AND_NEWLINE_CHECK
		RESET_AND_NEWLINE_CHECK
			LD	R3,	pos_newline
			ADD	R0,	R0,	R3
			BR	NEWLINE_CHECK_2				;Go to newline_check_2 if newline terminated
		END_RESET_AND_NEWLINE_CHECK
	END_NEWLINE_CHECKER
	LD	R3,	pos_newline
	ADD	R0,	R0,	R3
					; is it < '0'? if so, it is not a digit	- o/p error message, start over
	BELOW_DIGIT_CHECK_2
		LD		R3,	neg_48
		ADD		R0,	R0,	R3
		BRn		ERROR_1
		BRzp	END_BELOW_DIGIT_CHECK_2
		ERROR_1_2
			;LD	R0,	newline
			;OUT
			LEA	R0,	Error_msg_2
			PUTS
			BR	START_PROGRAM
		END_ERROR_1_2
	END_BELOW_DIGIT_CHECK_2
	LD	R3,	pos_48
	ADD	R0,	R0,	R3
					; is it > '9'? if so, it is not a digit	- o/p error message, start over
	ABOVE_DIGIT_CHECK_2
		LD		R3,	neg_57
		ADD		R0,	R0,	R3
		BRp		ERROR_2
		BRnz	END_ABOVE_DIGIT_CHECK_2
		ERROR_2_2
			;LD	R0,	newline
			;OUT
			LEA	R0,	Error_msg_2
			PUTS
			BR	START_PROGRAM
		END_ERROR_2_2
	END_ABOVE_DIGIT_CHECK_2
	LD	R3,	pos_57
	ADD	R0,	R0,	R3
	NEWLINE_CHECK_2
		LD		R3,	neg_newline
		ADD		R0,	R0, R3
		BRz		NEG_FLAG_CHECK
		BRnp	SET_VALUES
		SET_VALUES
				LD	R5,	DEC_10
				LD	R3,	pos_newline
				ADD	R0,	R0,	R3
				AND R3, R3, #0
		END_SET_VALUES
		DO_WHILE
			ADD R3,	R3,	R1
			ADD R5,	R5,	#-1
			BRp DO_WHILE
		END_DO_WHILE
		ADD	R1,	R3, #0				;First value multiplied by 10
		LD	R3,	neg_48
		ADD	R0,	R0,	R3
		ADD	R1,	R1,	R0
		;ADD	R4,	R4,	#-1
		;BR	GET_OTHER_DIGITS
	END_NEWLINE_CHECK_2
	ADD	R4,	R4,	#-1
	BR	GET_OTHER_DIGITS
	LD	R3,	pos_newline
	ADD	R0,	R0,	R3
	;LD	R0,	newline
	;OUT
	NEG_FLAG_CHECK
		;LD		R0,	newline
		;OUT
		;ADD		R6,	R6,	#0
		;BRn		NEG_CHANGE
		;BRzp	END_NEG_CHANGE
		;NEG_CHANGE
				;NOT	R1,	R1
				;ADD	R1,	R1,	#1
		;END_NEG_CHANGE
		ADD	R4,	R4,	#0
		BRz	newline_routine
		BRnp	end_newline_routine
		newline_routine
			;LD	R0,	newline
			;OUT
		end_newline_routine
	END_NEG_FLAG_CHECK
	MORE_THAN_15_CHECK
		LD		R5,	NEG_DEC_15
		ADD		R1,	R1,	R5
		BRp		ERROR_2_3
		BRnz	END_ERROR_2_3
		ERROR_2_3
			;LD	R0,	newline
			;OUT
			LEA	R0,	Error_msg_2
			PUTS
			BR	START_PROGRAM
		END_ERROR_2_3
		LD		R5,	POS_DEC_15
		ADD		R1,	R1,	R5
	END_MORE_THAN_15_CHECK
	END_PROGRAM
	
	LD	R0,	backup_r0_4600
	LD	R3,	backup_r3_4600
	LD	R4,	backup_r4_4600
	LD	R5,	backup_r5_4600
	LD	R7,	backup_r7_4600
	
	RET
	
;--------------------------------
;Data for subroutine Get input
;--------------------------------

	neg_newline			.FILL		#-10
	pos_newline			.FILL		#10
	neg_plus			.FILL		#-43
	pos_plus			.FILL		#43
	neg_minus			.FILL		#-45
	pos_minus			.FILL		#45
	neg_one				.FILL		#-1
	neg_48				.FILL		#-48
	pos_48				.FILL		#48
	neg_57				.FILL		#-57
	pos_57				.FILL		#57
	DEC_10				.FILL		#10
	DEC_3				.FILL		#3
	NEG_DEC_15			.FILL		#-15
	POS_DEC_15			.FILL		#15
	newline				.FILL		'\n'
	prompt 				.STRINGZ	"\nEnter which machine you want the status of (0 - 15), followed by ENTER: "
	Error_msg_2			.STRINGZ	"\nERROR INVALID INPUT"
	backup_r0_4600		.BLKW		#1
	backup_r3_4600		.BLKW		#1
	backup_r4_4600		.BLKW		#1
	backup_r5_4600		.BLKW		#1
	backup_r7_4600		.BLKW		#1
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,15}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
; WITHOUT leading 0's, a leading sign, or a trailing newline.
;      Note: that number is guaranteed to be in the range {#0, #15}, 
;            i.e. either a single digit, or '1' followed by a single digit.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------
	.ORIG	x4800
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------

	ST	R0,	backup_r0_4800
	ST	R2,	backup_r2_4800
	ST	R7,	backup_r7_4800
	
	LD		R2,	NEG_DEC_10
	ADD		R1,	R1,	R2
	BRn		SINGLE_DIGIT
	BRzp	DOUBLE_DIGIT
	SINGLE_DIGIT
		LD	R2,	POS_DEC_10
		ADD	R1,	R1,	R2
		LD	R2,	DEC_48
		ADD	R1,	R1,	R2
		ADD	R0,	R1,	#0
		OUT
		BR	END_DOUBLE_DIGIT
	END_SINGLE_DIGIT
	DOUBLE_DIGIT
		LD	R0,	DEC_49
		OUT
		LD	R2,	DEC_48
		ADD	R1,	R1,	R2
		ADD	R0,	R1,	#0
		OUT
	END_DOUBLE_DIGIT
		
	LD	R0,	backup_r0_4800
	LD	R2,	backup_r2_4800
	LD	R7,	backup_r7_4800
	
	RET
	
;--------------------------------
;Data for subroutine print number
;--------------------------------
	
	NEG_DEC_10		.FILL	#-10
	POS_DEC_10		.FILL	#10
	DEC_48			.FILL	#48
	DEC_49			.FILL	#49
	backup_r0_4800	.BLKW	#1
	backup_r2_4800	.BLKW	#1
	backup_r7_4800	.BLKW	#1

.ORIG x6A00
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xBA00			; Remote data
BUSYNESS .FILL x0001		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;---------------	
;END of PROGRAM
;---------------	
.END
