%define PER_CYCLE_REPEAT 2
%define N_LOOPS 100
%define RUN_DIVISOR 3

section .data

double_value1:      dq 31.4159265358
double_value2:      dq 20.0
double_value3:      dq 100.0
double_value4:      dq 200.35

section .text

%macro dummy 0
%endmacro

%macro do_setup 0
    finit
    FLD dword [double_value1]
    FLD dword [double_value2]
    FLD dword [double_value3]
    FLD dword [double_value4]
%endmacro


%macro do_test 0
    fadd
    fadd
    fadd
%endmacro

global _main
_main:
    common_init
    benchmark_setup

    run_test
    call _exit

