COMMENT !
	Description:	Converts a set of integers from big endian to little endian

	Author:         SHAHAR ANKONINA
	Date:           02/23/2026	LAST EDITED: 02/09/2026
!

INCLUDE Irvine32.inc	; Includes the Irvine32.inc library

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
bigEndian BYTE 12h,34h,56h,78h					; Big endian set of integers
littleEndian DWORD ?							; Little endian converted result

.code
main proc
	mov ah, BYTE ptr bigEndian					; Stores the most significant byte from bigEndian in the high 8 bits of the 16 bit AX register (AH)
	mov al, BYTE ptr bigEndian + 1				; Stores the second most significant byte from bigEndian in the low 8 bits of the 16 bit AX register (AL)
	mov WORD ptr littleEndian + 2, ax			; Stores the value in the AX register into the most significant 2 bytes of littleEndian

	mov ah, BYTE ptr bigEndian + 2				; Stores the second least significant byte from bigEndian in the high 8 bits of the 16 bit AX register (AH)
	mov al, BYTE ptr bigEndian + 3				; Stores the least significant byte from bigEndian in the low 8 bits of the 16 bit AX register (AL)
	mov WORD ptr littleEndian, ax				; Stores the value in the AX register into the least significant 2 bytes of littleEndian

	; Outputs all the data in bigEndian
	mov esi, OFFSET bigEndian					; Stores the offset memory address of bigEndian in the ESI register
	mov ecx, SIZEOF bigEndian					; Stores the total byte size of bigEndian in the ECX register
	mov ebx, BYTE								; Stores a the size of a byte in the EBX register
	Call DumpMem								; Dumps the data in big endian

	; Outputs all the data in littleEndian
	mov esi, OFFSET littleEndian				; Stores the offset memory address of littleEndian in the ESI register
	mov ecx, SIZEOF littleEndian				; Stores the total byte size of littleEndian in the ECX register
	mov ebx, BYTE								; Stores a the size of a byte in the EBX register
	Call DumpMem								; Dumps the data in big endian

	invoke ExitProcess,0
main endp
end main