.686
.model flat

public _srednia_harm
.data
	actual dd ?
	sum dd +0.0
	el_number dd ?
.code
_srednia_harm PROC
	push ebp
	mov ebp, esp
	; current stack:
	; ebp+8 array adress
	; ebp + 12 number of elements

	mov eax, [ebp+8] ; eax contains adress of array

	mov ecx, [ebp+12] ; number of elements
	mov dword ptr el_number, ecx
	mov edi, 0 ; counter
	srednia:
		mov edx, [eax+4*edi]
		mov dword ptr actual, edx

		finit
		fld dword ptr sum
		fld1
		; coprocessor stack st(0) = 1, st(1) = sum
		fdiv dword ptr actual
		faddp st(1), st(0)

		fstp dword ptr sum
		inc edi ; increasing counter

		loop srednia

	finit
	fild dword ptr el_number
	fdiv dword ptr sum
	

	pop ebp
	ret
_srednia_harm ENDP
END