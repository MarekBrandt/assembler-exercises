; Program przyk�adowy ilustruj�cy operacje SSE procesora
; Poni�szy podprogram jest przystosowany do wywo�ywania
; z poziomu j�zyka C (program arytmc_SSE.c)
.686
.XMM ; zezwolenie na asemblacj� rozkaz�w grupy SSE
.model flat
public _int2float
.code
_int2float PROC
 push ebp
 mov ebp, esp
 push ebx
 push esi
 push edi
 mov esi, [ebp+8] ; adres pierwszej tablicy
 mov edi, [ebp+12] ; adres drugiej tablicy
 ;mov ebx, [ebp+16] ; adres tablicy wynikowej
; �adowanie do rejestru xmm5 czterech liczb zmiennoprzecin-
; kowych 32-bitowych - liczby zostaj� pobrane z tablicy,
; kt�rej adres poczatkowy podany jest w rejestrze ESI
; interpretacja mnemonika "movups" :
; mov - operacja przes�ania,
; u - unaligned (adres obszaru nie jest podzielny przez 16),
; p - packed (do rejestru �adowane s� od razu cztery liczby),
; s - short (inaczej float, liczby zmiennoprzecinkowe
; 32-bitowe)
 movups xmm5, [esi]
; sumowanie czterech liczb zmiennoprzecinkowych zawartych
; w rejestrach xmm5 i xmm6
 cvtpi2ps xmm6, qword PTR [esi]
 
; zapisanie wyniku sumowania w tablicy w pami�ci
 movups [edi], xmm6
 pop edi
 pop esi
 pop ebx
 pop ebp
 ret
_int2float ENDP

END