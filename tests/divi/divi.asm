%define PER_CYCLE_REPEAT 16
%define N_LOOPS 250
%define RUN_DIVISOR 2

section .text


%macro do_setup 0
%endmacro

%macro dummy 0
    mov r8, 65521
    mov rax, 2147483647
    cqo 
    mov r8, 2
    mov rax, 100
    cqo
%endmacro


%macro do_test 0
    mov r8, 65521
    mov rax, 2147483647
    cqo
    div qword r8
    mov r8, 2
    mov rax, 100
    cqo
    div qword r8
%endmacro


global _main
_main:
    common_init
    benchmark_setup

    run_test
    call _exit

