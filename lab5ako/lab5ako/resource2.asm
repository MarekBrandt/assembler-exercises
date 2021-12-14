.686
.model flat

public _nowy_exp
.data
	xval dd ?
	fraction_up dd +1.0
	sum dd +0.0
	fraction_down dd +1.0
	counter dd +1.0
.code
_nowy_exp PROC
	push ebp
	mov ebp, esp
	mov edx, [ebp+8] ; x
	mov dword ptr xval, edx
	fild dword ptr xval
	fist dword ptr xval ; converting xval to float
	mov ecx, 19
	licz:
		finit
		fld dword ptr fraction_up
		fmul dword ptr xval ; st(0) = fraction_up * x
		fst dword ptr fraction_up ; copying actual value to mem
		fld dword ptr fraction_down 
		fmul dword ptr counter ; st(0) = fraction down * counter
		fst dword ptr fraction_down ; copying actual value to mem
		fdivp ; fraction up / fraction down
		fadd dword ptr sum ; adding sum to fraction
		fst dword ptr sum ; copying sum to mem
		fld dword ptr counter ; increasing counter
		fld1
		fadd st(0), st(1)
		fstp dword ptr counter ; now there is only sum on stack
		fstp st(0)

		loop licz

		; adding first element : 1
		fld1
		faddp

	pop ebp
	ret
_nowy_exp ENDP
END