read macro cadena
LEA DX,cadena
mov ah,0ah
int 21h
endm

menur macro
local et1
et1:cursor
mov ah,09h
mov bh,0h
mov cont,cx
mov cx,1h
mov bl,74h
mov al,[si]
int 10h
inc si
inc col
mov cx,cont
loop et1
endm

menua macro
local et1
et1:cursor
mov ah,09h
mov bh,0h
mov cont,cx
mov cx,1h
mov bl,71h
mov al,[si]
int 10h
inc si
inc col
mov cx,cont
loop et1
endm


cursor macro
mov ah,02
mov bh,0
mov dh,ren
mov dl,col
int 10h
endm


pila segment para stack 'stack'
     dw 64 dup(0)
pila ends

datos segment para 'data'
     cur db 0
     cantidad db 0
     col db 0
     ren db 0
     cont dw 0
     cad1 db 'F1 ','$'
     cad2 db 'Editar  ','$'
     cad3 db 'F2 ','$'
     cad4 db 'Contar  ','$'
     cad5 db 'F3 ','$'
     cad6 db 'Sustituir  ','$'
     cad7 db 'F10 ','$'
     cad8 db 'Fin                                         ','$'
     cad9 db 'Introduce una cadena (max 30 car): ','$'
     cad10 db 'Introduce sub-cadena a buscar: ','$'
     cad11 db 'Apariciones: ','$'
     cad12 db 'Introduce dos sub-cadenas de la misma longitud','$'
     cad13 db 'Sub-cadena 1: ','$'
     cad14 db 'Sub-cadena 2: ','$'
     cad15 db 'Deben ser de la MISMA longitud','$'
     cadena1 label byte
     longmax1 db 31
     longact1 db 0
     buffer1 db 31 dup('$')

     cadena2 label byte
     longmax2 db 31
     longact2 db 0
     buffer2 db 31 dup('$')

     cadena3 label byte
     longmax3 db 31
     longact3 db 0
     buffer3 db 31 dup('$')

datos ends

codigo segment para 'code'
     principal proc far
       assume cs:codigo,ds:datos,ss:pila
       push ds
       sub ax,ax
       push ax
       mov ax,datos
       mov ds,ax
       mov es,ax

       etin:call LIMPANT
       mov col,0
       mov ren,0
       cursor
       LEA SI,cad1
       mov cx,03h
       menur

       LEA SI,cad2
       mov cx,08h
       menua

       LEA SI,cad3
       mov cx,03h
       menur

       LEA SI,cad4
       mov cx,08h
       menua

       LEA SI,cad5
       mov cx,03h
       menur

       LEA SI,cad6
       mov cx,0bh
       menua

       LEA SI,cad7
       mov cx,04h
       menur

       LEA SI,cad8
       mov cx,28h
       menua

       mov ah,10h
       int 16h

       cmp ah,3Bh
       je et2
       cmp ah,3ch
       je et3
       cmp ah,3dh
       je et4
       cmp ah,44h
       je et5

       et2:call LEER1
       jmp etin
       et3:call LEER2
       jmp etin
       et4:call LEER3
       jmp etin
       et5:RET
     principal endp

     LIMPANT proc
       cursor
       mov ah,06h
       mov al,0
       mov cx,0000h
       mov dx,184fh
       mov bh,0fh
       int 10h
       RET
     LIMPANT endp

     LEER1 proc
       mov col,0
       inc ren
       cursor
       mov ah,09h
       LEA DX,cad9
       int 21h
       read cadena1
       RET
     LEER1 endp

     LEER2 proc
       mov col,0
       inc ren
       cursor
       mov ah,09h
       LEA DX,cad10
       int 21h
       read cadena2
       call contar
       mov col,0
       inc ren
       cursor
       mov ah,09h
       LEA DX,cad11
       int 21h
       add cantidad,30h
       mov ah,2
       mov dl,cantidad
       int 21h
       mov ah,1
       int 21h
       RET
     LEER2 endp

     LEER3 proc
       et12:mov col,0
       inc ren
       cursor
       mov ah,09h
       LEA DX,cad12
       int 21h
       mov col,0
       inc ren
       cursor
       mov ah,09h
       LEA DX,cad13
       int 21h
       read cadena2
       mov col,0
       inc ren
       cursor
       mov ah,09h
       LEA DX,cad14
       int 21h
       read cadena3
       mov ah,longact2
       mov al,longact3
       cmp ah,al
       jne et11
       call sustituir
       mov ah,1
       int 21h
       RET
       et11:mov col,0
       inc ren
       cursor
       mov ah,09h
       LEA DX,cad15
       int 21h
       jmp et12
     LEER3 endp

     contar proc
          mov cantidad,0
          mov dl,longact2
          dec dl
          LEA SI,buffer1
          LEA DI,buffer2
          mov cx,30
          et6:mov ah,[SI]
          mov al,[DI]
          cmp ah,al
          je et7
          et8:add SI,01
          loop et6
          RET

          et7:push si
          push di
          mov dh,00
          et9:inc dh
          cmp dh,dl
          jg et10 
          add si,01
          add di,01
          mov ah,[si]
          mov al,[di]
          cmp ah,al
          je et9
          pop di
          pop si
          jmp et8
          et10:add cantidad,01
          pop di
          pop si
          jmp et8
     contar endp

     sustituir proc
          mov dl,longact2
          dec dl
          LEA SI,buffer1
          LEA DI,buffer2
          mov cx,30
          et26:mov ah,[SI]
          mov al,[DI]
          cmp ah,al
          je et27
          et28:add SI,01
          loop et26

          inc ren
          mov col,0
          cursor
          mov ah,09h
          LEA DX,buffer1
          int 21h

          RET

          et27:push si
          push di
          push si
          push di
          mov dh,00
          et29:inc dh
          cmp dh,dl
          jg et210 
          add si,01
          add di,01
          mov ah,[si]
          mov al,[di]
          cmp ah,al
          je et29
          pop di
          pop si
          pop di
          pop si
          jmp et28
          et210:pop di
          pop si
          mov cont,cx
          inc dl
          mov cl,dl
          LEA DI,buffer3
          et211:mov ah,[di]
          mov [si],ah
          inc si
          inc di
          loop et211
          mov cx,cont
          pop di
          pop si
          dec dl
          jmp et28
     sustituir endp

codigo ends
     end principal
              
