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
%line 4+1 addi.asm

[section .text]

%line 9+1 addi.asm

%line 15+1 addi.asm


%line 23+1 addi.asm

[global _main]
_main:

%line 26+0 addi.asm
 push qword rbp
 mov rbp, rsp

 call _getpid
 mov [pid], rax
%line 27+1 addi.asm
 mov r8, 0xffffffff
%line 27+0 addi.asm
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
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 XOR eax, eax
 CPUID
 rdtsc
 shl rdx, 32
 or rdx, rax
 sub rdx, r15
 mov r9, rdx
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx

 cmp qword r9, r8
 cmovl r8, r9

 sub r14, 1
 mov rax, r14
 jnz benchmark_setup_cycle

 mov [loop_overheads], r8
%line 28+1 addi.asm

 mov r14, 250
%line 29+0 addi.asm

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
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
 mov rax, 0
 mov rbx, 27
 mov rcx, 50
 add rax, 0xcc
 add rbx, 0xdd
 add rcx, 0xee
 add rax, rcx
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
 mov r8, 32*4

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
%line 30+1 addi.asm
 call _exit

