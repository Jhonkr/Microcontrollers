;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
; ex02_Jhonatan
; pastro@eletrica.ufpr.br
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .sect	".text"
course		.string	"Curso de Engenharia Eletrica", 0x01
class		.string "TE328 - Microprocessadores e Microcontroladores", 0x02
name		.string "Jhonatan Kobylarz Ribeiro", 0x03

            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here: Write on memory the 3 phrases above
;-------------------------------------------------------------------------------

			call 	#course1
			call 	#class1
			call 	#name1

			jmp 	$

;-------------------------------------------------------------------------------

course1:	mov.w	#course, R10
			mov.w	#0x0200, R12

loop:		mov.b	@R10,	0(R12)
			cmp.b	#0x01,	0(R10)
			jnz		comp
			ret

comp:		cmp.b	#0x02, 0(R10)
 			jnz		comp1

comp1:		cmp.b	#0x03, 0(R10)
 			jnz		incr

incr:		inc.w	R10						; R10 = R10 + 1
			inc.w	R12						; R12 = R12 + 1
			jmp 	loop					; Back to loop

;-------------------------------------------------------------------------------

class1:		mov.w	#class, R10
			mov.w	#0x0230, R12

loop1:		mov.b	@R10, 0(R12)			; Pointer on R10
			cmp.b	#0x02, 0(R10)
			jnz		comp2
			ret

comp2:		cmp.b	#0x03, 0(R10)
			jnz		incr1

incr1:		inc.w	R10						; R10 = R10 + 1
			inc.w	R12						; R12 = R12 + 1
			jmp 	loop1					; Back to loop

;-------------------------------------------------------------------------------

name1:		mov.w	#name, R10
			mov.w	#0x0270, R12

loop2:		mov.b	@R10, 0(R12)			; Pointer on R10
			cmp.b	#0x03, 0(R10)
			jnz		incr2
			ret

incr2:		inc.w	R10						; R10 = R10 + 1
			inc.w	R12						; R12 = R12 + 1
			jmp 	loop2					; Back to loop

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
