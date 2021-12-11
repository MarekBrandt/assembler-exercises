.686
.model flat
public _szukaj_max4
.code
_szukaj_max4 PROC
push ebp ; zapisanie zawartoœci EBP na stosie
mov ebp, esp ; kopiowanie zawartoœci ESP do EBP
mov eax, [ebp+8] ; liczba x
cmp eax, [ebp+12] ; porownanie liczb x i y
jge x_wieksza ; skok, gdy x >= y
; przypadek x < y
mov eax, [ebp+12] ; liczba y
cmp eax, [ebp+16] ; porownanie liczb y i z
jge y_wieksza ; skok, gdy y >= z
; przypadek y < z
; zatem z jest liczb¹ najwieksz¹

mov eax, [ebp+16] ; liczba z
cmp eax, [ebp+20] ; porowananie liczb z i d
jge z_wieksza ; skok, gdy z >= d
wpisz_d: mov eax, [ebp+20] ; liczba d
zakoncz:
pop ebp
ret
x_wieksza:
cmp eax, [ebp+16] ; porownanie x i z
jl  z_wieksza ; skok, gdy x < z
jmp x_wieksza2
y_wieksza:
mov eax, [ebp+12] ; liczba y
cmp eax, [ebp+16] ; porownanie y i z
jge y_wieksza2
z_wieksza:
mov eax, [ebp+16] ; liczba z
cmp eax, [ebp+20] ; porownanie z i d
jge zakoncz ; skok, gdy z >= d
jmp	wpisz_d ; gdy d najwieksze
x_wieksza2:
cmp eax, [ebp+20] ; porownanie x i d
jge zakoncz ; x najwiekszy
jmp wpisz_d
y_wieksza2:
cmp eax, [ebp+20]
jge zakoncz ; y najwiekszy
jmp wpisz_d
_szukaj_max4 ENDP
END