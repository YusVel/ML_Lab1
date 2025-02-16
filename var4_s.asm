extern A ; 32bit
extern RESULT ; 64bit
extern a1 ; 8bit
extern b1 ; 8bit
extern c1 ; 8bit
extern _B ;16 bit
extern _RESULT ;16 bit
extern ostatok_ot_RESULT ;16 bit
global calculate_s

section .data
error_massage db "Вычеслить невозможно! Переменная С не должна быть равна нулю!", 10
error_massage_size equ $-error_massage

section .text
calculate_s:
	
	mov al, [c1]
	cmp al,0
	je err
	
	xor ax, ax
	mov ax, 55
	
	sub al, [b1]
	adc al, [a1]
	
	mov [A], ax ;подсчитали числитель

	xor ax,ax
	mov ax, -88
	idiv byte [c1] 
	add ax, 1
	cbw
	cwd
	mov [_B], ax
	xor dx,dx
	mov bx, ax

	mov ax, [A]

	idiv  bx
	mov [ostatok_ot_RESULT], dx 

	mov [_RESULT], ax

	ret
	
	err: 
		mov rsi, error_massage
		mov rdx, error_massage_size
		mov rdi, 1
		mov rax, 1
		syscall 
		mov rax, 60
		mov rdi, 0
		syscall
		