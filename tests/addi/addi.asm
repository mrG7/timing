%define PER_CYCLE_REPEAT 32
%define N_LOOPS 250
%define RUN_DIVISOR 4

section .text

%macro dummy 0
%endmacro

%macro do_setup 0
    mov rax, 0
    mov rbx, 27
    mov rcx, 50
%endmacro


%macro do_test 0
    add rax, 0xcc
    add rbx, 0xdd
    add rcx, 0xee
    add rax, rcx
%endmacro

global _main
_main:
    common_init
    benchmark_setup

    run_test
    call _exit

