global	input_massage 
global	input_massage_size 
global	input_bytes  ; количество введенных байт  - 32 макс
global edge1
global edge2

extern get_valid_int
extern stdout

section .data
msg1 db "Велиметов Юсуп Касумович, ПИБ 32 з, ЛАБ 1: Вариант 4", 10
msg1_size equ $-msg1
msg2 db "Тип вводимой переменной:",10,"0 - int16_t",10,"1 - int8_t -->"
msg2_size equ $-msg2


section .bss 
input_massage resb 32
input_massage_size equ ($-input_massage)
input_bytes dq ? ; количество введенных байт
edge1 dq ?; макс и мин границы вводимых значений включительно
edge2 dq ?

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
	mov [edge2], dword 125
	call get_valid_int

exite:
	mov rax, 60
	mov rdi, 0
	syscall