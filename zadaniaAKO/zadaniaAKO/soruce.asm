.686
.model flat

extern _MessageBoxA@16 : PROC
extern __write : PROC
extern _ExitProcess@4 : PROC
.data
input db 3fh
			db 0c3h, 83h
			db 21h, 73h, 7fh
			db 0feh, 0bfh
			
	output	db 100 dup (?)
.code

_main PROC	
	mov ebx, 0ffffffffh
	mov bx, 2
	etykieta:
		sub bx, 1
		jz dalej
		call etykieta
	dalej:
		lea ebx, [dalej]
		sub ebx, [esp]
push	0
call	_ExitProcess@4
_main ENDP
END