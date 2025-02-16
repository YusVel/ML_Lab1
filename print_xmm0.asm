extern p_rax
extern stdout
global p_xmm0

section .data
point db '.'
minus db '-'
drob_part dq 0
presision dq 100.0 ;  полная хр
presision_rax dd 100
s_minus dq -1.0

section .text
p_xmm0:
	xor rax, rax
	mulsd xmm0, qword [presision]
	cvtsd2si rax, xmm0
	cmp rax, 0
	jl p_minus
back_minus:
	xor rdx,rdx

	idiv dword [presision_rax] 
	mov [drob_part], rdx
	call p_rax
	mov rsi, point
	mov rdx, 1
	call stdout
	
	mov rax, qword [drob_part]
	call p_rax
	ret
	
	p_minus: ; печатаем только один символ "-" 
	imul rax, -1
	mov rsi, minus
	mov rdx, 1
	call stdout
	mulsd xmm0, qword [s_minus]
	cvtsd2si rax, xmm0
	jmp back_minus 