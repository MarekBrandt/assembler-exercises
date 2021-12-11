.686
.model flat
public _plus_jeden
.code
_plus_jeden PROC
push ebp ; zapisanie zawartoœci EBP na stosie
mov ebp,esp ; kopiowanie zawartoœci ESP do EBP
push ebx ; przechowanie zawartoœci rejestru EBX
push edx ; przechowanie edx
; wpisanie do rejestru EBX adresu adresu zmiennej zdefiniowanej
; w kodzie w jêzyku C
mov ebx, [ebp+8]
mov eax, [ebx] ; odczytanie adresu zmiennej
mov edx, [eax] ; wpisanie warosci zmiennej
dec edx
mov [eax], edx ; odes³anie wyniku do zmiennej
; uwaga: trzy powy¿sze rozkazy mo¿na zast¹piæ jednym rozkazem
; w postaci: inc dword PTR [ebx]
pop edx
pop ebx
pop ebp
ret
_plus_jeden ENDP
 END