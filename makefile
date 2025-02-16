all:
	nasm -f elf64 -F dwarf get_valid_num.asm -o get_valid_num.o 
	nasm -f elf64 -F dwarf main.asm -o main.o 
	nasm -f elf64 -F dwarf var4_s.asm -o var4_s.o 
	nasm -f elf64 -F dwarf var4us.asm -o var4us.o 
	nasm -f elf64 -F dwarf print_rax.asm -o print_rax.o 
	ld -g main.o get_valid_num.o var4us.o var4_s.o  print_rax.o  -o main -no-pie
	gdb ./main