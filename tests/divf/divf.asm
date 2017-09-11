%define PER_CYCLE_REPEAT 1
%define N_LOOPS 20
%define RUN_DIVISOR 1

section .data

double_value1:      dq 31.4159265358
double_value2:      dq 20.0

section .text

%macro dummy 0
%endmacro

%macro do_setup 0
    finit
    FLD dword [double_value1]
    FLD dword [double_value2]
%endmacro


%macro do_test 0
    fdiv
%endmacro

global _main
_main:
    common_init
    benchmark_setup

    run_test
    call _exit

