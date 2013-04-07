
;TITLE : Beta2Alpha game code : A variation of popular mastermind (Bulls and cows) game

include io.h 		; Including file header io.h

;BEGINING OF DATA SEGMENT DECLARATION 

data segment
        p1 db 13, 10, 'Program of mastermind game',13, 10, 0
        p2 db 13, 10, '----------------------------------',13,10,0
        p3 db 13,10,'Enter the first number :',13,10,0
        p4 db 13,10,'Enter the guessed number :',13,10,0
        p5 db 13,10,'Enter next digit : ',13,10,0
        p6 db 13,10,'YOU WON in ',0
        p7 db 13,10,'YOU LOST',13,10,0
        p8 db 13,10,'Number of white lights',13,10,0
        p9 db 13,10,'Number of black lights',13,10,0
        p10 db ' attempts',13,10,0
        inp1 db 20 dup(?),0
        inp2 db 20 dup(?),0
        w dw 0,0,0 ; For storing number of white lights
        bla dw 0,0,0 ; For storing number of black lights
        count dw 0,0 ; For counting number of chances needed
data ends

;END OF DATA SEGMENT, 13, 10 INDICATES NEW LINE CHARACTER


;BEGINING OF CODE SEGMENT

code segment

	assume cs:code,ds:data,es:data
	
	start:
	
		mov ax,seg data						; Loading data and extra segment
		mov ds,ax
		mov es,ax

; Initializing registers value
		
		mov si,00h						; initializing si
		mov di,00h						; initializing di
		mov bp,00h						; white light count
		mov dl,00h						; black light count
		mov bl,00h						; flag for a=d
		mov bh,00h						; flag for b=e
		mov ch,00h						; flag for c=f
		mov ah,00h						; counting number of chances
		xor al,al						;initializing ax to 00
		
		output p1
		output p2
		output p3
		
		inputs inp1,20		
		lea si,inp1						; inputting the code in si

cdec:

		mov bp,00h						; white count=0
		mov dl,00h						; black count=0

		inc ah							; keeping count of number of attempts

		output p4		

		inputs inp2,20				
		lea di,inp2						; inputting guessed number in di
		
		mov al,[si]						; we have used it because there can be no direct memory comparison
		cmp al,[di]	; a=d
		
		jne nx1							; if a!=d jump to nx1
		inc bp							; if a==d inc bp
		mov bl,01h						; making flag = 1
		
nx1:
		mov al,[si+1]				
		cmp al,[di+1]	; b=e
		
		jne nx2							; jump to nx2 iff b!=d
		inc bp
		mov bh,01h
		
nx2:
		mov al,[si+2]
		cmp al,[di+2]	  ; c=f
		
		jne nx3					; jump to nx3 only if c!=f
		inc bp
		mov ch,01h
	
nx3: 
		
		cmp bl,01h					; if flag bl is 1 i.e a==d
		jne nx4						; if bl=0 then jump nx4
		cmp bh,01h					; if flag bh is  1  i.e b==e
	
		je exit1					; jump to exit1 because it cannot jump beyond 128 bytes it is covering cases like : 120 and 121

		cmp ch,01h					; comparing flag ch to 1 i.e c==f
		je exit1					

		mov al,[si+1]				; b and f comparison 

		cmp al,[di+2]
		jne par1					; not equal then jump to par1 for case like 102 and 110
		inc dl						;  if equal then increment number of black lights i.e dl
		
par1:

		mov al,[si+2]
		cmp al,[di+1]				; c and e compare
		jne exit1					; it is covering 120 and 112
		inc dl						; increment black light count
		jmp exit					; covering 120 and 102

nx4:

		cmp bh,01h					; similar to previous one
		jne nx5
		cmp ch,01h
		je exit1
		mov al,[si]
		cmp al,[di+2]
		jne par2
		inc dl

par2:

		mov al,[di]
		cmp al,[si+2]
		jne exit
		inc dl
		jmp exit
		
exit1:  

		jmp exit				; this label is made because otherwise it cannot jump beyond some limit

nx5:

		cmp ch,01h 				; similar to previous one
		jne nx6
		mov al,[si]
		cmp al,[di+1]
		jne par3
		inc dl

par3:

		mov al,[si+1]
		cmp al,[di]
		jne exit
		inc dl

; the below cases are needed if and only if no white light glows


nx6:

		mov al,[si]					; comparing a and e
		cmp al,[di+1]
		jne nx7						
		inc dl
		jmp nx8

nx7:

		mov al,[si]					; comparing a and f
		cmp al,[di+2]
		jne nx8
		inc dl

nx8:

		mov al,[si+1]				; comparing b and d
		cmp al,[di]
		jne nx9
		inc dl
		jmp nx10

nx9:

		mov al,[si+1]			; comparing b with f
		cmp al,[di+2]
		jne nx10
		inc dl
		
nx10:

		mov al,[si+2]				; comparing c with d
		cmp al,[di]
		jne nx11
		inc dl
		jmp dual

nx11:

		mov al,[si+2]			; comparing c with e
		cmp al,[di+1]
		jne dual
		inc dl
		
; dual is used if number in the code repeats eg in 110 , 1 is repeating and decrementing 
; black light count because in that case we count more than once number of black lights

dual:

		mov al,[si] 			; comparing a and b
		cmp al,[si+1]
		jne dual1
		dec dl
		jmp exit
		
dual1:
		mov al,[si]				; comparing a and c

		cmp al,[si+2]
		jne exit
		dec dl
		jmp exit
		
exit:

		cmp dl,00h				; if dl i.e number of black lights become less than 0 then make it 0			
		jg exit2
		mov dl,00h
		
exit2:

		cmp bp,03h				; if bp i.e number of white lights glown is 3 then we win and game ends
		je finexit
		
		output p8				; outputting number of white lights
		itoa w,bp
		output w
		
		mov dh,00h
		
		itoa bla,dx				; outputting number of black lights
		output p9
		output bla
		
		cmp ah,05h				; comparing number of chances left
		je finexit
		jmp cdec 				; go to beginning and repeat if chances left
		
finexit:

		cmp bp,03h				; if bp=03 then print win
		jne f1					; if not then we will send to f1 that is you lose
		output p6
		
		mov al,ah
		mov ah,00h
		
		itoa count,ax
		output count
		
		output p10
		
		jmp f2
		
f1:		
		output p7				; printing you lose
f2:
		mov ax,4c00h		; Ending code going back to terminal interrupt
		int 21h

code ends 
end start
