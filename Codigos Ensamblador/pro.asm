segment datos
	menu db 'Menu$'
	opc1 db '1) Contar numeros de caracteres$'
	opc2 db '2) Busca y cuenta una letra$'
	opc3 db '3) Reemplaza caracter$'
	opc4 db '4) Multiplicacion$'
	opc5 db '5) Division$'
	opc6 db '6) Potencia$'
	opc7 db '7) Salir$'
	cad db 'prueba$' ;10
	rem db 'reemplazable$'
	bus db ' letra a buscar$'
	cr db ' caracter a reemplazar$'
	pc db ' por cual?$'
	ap db ' esa letra aparece$'
	ve db ' veces$'
	ca db ' caracteres$'
	da db ' deme los numeros$'
	divi db ' deme el dividendo y el divisor$'
	re db ' es el resultado$'   ;20
	ce db ' deme la base diferente de cero$'
	po db ' dame el exponente$'
	
segment pila stack
         resb 256
iniciopila:     
	segment codigo
..start:
	mov ax,pila
	mov ss,ax  ;30
	mov sp,iniciopila

	mov ax,datos
	mov ds,ax

xx:	call menu1
	call lectura   
	cmp al,31h
	jz longi
	cmp al,32h
	jz contar    ;65
	cmp al,33h
	jz reem
	cmp al,34h
	jz multi
	cmp al,35h   ;70
	jz division
	cmp al,36h
	jz pote
	cmp al,37h
	jz salir

menu1:	mov dx,menu	
	call write
	call newline
	mov dx,opc1
	call write    ;40
	call newline
	mov dx,opc2   
	call write
	call newline
	mov dx,opc3
	call write
	call newline
	mov dx,opc4
	call write
	call newline  ;50
	mov dx,opc5
	call write     
	call newline
	mov dx,opc6
	call write
	call newline
	mov dx,opc7
	call write
	call newline
	ret
	;----escribe en pantalla
write:
	  mov ah,09 ;dx <--string
	  int 21h    ;80
	  ret
;------lectura
lectura:    
	mov ah,01h
	int 21h
	ret

;-----escritura
escritura:
	mov ah,02
	int 21h  ;90
	ret
;-----emaquetamiento
empa:   ;80
	call lectura
	cmp al,39h
	jle et1
	sub al,57h
	jmp et2
et1:           sub al,30h
et2:           mov cl,4   ;100
	shl al,cl
	mov ch,al
	call lectura   
	cmp al,39h
	jle et3
	sub al,57h
	jmp et4
et3:            sub al,30h
et4:            mov cl,4
	or al,ch    ;110
	ret
;---desempaquetamiento
dese:     
	mov bx,ax
	mov dl,bh
	mov cl,04
	shr dl,cl
	cmp dl,09	
	jle et5
	add dl,37h   ;120
	jmp et6
et5:            add dl,30h
et6:            call escritura   
	mov dl,bh
	and dl,0fh
	cmp dl,09
	jle et7
	add dl,37h
	jmp et8	
et7:           add dl,30h   ;130
et8:          call escritura
	ret
	
;---longitud
longi:
	mov bl,00
	mov dx,cad
	call write
	mov dl,00
	mov si,cad    ;140
et9:	mov al,[si]
	cmp al,24h
	jz et10
	inc bl
	inc si
	jmp et9
et10:          mov dl,bl
	add dl,30h
	call escritura
	call newline   ;150
	mov dx,ca
	call write
	call newline
	jmp xx

;-----contar caracter
contar:
	mov bh,01h
	mov [500],bh
	mov dx,rem
	call write
	call newline
	mov dx,bus    ;160
	call write  
	call newline
	call lectura
	mov bl,al
	mov si,rem
et14:	mov al,[si]
	cmp al,24h
	je et11
	cmp bl,[si]
	je et12
	jmp et13   ;170
et12:         add [500],bh
et13:         inc si
	jmp et14
et11:         mov dx,ap
	call write
	sub [500],bh
	mov dl,[500]
	add dl,30h
	call escritura
	mov dx,ve
	call write   ;180
	jmp xx
	
;----reemplazar caracter
reem:
	mov dx,rem
	call write
	mov dx,cr
	call write
	call lectura   ;190
	mov bl,al
	mov dx,pc
	call write
	call lectura
	mov si,rem
	mov di,si
	add di,12
et17:	cmp si,di
	je et15
	cmp bl,[si]
	je et16
et18	inc si     ;200
	jmp et17
et16:	mov [si],al
	jmp et18
et15:	mov dx,rem
	call write
	jmp xx
;---multiplicacion------
multi:
	mov dx,da
	call write   
	call empa   ;200
	mov bh,al
	call empa	
	mov bl,al
	call empa
	mov dh,al
	call empa
	mov dl,al
	mov ax,bx
	mov bx,dx
	mul bx    ;218
	call dese   ;210
	mov ah,bl
	call dese
	mov dx,re
	call write
	jmp xx
;-----division
division:
	mov dx,divi
	call write    ;230
	call empa
	mov bh,al	
	call empa
	mov bl,al
	call empa
	mov [500],al
	call empa
	mov [501],al
	mov ax,bx
	mov bh,[500]   ;240
	mov bl,[501]
	mov dx,0
	div bx
	call dese
p	mov ah,bl
	call dese
	mov dx,re
	call write
	jmp xx	

;-----potencia
pote:
	mov dx,ce
	call write
	call empa
	mov bh,al
	call empa
	mov bl,al
	mov dx,po
	call write
	call empa
	mov dh,al
	call empa
	mov dl,al
	mov ax,bx
	mov cx,1
	mov [400],cx
	xchg cx,dx
	cmp cx,0
	je et19
et21:	cmp [400],cx
	jge et20
	mul bx
	mov dx,1
	add [400],dx
	jmp et21
et20:	call dese
	mov ah,bl
	call dese	
	jmp et22
et19:	mov ax,1
	call dese
	mov ah,bl
	call dese
et22:	jmp xx

; --------salir
salir:
	mov ah,4ch
	int 21h

;----------- retorno de linea
newline:
	mov dl,0ah  ;alimentacion de linea
	mov ah,02
	int 21h
	mov dl,0dh   ;retorno de carro
	MOV AH,02
	INT 21H
	ret