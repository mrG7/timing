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
%line 5+1 addf.asm

[section .data]

double_value1: dq 31.4159265358
double_value2: dq 20.0
double_value3: dq 100.0
double_value4: dq 200.35

[section .text]

%line 17+1 addf.asm

%line 25+1 addf.asm


%line 32+1 addf.asm

[global _main]
_main:

%line 35+0 addf.asm
 push qword rbp
 mov rbp, rsp

 call _getpid
 mov [pid], rax
%line 36+1 addf.asm
 mov r8, 0xffffffff
%line 36+0 addf.asm
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
 FLD dword [double_value3]
 FLD dword [double_value4]
 finit
 FLD dword [double_value1]
 FLD dword [double_value2]
 FLD dword [double_value3]
 FLD dword [double_value4]
 XOR eax, eax
 CPUID
 rdtsc
 shl rdx, 32
 or rdx, rax
 sub rdx, r15
 mov r9, rdx
 fadd
 fadd
 fadd

 cmp qword r9, r8
 cmovl r8, r9

 sub r14, 1
 mov rax, r14
 jnz benchmark_setup_cycle

 mov [loop_overheads], r8
%line 37+1 addf.asm

 mov r14, 100
%line 38+0 addf.asm

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
 FLD dword [double_value3]
 FLD dword [double_value4]
 fadd
 fadd
 fadd
 finit
 FLD dword [double_value1]
 FLD dword [double_value2]
 FLD dword [double_value3]
 FLD dword [double_value4]
 fadd
 fadd
 fadd
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
 mov r8, 2*3

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
%line 39+1 addf.asm
 call _exit

