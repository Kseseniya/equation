; Программа для Visual Studio на платформе x86
.686
.model flat, c

; прототипы библиотечных функций
gets proto c
puts proto c
system proto c

; подключение библиотек языка Си
includelib msvcrt.lib
includelib ucrt.lib
includelib legacy_stdio_definitions.lib

; секция данных
	.data
input_str db 101 dup(?)  ; строка для ввода
output_str db 101 dup(?) ; строка для вывода
pauza db "pause", 0

; секция кода
buf:
        .zero   1024
main:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     QWORD PTR [rbp-32], OFFSET FLAT:buf ;указатели на строки
        mov     QWORD PTR [rbp-8], OFFSET FLAT:buf
        mov     DWORD PTR [rbp-12], 0 ;создание счётчиков 
        mov     DWORD PTR [rbp-16], 0
        mov     rdx, QWORD PTR stdin[rip] ;вызов функции fgets
        mov     rax, QWORD PTR [rbp-32]
        mov     esi, 1024
        mov     rdi, rax
        call    fgets
        mov     rax, QWORD PTR [rbp-32] ;вызов функции puts
        mov     rdi, rax
        call    puts
        mov     DWORD PTR [rbp-20], 0
.L5:
        mov     eax, DWORD PTR [rbp-20] ;for (int i = 0; s[i] != '\0'; i++)
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-32]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        test    al, al
        je      .L2
        mov     eax, DWORD PTR [rbp-20] ;if ((s[i] >= 'A') && (s[i] <= 'Z'))
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-32]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        cmp     al, 64
        jle     .L3
        mov     eax, DWORD PTR [rbp-20]
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-32]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        cmp     al, 90
        jg      .L3
        add     DWORD PTR [rbp-12], 1 ;увеличение счётчика заглавных букв на 1 
        jmp     .L4
.L3:	`				;выполняется, если текущий символ не заглавная буква, проверка является ли этот символ прописной буквой
        mov     eax, DWORD PTR [rbp-20]
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-32]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        cmp     al, 96
        jle     .L4
        mov     eax, DWORD PTR [rbp-20]
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-32]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        cmp     al, 122
        jg      .L4
        add     DWORD PTR [rbp-16], 1 ;увеличение счётчика прописных букв на 1
.L4:
        add     DWORD PTR [rbp-20], 1 ;увеличение счётчика в цикле на 1
        jmp     .L5
.L2:					;выполняется после выхода из цикла
        mov     eax, DWORD PTR [rbp-12] ;сравнение счётчиков символов
        cmp     eax, DWORD PTR [rbp-16]
        jne     .L6
        mov     rax, QWORD PTR [rbp-32] ;вызов функции, которая выполняется при соблюдении условия
        mov     rdi, rax
        call    condition_1(char*)
        mov     QWORD PTR [rbp-8], rax
        jmp     .L7			
.L6:					;вызов функции, если условие не выполняется
        mov     rax, QWORD PTR [rbp-32] 
        mov     rdi, rax
        call    condition_2(char*)
        mov     QWORD PTR [rbp-8], rax
.L7:					;вывод изменённой строки
        mov     rax, QWORD PTR [rbp-8]
        mov     rdi, rax
        call    puts
        mov     eax, 0
        leave
        ret
condition_1(char*):
        push    rbp
        mov     rbp, rsp
        mov     QWORD PTR [rbp-24], rdi
        mov     DWORD PTR [rbp-4], 0
.L12:
        mov     eax, DWORD PTR [rbp-4] ;цикл for
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-24]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        test    al, al
        je      .L10			;выход из цикла
        mov     eax, DWORD PTR [rbp-4]	;сравнение с строчными буквами
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-24]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        cmp     al, 96
        jle     .L11
        mov     eax, DWORD PTR [rbp-4]
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-24]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        cmp     al, 122
        jg      .L11
        mov     eax, DWORD PTR [rbp-4] ;преобразование строчных букв в заглавные
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-24]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        lea     ecx, [rax-32]
        mov     eax, DWORD PTR [rbp-4]
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-24]
        add     rax, rdx
        mov     edx, ecx
        mov     BYTE PTR [rax], dl
.L11:					;увеличение счётчика цикла на 1
        add     DWORD PTR [rbp-4], 1
        jmp     .L12
.L10:					;возвращает значение и выходит из функции
        mov     rax, QWORD PTR [rbp-24]
        pop     rbp
        ret
condition_2(char*):
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     QWORD PTR [rbp-24], rdi
        mov     DWORD PTR [rbp-4], 1
        mov     QWORD PTR [rbp-16], 0
        mov     esi, 1			;вызов фуннкции calloc
        mov     edi, 1024
        call    calloc
        mov     QWORD PTR [rbp-16], rax
        mov     rax, QWORD PTR [rbp-24]
        movzx   edx, BYTE PTR [rax]
        mov     rax, QWORD PTR [rbp-16]
        mov     BYTE PTR [rax], dl
        mov     DWORD PTR [rbp-8], 1
.L17:
        mov     eax, DWORD PTR [rbp-8]
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-24]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        test    al, al
        je      .L15			;выход из цикла
        mov     eax, DWORD PTR [rbp-8]
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-24]
        add     rax, rdx
        movzx   edx, BYTE PTR [rax]
        mov     eax, DWORD PTR [rbp-8]
        cdqe
        lea     rcx, [rax-1]
        mov     rax, QWORD PTR [rbp-24]
        add     rax, rcx
        movzx   eax, BYTE PTR [rax]
        cmp     dl, al			;if (s[i] != s[i - 1])
        je      .L16			;если условие не выполняется
        mov     eax, DWORD PTR [rbp-8]  ;s1[j] = s[i]
        movsx   rdx, eax
        mov     rax, QWORD PTR [rbp-24]
        add     rax, rdx
        mov     edx, DWORD PTR [rbp-4]
        movsx   rcx, edx
        mov     rdx, QWORD PTR [rbp-16]
        add     rdx, rcx
        movzx   eax, BYTE PTR [rax]
        mov     BYTE PTR [rdx], al
        add     DWORD PTR [rbp-4], 1
.L16:
        add     DWORD PTR [rbp-8], 1
        jmp     .L17
.L15:
        mov     rax, QWORD PTR [rbp-16]
        leave
        ret
