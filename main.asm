global	input_massage 
global	input_massage_size 
global	input_bytes  ; количество введенных байт  - 32 макс
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

section .data
msg1 db "Велиметов Юсуп Касумович, ПИБ 32 з, ЛАБ 1: Вариант 4", 10
msg1_size equ $-msg1
msg2 db "Тип вводимой переменной:",10,"0 - uint16_t",10,"1 - int8_t -->"
msg2_size equ $-msg2
msg3 db "Введите а:"
msg3_size equ $-msg3
msg4 db "Введите в:"
msg4_size equ $-msg4
msg5 db "Введите с:"
msg5_size equ $-msg5
msg6 db "Расчет для uint16_t: ",10
msg6_size equ $-msg6
msg7 db "Расчет для int8_t: ",10
msg7_size equ $-msg7

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
B dd 0 ; 32bit
_B dw 0;16 bit
_RESULT dw 0;16 bit
ostatok_ot_RESULT dw 0;16 bit



section .bss 
input_massage resb 32
input_massage_size equ ($-input_massage)
input_bytes dq ? ; количество введенных байт


section .text
global _start
_start:
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
	mov rsi, msg7 ; расчет для int8t
	mov rdx, msg7_size
	call stdout
	jmp exite

ch0:
	mov rsi, msg6 ; расчет для uint16t
	mov rdx, msg6_size
	call stdout





exite:
	mov rax, 60
	mov rdi, 0
	syscall