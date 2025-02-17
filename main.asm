global edge1
global edge2


global A ; 32bit
global RESULT ; 64bit
global a1 ; 8bit
global b1 ; 8bit
global c1 ; 8bit
global a 
global b
global c
global B
global _B ;16 bit
global _RESULT ;16 bit
global ostatok_ot_RESULT ;16 bit

extern get_valid_int
extern stdout
extern p_rax
extern p_xmm0
extern calculate_s
extern calculate_us

section .data
msg1 db "Велиметов Юсуп Касумович, ПИБ 32 з, ЛАБ 1: Вариант 4", 10
msg1_size equ $-msg1
msg2 db "Тип вводимой переменной:",10,"0 - uint16_t",10,"1 - int8_t -->"
msg2_size equ $-msg2
msg3 db "Введите a! "
msg3_size equ $-msg3
msg4 db "Введите b! "
msg4_size equ $-msg4
msg5 db "Введите c! "
msg5_size equ $-msg5
msg6 db "Расчет для int8_t (от -128 до 127): ",10
msg6_size equ $-msg6
msg7 db "Расчет для uint16_t ( от 0 до 65535): ",10
msg7_size equ $-msg7
msg8 db "Расчет без сопроцессора (55-b+a)/(-88/c+1) = "
msg8_size equ $-msg8
msg9 db 10,"Расчет на сопроцессоре (55-b+a)/(-88/c+1) = "
msg9_size equ $-msg9

char_div db '/'
char_add db '+'
char_equ db " = "; 3 chars

edge1 dd 0; макс и мин границы вводимых значений включительно
edge2 dd 0

A dd 0; 32bit
RESULT dq 0.0; 64bit
a1 db 0; 8bit
b1 db 0; 8bit
c1 db 0; 8bit
a dd 0 ; 32bit
b dd 0 ; 32bit
c dd 0 ; 32bit
B dq 0.0 ; 64bit
_B dw 0;16 bit
_RESULT dw 0;16 bit
ostatok_ot_RESULT dw 0;16 bit

;;;;testic dq 0.5

section .text
global _start
_start: ;;;;;;;;;;;;;;;;;;;;MAIN;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	mov rsi, msg1 ; приветствие!
	mov rdx, msg1_size
	call stdout
	
	mov rsi, msg2 ; Выводим второе сообщение
	mov rdx, msg2_size
	call stdout
	mov [edge1], dword 0
	mov [edge2], dword 1
	call get_valid_int ; в rax вернули валидное значение
	cmp ax, [edge1]
	je ch0
; ;;;;;;;;;;;;;;;;;;;;;;;расчет для int8t;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rsi, msg6 
	mov rdx, msg6_size
	call stdout
	mov [edge1], dword -128
	mov [edge2], dword 127

;;;;;;;;;;;;;;;;;;;;;; воодим все 3 "переменные"
	mov rsi, msg3  ; c
	mov rdx, msg3_size
	call stdout
	call get_valid_int
	mov [a1], al

	mov rsi, msg4  ; b
	mov rdx, msg4_size
	call stdout
	call get_valid_int
	mov [b1], al

	mov rsi, msg5  ; c
	mov rdx, msg5_size
	call stdout
	call get_valid_int
	mov [c1], al 

	call calculate_s
;;;;;;;;;;;;;;;;;;;ВЫВОД РЕЗУЛЬТАТА;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov rsi, msg8
	mov rdx, msg8_size
	call stdout 
	movsx rax,  dword [A]
	call p_rax

	mov rsi, char_div
	mov rdx, 1
	call stdout 

	movsx rax, word [_B]
	call p_rax

	mov rsi, char_equ
	mov rdx, 3
	call stdout 

	movsx rax, word [_RESULT]
	call p_rax

	mov rsi, char_add
	mov rdx, 1
	call stdout 

	movsx rax,  word [ostatok_ot_RESULT]
	call p_rax

	mov rsi, char_div
	mov rdx, 1
	call stdout 

	movsx rax, word [_B]
	call p_rax
	jmp exite

ch0: ; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;расчет для uint16t;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rsi, msg7 
	mov rdx, msg7_size
	call stdout
	mov [edge1], dword 0
	mov [edge2], dword 65535

 ;;;;;;;;;;;;воодим все 3 "переменные";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rsi, msg3  ; c
	mov rdx, msg3_size
	call stdout
	call get_valid_int
	mov [a], ax

	mov rsi, msg4  ; b
	mov rdx, msg4_size
	call stdout
	call get_valid_int
	mov [b], ax


	mov rsi, msg5  ; c
	mov rdx, msg5_size
	call stdout
	call get_valid_int
	mov [c], ax

	call calculate_us

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rsi, msg9
	mov rdx, msg9_size
	call stdout 
	movsx rax, dword [A]
	call p_rax

	mov rsi, char_div
	mov rdx, 1
	call stdout 


	movq xmm0, [B]
	call p_xmm0

	mov rsi, char_equ
	mov rdx, 3
	call stdout 

	movq xmm0, [RESULT]
	call p_xmm0



	jmp exite

exite:
	mov rax, 60
	mov rdi, 0
	syscall