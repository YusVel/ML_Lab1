all:
	nasm -f elf64 -F dwarf get_valid_num.asm -o get_valid_num.o 
	nasm -f elf64 -F dwarf main.asm -o main.o 
	ld -g main.o get_valid_num.o -o main -no-pie
	./main
