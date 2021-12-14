; Program przyk³adowy ilustruj¹cy operacje SSE procesora
; Poni¿szy podprogram jest przystosowany do wywo³ywania
; z poziomu jêzyka C (program arytmc_SSE.c)
.686
.XMM ; zezwolenie na asemblacjê rozkazów grupy SSE
.model flat
public _dziel
.data
dzielnik dq 2 dup (?)
.code
_dziel PROC
 push ebp
 mov ebp, esp

 push ebx
 push esi
 push ecx
 mov esi, [ebp+8] ; adres pierwszej tablicy
 mov ecx, [ebp+12] ; n
 mov ebx, [ebp+16] ; dzielnik
 mov edx, 0 ; licznik

 fld dword ptr [ebp+16]
 fst qword ptr [dzielnik]
 fst qword ptr [dzielnik+8]
 ;mov dword ptr dzielnik,  ebx
 ;mov dword ptr dzielnik+4,  0
;mov dword ptr dzielnik+8,  ebx
;mov dword ptr dzielnik+12,  0

 ptl:
	movupd xmm5, [esi+edx]
	divpd xmm5, dzielnik
	movupd [esi+edx], xmm5
	add edx, 16
	loop ptl

 pop ecx
 pop esi
 pop ebx
 pop ebp
 ret
_dziel ENDP

END