Велиметов Юсуп Касумович, лабораторная работа 1, вариант 4.
Программа состоит из нескольких модулей-файлов:
1) main.asm - точка входа, здесь описана функция _start
2) get_valid_num.asm - функция ввода валидного значения числа с предварительным указанием отрезка [edge1,edge2]!!!! edge2>=edge1
3) var4_s.asm - здесь описана функция calculate_s, которая считывает значение по формуле (вариант 4) без математического сопроцессора и сохраняет их в глобальные переменные
4) var4_us.asm -  здесь описана функция calculate_us, которая выполняет тоже, что и предыдущая, но с участием сопроцессора
5) print_rax.asm 
6) print_xmm0.asm - функции для вывода результатов: первая для печати в консоль числа в регистре RAX, вторая для регистра хмм0 ( для чисел с плавующей точкой). Используется округление до сотых. (SSE -инчтрукции)
7) makefile
Функции 3 и 4 успешно интегрированы из лабораторной работы 2 согласно заданию. 
На этапе ввода данных осуществляется контроль: 
- ввод только целых числел
- ввод чисел из отрезка [edge1,edge2]!!!! edge2>=edge1
- исключение деления на ноль.
Запуск программы осуществляется на Linux (процессор x64 intel):
./main 
Оценка полученных результатов:(55-b+a)/(-88/c+1) 
При подсчете результата без применения сопроцессора получал всегда неточный результат, когда вводился параметр С такой, при котором при делении -88 на С имелся остаток, который в дальнейшем не учитывался в расчетах и в итоге давал искаженный результат. Если вводился параметр С такой, что -88 делился на С без остатка, то результат вычисления был всегда с точностью до единиц. 
При использовании сопроцессора результат вычисления всегда был точным и соответствовал вычислениям на Си (из лабораторной работы 2)


