.686
.model flat

extern __write : PROC	
extern _GetSystemTime@4 : PROC	
public _dajMinuty
.data

.code
_dajMinuty PROC
push ebp
mov ebp, esp
mov eax, [ebp+8]
push eax
call _GetSystemTime@4
mov ebx, [ebp+8]
mov eax, 0
mov al, [ebx+10]
pop ebp
ret
_dajMinuty ENDP	
END