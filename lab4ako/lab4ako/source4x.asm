.686
.model flat

public _odejmowanie 

.data
.code
_odejmowanie PROC
push ebp
mov ebp, esp
push edi
mov ecx, [ebp+8] ; addres adresu odjemnej
mov edx, [ebp+12] ; adres odjemnik
mov edi, [ecx] ; adres odjemnej
mov eax, [edi]
sub eax, [edx]
pop edi
pop ebp
ret
_odejmowanie ENDP
END