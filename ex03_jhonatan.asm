;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
; ex03_Jhonatan
; pastro@eletrica.ufpr.br
;
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
; Main loop here
;-------------------------------------------------------------------------------
			mov.b	#BIT6+BIT0,	&P1DIR		; I/O
			clr.b	&P1SEL					; clearing the select pins
			clr.b	&P1SEL2
            mov.b	#BIT3,		&P1REN      ; Pull-up bit 3
			bis.b	#BIT3,		&P1OUT

            bic.b	#BIT6,		&P1OUT		; Clear bit 0 -> RedLED down
            bis.b	#BIT0,		&P1OUT		; Set bit 6 -> GreenLED up

compare:	bit.b	#BIT3,		&P1IN
			jnz		npress
			jz 		press

npress:		bic.b	#BIT6,		&P1OUT		; Clear bit 6 -> RedLED down
            bis.b	#BIT0,		&P1OUT		; Set bit 0 -> GreenLED up
			jmp compare


press:		bic.b	#BIT0,		&P1OUT		; Clear bit 0 -> RedLED up
			bis.b	#BIT6,		&P1OUT		; Set bit 6 -> GreenLED down
			jmp compare

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
            
