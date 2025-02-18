global get_valid_int
global stdout
extern edge1 ; интервал допустимых значений
extern edge2

section .data
	main_massage db "Введите число: "
	main_massage_size equ ($-main_massage)
	error_massage db "Error! Введите число повторно: "
	error_massage_size equ ($-error_massage)



section .bss 
input_massage resb 32
input_massage_size equ ($-input_massage)
input_bytes dq ? ; количество введенных байт
sign_minus resb 1

section .text

get_valid_int:
	mov [sign_minus] , word 0
	
	mov rsi, main_massage
	mov rdx, main_massage_size
	call stdout  ; вывод сообщения 
	call stdin	; ввод сообщения 
				; проходим по массиву символов и проверяем их >=48 &&<=57
	xor rcx, rcx
	mov rcx, [input_bytes]
	movzx rbx, byte [input_massage + rcx] ; последний символ обязательно 10
while:  ; цикл для проверки правильности ввода числа
	dec rcx ;  если счетчик упал ниже нуля, то выходим из цикла
	js endwhile ;
	; если первый (rcx =0 )символ '-',то  значение в rax * -1  и выходим из цикла
	cmp rcx, 0 ;  
	je check_sign ; проверяем первый символ  = '-'
back_check:
	movzx rbx, byte [input_massage + rcx]
	cmp rbx, 48 ;
	jb error; если регистр rbx меньше 47 , т.е введена не цифра

	cmp rbx, 57;
	ja error; если регистр rbx больше 58 ,т.е введена не цифра

	cmp rcx, 0 ;проверяем каждый символ, пока счетчик будет не равен 0
	jne while

endwhile:
; обнуляем три регистра для счетчика символов, для множителя единиц десятков сотен и т.д
mov rbx, 1	; множитель : единицы, десятки, сотни, тысячи .......10^n
xor rax, rax ; возвращаемый результат всегда в rax
xor rcx, [input_bytes]; счетчик символов
dec rcx ;  уменьшае счетчик на единицу так как в строке сиволы начинаются с нуля.
xor r8, r8

f_while:
	cmp [sign_minus],  byte 1 ; ; если поднят импровизированный флаг знака 
	je make_minus
back_minus:	
	movzx r8, byte [input_massage +rcx] ; помещаем в регист номер последнего символа в строке
	sub r8, 48 ; В результате вычитания получаем реальное количество единиц, десятков, сотен.....

	imul r8, rbx ; 1* единицы, 10*десятки, 100*сотни ......

	add rax, r8 ; суммируем все 

	dec rcx ; счетчик символа уменьшае на единицу
	imul rbx, 10 
	xor r8, r8
	cmp rcx, 0
jge f_while
almost_end:
; проверяем входит ли введеное значение в интервал [edge1,edge2]
cmp eax, [edge1]
jl error
cmp eax, [edge2]
jg error

ret ; возвращаем итог ввода

error:
	mov rsi, error_massage
	mov rdx, error_massage_size
	call stdout 
	call stdin	; ввод сообщения 
	xor rcx, rcx
	mov rcx, [input_bytes]
	xor rbx,rbx
	movzx rbx, byte [input_massage + rcx] ; последний символ обязательно 10
	jmp while
	
stdout:
	mov rdi, 1
	mov rax, 1
	syscall
	ret
stdin:
	mov rdi, 0
	mov rax, 0
	mov rsi, input_massage
	mov rdx, input_massage_size
	syscall
	dec rax ; если введен только 1 символ №10,то повторно запрашиваем ввод данных
	jz get_valid_int
	mov [input_bytes],  rax
	ret
	
	check_sign:
	cmp [input_massage], byte 45
	je sign_
	jmp back_check
	sign_:
	mov [sign_minus],  byte 1
	jmp endwhile
	
	make_minus:
	cmp rcx, 0 
	je do_minus
	jmp back_minus
	do_minus:
	imul rax, -1
	jmp almost_end