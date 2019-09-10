;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
; ex01_Jhonatan
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
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here -> Write A to Z in ASCII and the number from 15 to 0 into the memory
;-------------------------------------------------------------------------------
			clrz					; Clear the Z registrator

			call	#letter				; creating subroutine letter
			call	#numbers			; creating subroutine numbers


			jmp		$


letter:		mov.b	#0x41, R10				; Atribute the A (0x041) to R10
			mov.w 	#0x0220, R12			; Atribute the adress byte to R12 pointer

loop:		mov.b	R10, 0(R12) 				; R12 as pointer and 0 as deslocation adress
			cmp.b	#0x05A, R10			; Comparing if not Z -> if yes: Z = 1
			jnz		incr			; Jump if Z is high
			ret					; Exit subroutine

incr:		inc.b	R10					; R10 = R10 + 1
			inc.w	R12				; R12 = R12 + 1
			jmp 	loop				; Back to loop

;-------------------------------------------------------------------------------

numbers:	mov.b	#0x015, R10				; Atribute the number 15 (0x015) to R10
		mov.w 	#0x0250, R12				; Atribute the adress byte to R12 pointer

loop1:      mov.b	R10, 0(R12) 				; R12 as pointer and 0 as deslocation
			cmp.b	#0x050, R10			; Comparing const(#) 0x050 with R10
			jnz	incr1   			; Jump to incr1 function
			ret

incr1:		dadd.b	#1, R10					; R10 = R10 + 1
			inc.w	R12           			; R12 = R12 + 1
			jmp	loop1				; Back to loop1


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
            
