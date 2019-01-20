; ---------------------------------------------------------------------------
; Tell compiler to generate 64 bit code
; ---------------------------------------------------------------------------
bits 64
; ---------------------------------------------------------------------------
; Data segment:
; ---------------------------------------------------------------------------
section .data use64
printString: db "lol",0
align 16 ; align data constants to the 16 byte boundary
; ---------------------------------------------------------------------------
; Code segment:
; ---------------------------------------------------------------------------
section .text use64
; ---------------------------------------------------------------------------
; Define macro: Invoke
; ---------------------------------------------------------------------------
%macro Invoke 1-*
        %if %0 > 1
                %rotate 1
                mov rcx,qword %1
                %rotate 1
                %if %0 > 2
                        mov rdx,qword %1
                        %rotate 1
                        %if  %0 > 3
                                mov r8,qword %1
                                %rotate 1
                                %if  %0 > 4
                                        mov r9,qword %1
                                        %rotate 1
                                        %if  %0 > 5
                                                %assign max %0-5
                                                %assign i 32
                                                %rep max
                                                        mov rax,qword %1
                                                        mov qword [rsp+i],rax
                                                        %assign i i+8
                                                        %rotate 1
                                                %endrep
                                        %endif
                                %endif
                        %endif
                %endif
        %endif
        ; ------------------------
        ; call %1 ; would be the same as this:
        ; -----------------------------------------
        sub rsp,qword 8
        mov qword [rsp],%%returnAddress
        jmp %1
        %%returnAddress:
        ; -----------------------------------------
%endmacro
; ---------------------------------------------------------------------------
; C management
; ---------------------------------------------------------------------------
global main
extern printf

main:
; -----------------------------------------------------------------------------
; Allocate stack memory
; -----------------------------------------------------------------------------
sub rsp,8*7

; -----------------------------------------------------------------------------
; Call printf with seven parameters
; 4x of them are assigned to registers.
; 3x of them are assigned to stack spaces.
; -----------------------------------------------------------------------------
; Call printf with seven parameters
; -----------------------------------------------------------------------------
Invoke printf,$printString
; -----------------------------------------------------------------------------
; Call printf with seven parameters
; 4x of them are assigned to registers.
; 3x of them are assigned to stack spaces.
; -----------------------------------------------------------------------------
; Call printf with seven parameters
; -----------------------------------------------------------------------------
Invoke printf,$printString

; -----------------------------------------------------------------------------
; Release stack memory
; -----------------------------------------------------------------------------
add rsp,8*7
; -----------------------------------------------------------------------------
; Quit
; -----------------------------------------------------------------------------
mov rax,qword 0
ret

; ----
; END ----
; ----
