
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
        p9 db 13,10,'Number of black lights',13,10,0,0
        p10 db ' attempts',13,10,0
        p11 db 13,10,'Sending through output',13,10,0
        p12 db 13,10, ' Ready for new Input ?',13,10,0
        inp1 db 20 dup(?),0
        inp2 db 20 dup(?),0
        fake db 20 dup(0),0
        inpchk db 20 dup(0),0
        cr equ 02403h  ; control word register address
        pa equ 02400h  ; port a address
        pb equ 02401h  ; port b address
        pc equ 02402h ; port c address
        w dw 0,0,0 ; For storing number of white lights
        bla dw 0,0,0 ; For storing number of black lights
        count db 0,0,0 ; For counting number of chances needed
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
		
		push ax		; used for unchanging the ax and dx value
		push dx
		
		MOV AL,8AH      ;Initialize A - Output B-Input Ports; A port is taken as output and B and C are taken as input
        MOV DX,CR
        OUT DX,AL        ;Write to Control Register.
		
		pop dx			;poping in reverse order
		pop ax
		
		output p1
		output p2
		output p3
		
		;inputs inp1,20		
		;lea si,inp1						; inputting the code in si
		
		push ax				; Done to make code word by first team invisible to the 2nd team
		
		mov ah,08h			; input a char without echo stored in al
		int 21h
		
		mov byte ptr[si],al
		
		mov ah,02h		; printing a charachter stored  in dl
		mov dl,"*"
		int 21h
		
		mov ah,08h			; input a char without echo stored in al
		int 21h
		
		mov byte ptr[si+1],al
		
		mov ah,02h		; printing a charachter stored  in dl
		mov dl,"*"
		int 21h
		
		mov ah,08h			; input a char without echo stored in al
		int 21h
		
		mov byte ptr[si+2],al
		
		mov ah,02h		; printing a charachter stored  in dl
		mov dl,"*"
		int 21h
		
		pop ax

cdec:

		output p12				; For checking input discontinuity
		inputs inpchk,20			
		
		mov bl,00h						; flag for a=d
		mov bh,00h						; flag for b=e
		mov ch,00h						; flag for c=f
		
		xor bp,bp						; white count=0
		xor dl,dl						; black count=0

		inc ah							; keeping count of number of attempts

		output p4		
		
		lea di,inp2						; inputting guessed number in di

		mov count,ah

		;push dx 		// add when in condition there
		;push ax
		
while:
		
	;	mov dx,pb
    ;   in al,dx
    
    
		
	push ax						; Not needed original one
		
		inputs fake,20			;Not needed original one
		atoi fake				;Not needed original one
		
		cmp al,132
		je wend1
		
		cmp al,136
		je wend2
		
		cmp al,144
		je wend3
		
		cmp al,80
		je wend4
		
		cmp al,72
		je wend5
		
		cmp al,68
		je wend6
		
		cmp al,36
		je wend7
		
		cmp al,40
		je wend8
		
		cmp al,48
		je wend9
	
	pop ax			;Not needed original one
	
	;pop ax				; Needed when in is there
	;pop dx				; Needed when in is there
	
		jmp while
		
wend1:
		mov byte ptr[di],'0'
		mov byte ptr[di+1],'2'
		
		jmp inend

wend2:
		mov byte ptr[di],'0'
		mov byte ptr[di+1],'1'
		
		jmp inend
		
wend3:
		mov byte ptr[di],'0'
		mov byte ptr[di+1],'0'
		
		jmp inend

wend4:
		mov byte ptr[di],'1'
		mov byte ptr[di+1],'0'
		
		jmp inend
		
wend5:
		mov byte ptr[di],'1'
		mov byte ptr[di+1],'1'
		
		jmp inend
	
wend6:
		mov byte ptr[di],'1'
		mov byte ptr[di+1],'2'
		
		jmp inend	
		
wend7:
		mov byte ptr[di],'2'
		mov byte ptr[di+1],'2'
		
		jmp inend

wend8:
		mov byte ptr[di],'2'
		mov byte ptr[di+1],'1'
		
		jmp inend
		
wend9:
		mov byte ptr[di],'2'
		mov byte ptr[di+1],'0'
		
		jmp inend
		
inend:			; midieval input end

	; push dx		; Needed when in is there
	; push ax		; Needed when in is there
	; mov dx,pc		; Needed when in is there
    ; in al,dx		; Needed when in is there
    
    push ax				; Not needed originally
    
		        
		inputs fake,20
		atoi fake
		
		cmp al,32
        je cend1
        
        cmp al,64
        je cend2
        
        cmp al,128
        je cend3
    
    pop ax			; Not needed originally
        
    ; pop ax		; Needed when in is there
	; pop dx		; Needed when in is there
        
        jmp inend
        
cend1:

		mov byte ptr[di+2],'2'
		jmp inendf		; final input end
        
cend2:
		
		mov byte ptr[di+2],'1'
		jmp inendf
		
cend3:

		mov byte ptr[di+2],'0'
		jmp inendf
		
inendf:
		

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

		jmp exit
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

		cmp bp,0003h				; if bp i.e number of white lights glown is 3 then we win and game ends
		je finexit1
				
		output p8				; outputting number of white lights
		
	push dx
		
		mov dx,bp
		
		add dl,48				; Adding 48 for ascii conversion
						
		mov w,dx
		
		output w
	
	pop dx
		
	push dx
	
		output  p9
	
		xor dh,dh
		
		add dl,48			; Adding 48 for ascii conversion
	
		mov bla,dx			; outputting number of black lights
		
		output bla
	
	pop dx
	
		jmp finexit2
		
finexit1:

		jmp finexit3

finexit2:


	push cx
	
	push bp
	
	push dx
	
		mov cl,04				; left shifting bp by 4 digits to add dl Doing this as for output through one port only

		cmp bp,02
		jne t1
		
		mov bp,03
		
		jmp t2
		
t1:

		cmp bp,03
		jne t2
		
		mov bp,07
	
t2:
	
		sal bp,cl			; shifting  bp value
		
		cmp dl,02
		jne t3
		
		mov dl,03
		jmp t4
		
t3:
		
		cmp dl,03
		jne t4
		
		mov dl,07
		
t4:
	
		xor dh,dh
		add bp,dx

	push ax
	
	push dx
	
		mov ax,bp
		xor ah,ah
		
		mov dx,pa			
		out dx,al				; outputting value through port a
		
		output p11
		
		xor ah,ah
		itoa fake,ax
		output fake
	
	pop dx
	
	pop ax
	
	pop dx
	
	pop bp
	
	pop cx
		
		jmp finexit4
		
finexit3:

		jmp finexit

finexit4:


		mov ah,count
		
		cmp ah,05h				; comparing number of chances left
		je finexit
		
		jmp cdec 				; go to beginning and repeat if chances left
		
finexit:

		cmp bp,03h				; if bp=03 then print win
		jne f1					; if not then we will send to f1 that is you lose
		
		output p6
		
		mov ah,count
		add ah,48				; Adding 48 for ascii conversion
		mov count,ah
		
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

