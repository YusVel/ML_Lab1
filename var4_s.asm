extern A ; 32bit
extern RESULT ; 64bit
extern a1 ; 8bit
extern b1 ; 8bit
extern c1 ; 8bit
extern _B ;16 bit
extern _RESULT ;16 bit
extern ostatok_ot_RESULT ;16 bit


global calculate_s
section .text
calculate_s:

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