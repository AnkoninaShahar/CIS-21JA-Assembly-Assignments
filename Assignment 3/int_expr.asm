COMMENT !
	Description:	This program calculates 4 integers [A, B, C, and D] through the formula (A + B) - (C + D), using the EAX, EBX, ECX, and EDX registers to do so.

	Author:         SHAHAR ANKONINA
	Date:           02/05/2026	LAST EDITED: 01/26/2026
!

INCLUDE Irvine32.inc	; Includes the Irvine32.inc library

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
; Sets data labels for the 4 integers
value_1			SDWORD 1
value_2			SDWORD 2
value_3			SDWORD 3
value_4			SDWORD 4

; Sets data labels for the strings introducing the problem
; Allows clean readable printing of the values and result
string_A		BYTE "For A = ", 0
string_B		BYTE ", B = ", 0
string_C		BYTE ", C = ", 0 
string_D		BYTE ", D = ", 0
result_string	BYTE 0ah, 0dh, "The result of integer expression (A + B) - (C + D) is :   ", 0

.code
main proc
	; Prints the first value used
	mov edx, OFFSET string_A		; Moves the array of characters from string_A to edx register for printing
	Call WriteString
	mov eax, value_1				; Moves the value from value_1 to eax register for printing
	Call WriteInt

	; Prints the second value used
	mov edx, OFFSET string_B		; Moves the array of characters from string_B to edx register for printing
	Call WriteString
	mov eax, value_2				; Moves the value from value_2 to eax register for printing
	Call WriteInt

	; Prints the third value used
	mov edx, OFFSET string_C		; Moves the array of characters from string_C to edx register for printing
	Call WriteString
	mov eax, value_3				; Moves the value from value_3 to eax register for printing
	Call WriteInt

	; Prints the fourth value used
	mov edx, OFFSET string_D		; Moves the array of characters from string_D to edx register for printing
	Call WriteString
	mov eax, value_4				; Moves the value from value_4 to eax register for printing
	Call WriteInt

	; Prints the result line
	mov edx, OFFSET result_string	; Moves the array of characters from result_string to edx register for printing
	Call WriteString

	; Moves all the values to their respective registers
	mov	eax, value_1				; EAX = A
	mov ebx, value_2				; EBX = B

	; Adds the values in eax register and ebx register and stores the new value back in eax register
	add eax, ebx					; EAX = A + B

	; Moves all the values to their respective registers
	mov ecx, value_3				; ECX = C
	mov edx, value_4				; EDX = D

	; Adds the values in ecx register and edx register and stores the new value back in ecx register
	add ecx, edx					; ECX = C + D

	; Subtracts the values in eax register and ecx register and stores the new value back in eax register
	sub eax, ecx					; EAX = (A + B) - (C + D)
	Call WriteInt					; Prints result

	invoke ExitProcess,0
main endp
end main