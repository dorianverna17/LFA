build:
	flex tema.l
	gcc lex.yy.c

run_test0:
	./a.out in0

run_test1:
	./a.out in1

run_test2:
	./a.out in2

run_test3:
	./a.out in3