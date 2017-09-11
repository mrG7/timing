%use altreg
DEFAULT REL

%define BENCH_CYCLES 2048
%define SLEEP_MASK 0xff

section .text

; libc functions
extern _printf
extern _usleep
extern _getpid
extern _exit

%define iARG0 rdi
%define iARG1 rsi
%define iARG2 rdx
%define iARG3 rcx
%define iARG4 r8
%define iARG5 r9
%define fARG0 xmm0
%define fARG1 xmm1

%macro common_init 0
    ; setup stack pointers
    push  qword rbp
    mov   rbp, rsp
    ; get the pid
    call _getpid
    mov [pid], rax
%endmacro

%macro timer_start 0
    rdtsc
    shl rdx, 32
    or rdx, rax
    mov r15, rdx
%endmacro

%macro timer_end 1
    rdtsc
    shl rdx, 32
    or rdx, rax
    sub rdx, r15
    mov %1, rdx
%endmacro

; Wrappers for printf..
%macro inline_str 2
    jmp %%endstr
%%str:  db %2,0
%%endstr:
    mov %1, %%str
%endmacro

%macro printf_i 2
    inline_str iARG0, %1
    mov iARG1, %2
    call _printf
%endmacro

%macro printf_x 2
    movsd xmm6, %2
    inline_str iARG0, %1
    movsd fARG0 , %2
    call _printf
%endmacro

%macro printf_ix 3
    inline_str iARG0, %1
    mov iARG1, %2
    movsd fARG0, %3
    call _printf
%endmacro

%macro printf_ff 3
    inline_str iARG0, %1
    movsd fARG0, %2
    movsd fARG1, %3
    call _printf
%endmacro

%macro printf_ii 3
    inline_str iARG0, %1
    mov iARG1, %2
    mov iARG2, %3
    call _printf
%endmacro

%macro kill_time 0
      XOR eax, eax
      CPUID
%endmacro

%macro benchmark_setup 0
    mov r8, 0xffffffff
    mov r14, BENCH_CYCLES
    align 64
    benchmark_setup_cycle:
        timer_start
        kill_time
        %rep PER_CYCLE_REPEAT
        do_setup
        dummy
        %endrep
        kill_time        
        timer_end r9
        do_test

        cmp qword  r9, r8
        cmovl      r8, r9

        sub r14, 1
        mov rax, r14
    jnz benchmark_setup_cycle

    mov [loop_overheads], r8
%endmacro

%macro run_test 0
    mov r14, N_LOOPS

    test_cycle:

        mov rax, r14
        and rax, SLEEP_MASK
        cmp rax, 0
        jnz nosleep
            mov iARG0, 5000
            call _usleep
        nosleep:

        align 64
        timer_start
        kill_time
        %rep PER_CYCLE_REPEAT
            do_setup
            do_test
        %endrep
        kill_time
        timer_end rbx

        mov iARG0, out_str
        mov iARG1, [pid]
        mov iARG2, rbx
        mov iARG3, [loop_overheads]
        mov iARG4, PER_CYCLE_REPEAT*RUN_DIVISOR

        mov rax, r14
        and rax, SLEEP_MASK
        cmp rax, 0
        jz noprint
            call _printf
        noprint:

        sub r14, 1

        mov rax, r14
        cmp rax, 0
    jnz test_cycle

    mov iARG0, 0
%endmacro

section .data
out_str: db `%i,%llu,%llu,%llu\n\0`
loop_overheads: dq 0
pid: dq 0
