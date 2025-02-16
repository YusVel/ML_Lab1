extern A
extern B
extern RESULT
extern a
extern b
extern c

section .data
	num1 dq -88
	num2 dq  1.0

	error_massage db "Вычеслить невозможно! Переменная С не должна быть равна нулю!", 10
	error_massage_size equ $-error_massage



global calculate_us
section .text
calculate_us:

	mov al, [c]
	cmp al,0
	je err
	
	xor eax, eax
	mov eax, 55
	
	sub eax, [b]
	add eax, [a]
	
	mov [A], eax ;подсчитали числитель
	
	finit ; инициализируем сопроцессор
	fild  qword [num1] ; загружаем в первый элемент кольцевого стека st0 -88
	fidiv dword [c] ; деление -88/с
	fadd qword [num2]
	fstp qword[B] ; результат записываем в память с выталкиванием значения из стэка
	
	fild dword [A] ;загружаем в первый элемент кольцевого стека st0 -88
	fdiv qword[B] ; деление А/В
	fstp qword[RESULT] 
	
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