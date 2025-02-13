extern A
extern B
extern RESULT
extern a
extern b
extern c

section .data
	num1 dq -88
	num2 dq  1.0

global calculate_us
section .text
calculate_us:

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