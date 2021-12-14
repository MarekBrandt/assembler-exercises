; Program przyk³adowy ilustruj¹cy operacje SSE procesora
; Poni¿szy podprogram jest przystosowany do wywo³ywania
; z poziomu jêzyka C (program arytmc_SSE.c)
.686
.XMM ; zezwolenie na asemblacjê rozkazów grupy SSE
.model flat
public _oblicz_potege
.data
m dd ?
k dd ?
.code
_oblicz_potege PROC
 push ebp
 mov ebp, esp

 mov edx, [ebp+12] ; m
 mov ebx, [ebp+8] ; k
 mov dword ptr m, edx
 mov dword ptr k, ebx

 finit
 fild dword ptr k
 fld1
 fscale ; teraz w st(0) 2^k
 fild dword ptr m
 fadd st(0), st(1)

 pop ebp
 ret
_oblicz_potege ENDP

END