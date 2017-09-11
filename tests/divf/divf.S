%line 2+1 ../common.asm
[default REL]

%line 6+1 ../common.asm

[section .text]


[extern _printf]
[extern _usleep]
[extern _getpid]
[extern _exit]

%line 23+1 ../common.asm

%line 32+1 ../common.asm

%line 39+1 ../common.asm

%line 47+1 ../common.asm


%line 55+1 ../common.asm

%line 61+1 ../common.asm

%line 68+1 ../common.asm

%line 75+1 ../common.asm

%line 82+1 ../common.asm

%line 89+1 ../common.asm

%line 94+1 ../common.asm

%line 119+1 ../common.asm

%line 164+1 ../common.asm

[section .data]
out_str: db `%i,%llu,%llu,%llu\n\0`
loop_overheads: dq 0
pid: dq 0
%line 4+1 divf.asm

[section .data]

double_value1: dq 31.4159265358
double_value2: dq 20.0

[section .text]

%line 14+1 divf.asm

%line 20+1 divf.asm


%line 25+1 divf.asm

[global _main]
_main:

%line 28+0 divf.asm
 push qword rbp
 mov rbp, rsp

 call _getpid
 mov [pid], rax
%line 29+1 divf.asm
 mov r8, 0xffffffff
%line 29+0 divf.asm
 mov r14, 2048
[sectalign 64]
times (((64) - (($-$$) % (64))) % (64)) nop
 benchmark_setup_cycle:
 rdtsc
 shl rdx, 32
 or rdx, rax
 mov r15, rdx
 XOR eax, eax
 CPUID
 finit
 FLD dword [double_value1]
 FLD dword [double_value2]
 XOR eax, eax
 CPUID
 rdtsc
 shl rdx, 32
 or rdx, rax
 sub rdx, r15
 mov r9, rdx
 fdiv

 cmp qword r9, r8
 cmovl r8, r9

 sub r14, 1
 mov rax, r14
 jnz benchmark_setup_cycle

 mov [loop_overheads], r8
%line 30+1 divf.asm

 mov r14, 20
%line 31+0 divf.asm

 test_cycle:

 mov rax, r14
 and rax, 0xff
 cmp rax, 0
 jnz nosleep
 mov rdi, 5000
 call _usleep
 nosleep:

[sectalign 64]
times (((64) - (($-$$) % (64))) % (64)) nop
 rdtsc
 shl rdx, 32
 or rdx, rax
 mov r15, rdx
 XOR eax, eax
 CPUID
 finit
 FLD dword [double_value1]
 FLD dword [double_value2]
 fdiv
 XOR eax, eax
 CPUID
 rdtsc
 shl rdx, 32
 or rdx, rax
 sub rdx, r15
 mov rbx, rdx

 mov rdi, out_str
 mov rsi, [pid]
 mov rdx, rbx
 mov rcx, [loop_overheads]
 mov r8, 1*1

 mov rax, r14
 and rax, 0xff
 cmp rax, 0
 jz noprint
 call _printf
 noprint:

 sub r14, 1

 mov rax, r14
 cmp rax, 0
 jnz test_cycle

 mov rdi, 0
%line 32+1 divf.asm
 call _exit

