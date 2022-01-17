build:
	flex tema.l
	gcc lex.yy.c

run_test0:
	./a.out tests/in0

run_test1:
	./a.out tests/in1

run_test2:
	./a.out tests/in2

run_test3:
	./a.out tests/in3