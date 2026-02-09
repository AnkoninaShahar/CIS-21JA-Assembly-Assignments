COMMENT !
	Description:	Takes a given array and shifts every element one space to the right while wrapping the last element to the beginning.

	Author:         SHAHAR ANKONINA
	Date:           02/23/2026	LAST EDITED: 02/09/2026
!

INCLUDE Irvine32.inc	; Includes the Irvine32.inc library

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
array SDWORD 10h, 20h, 30h, 40h 					; The given array

; The strings that format the output
msg_origin BYTE "The original array is: ", 0ah, 0dh, 0
msg_shift BYTE "The shifted array is: ", 0ah, 0dh, 0

.code
main proc
	
	;		Prints the Array (Pre Shift)
	;--------------------------------------------------
	mov edx, OFFSET msg_origin						; Stores the original array format string in the EDX register
	Call WriteString								; Prints the value in the EDX register

	mov esi, OFFSET array							; Stores the offset memory address of the array in the ESI register
	mov ecx, LENGTHOF array							; Stores the number of elements in the array in the ECX register
	mov ebx, TYPE array								; Stores the size of a single element in the array (4 bytes) in the EBX register
	Call DumpMem									; Dumps the data in the array

	Call Crlf										; Prints a new line

	;			 Shifts the Array Elements
	;--------------------------------------------------
	mov eax, array[SIZEOF array - TYPE array]		; Stores the last element of the array in the EAX register

	mov esi, 0										; Sets the source starting index to 0 (the first element of the array)
	mov ecx, LENGTHOF array							; Sets the loop counter to the number of elements in the array
	
	; Loops through array shifting each element to the right by one
	Shift_Elements:
		xchg eax, array[esi]						; Exchanges the the values between the EAX register and a slot in the array
		add esi, TYPE array							; Increments the ESI register (index) to point to the next element by adding the byte size 
		
		; Decrements ECX register (loop counter)
		; Checks if the ECX register is 0
		; If so -> exit loop, else -> loop Shift_Elements
		loop Shift_Elements

	;		Prints the Array (Post Shift)
	;--------------------------------------------------
	mov edx, OFFSET msg_shift						; Stores the shifted array format string in the EDX register
	Call WriteString								; Prints the value in the EDX register

	mov esi, OFFSET array							; Stores the offset memory address of the array in the ESI register
	mov ecx, LENGTHOF array							; Stores the number of elements in the array in the ECX register
	mov ebx, TYPE array								; Stores the size of a single element in the array (4 bytes) in the EBX register
	Call DumpMem									; Dumps the data in the array

	Call Crlf										; Prints a new line

	invoke ExitProcess,0
main endp
end main