COMMENT !
	Description:	This program calculates 4 integers [A, B, C, and D] through the formula (A + B) - (C + D), using the EAX, EBX, ECX, and EDX registers to do so.

	Author:         SHAHAR ANKONINA
	Date:           02/05/2026	LAST EDITED: 02/05/2026
!

INCLUDE Irvine32.inc	; Includes the Irvine32.inc library

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
; Sets data labels for the 4 integers
int_1			SDWORD 1
int_2			SDWORD 2
int_3			SDWORD 3
int_4			SDWORD 4

; Sets data labels for the string introducing the problem
; Allows clean readable printing of the values and result
intro_string	BYTE "For A = 1, B = 2, C = 3, D = 4", 0ah, 0dh
				BYTE "The result of integer expression (A + B) - (C + D) is :   ", 0

.code
main proc
	; Prints the line that explains the values
	mov edx, OFFSET intro_string	; Moves the array of characters from result_string to edx register for printing
	Call WriteString

	; Moves the first and second the values to their respective registers
	mov	eax, int_1					; EAX = A
	mov ebx, int_2					; EBX = B

	; Adds the values in eax register and ebx register and stores the new value back in eax register
	add eax, ebx					; EAX = A + B

	; Moves the third and forth values to their respective registers
	mov ecx, int_3					; ECX = C
	mov edx, int_4					; EDX = D

	; Adds the values in ecx register and edx register and stores the new value back in ecx register
	add ecx, edx					; ECX = C + D

	; Subtracts the values in eax register and ecx register and stores the new value back in eax register
	sub eax, ecx					; EAX = (A + B) - (C + D)
	Call WriteInt					; Prints result

	invoke ExitProcess,0
main endp
end main