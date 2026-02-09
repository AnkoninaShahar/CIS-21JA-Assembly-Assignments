COMMENT !
	Description:	Reverses the order of the characters in a given string besides the null character at the end

	Author:         SHAHAR ANKONINA
	Date:           02/28/2026	LAST EDITED: 02/09/2026
!

INCLUDE Irvine32.inc	; Includes the Irvine32.inc library

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
BYTE 4 DUP('$')
source BYTE "This is the source string",0					; The given string to reverse
BYTE 4 DUP('%')	
target BYTE SIZEOF source DUP('#')							; The resulted reversed string
BYTE 4 DUP('^')

.code
main proc
	mov esi, OFFSET source + LENGTHOF source - 2			; Sets the source starting index to the last character that isn't null in the source string
	mov edi, OFFSET target									; Sets the destination starting index to the first character in the target string
	mov ecx, LENGTHOF source - 1							; Sets the loop counter to the number of elements in the source string besides the null character at the end

	; Loops through the strings and reverses the characters
	Reverse_String:
		mov al,[esi]										; Stores the character the ESI register points to in the AL register
		mov [edi], al										; Stores the character in the AL register in the memory address the EDI register points to
		dec esi												; Decrements the ESI register to point to the previous character in source string
		inc edi												; Increments the EDI register to point to the next character in target string
		
		; Decrements ECX register (loop counter)
		; Checks if the ECX register is 0
		; If so -> exit loop, else -> loop Reverse_String
		loop Reverse_String

	mov BYTE ptr [edi], 0									; Adds a null character to the end of the target string

	;										Outputs the Result
	;----------------------------------------------------------------------------------------------
	mov edx, OFFSET source-4      ; display the 4 "$" and source string
	call WriteString
	mov al, source[SIZEOF source-1] ; if the last char of source is Null, then display it as '.'
	cmp al, 0
	jz Disp_Null_char_1
	call WriteChar
	jmp Disp_target_str
	Disp_Null_char_1:
	mov al, '.'                   ; use '.' to represent the Null
	call WriteChar
	Disp_target_str:
	mov edx, OFFSET target-4      ; display the 4 "%" and target string
	call WriteString
	mov al, target[SIZEOF target-1] ; if the last char of target is Null, then display it as '.'
	cmp al, 0
	jz Disp_Null_char_2
	call WriteChar
	jmp Disp_4_hats
	Disp_Null_char_2:
	mov al, '.'                   ; use '.' to represent the Null
	call WriteChar
	Disp_4_hats:
	mov edx, OFFSET target + SIZEOF target   ; display the 4 "^"
	call WriteString

	invoke ExitProcess,0
main endp
end main