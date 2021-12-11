public suma_siedmiu_liczb
.code
suma_siedmiu_liczb PROC
push rbp
mov rbp, rsp
mov [rbp+16], rcx
mov [rbp+24], rdx
mov [rbp+32], r8
mov [rbp+40], r9

mov rcx, 7 ; liczba obiegow petli
mov rdx, 2; liczba aktualnego obiegu
mov rax, 0 ; suma liczba

etk:
add rax, [rbp+8*rdx]
inc rdx ; zwiekszam obieg
dec rcx ; zmniejszam liczbe obiegow
jnz etk

pop rbp
ret
suma_siedmiu_liczb ENDP
END