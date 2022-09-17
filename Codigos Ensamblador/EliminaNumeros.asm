;Escribir una programa que reciba una cadena ingresada por teclado, terminada en ENTER. 
;Luego que elimine todos los caracteres que no son dígitos, sin utilizar una variable auxiliar.

ORG 100H
mov si, 0
lectura:
 mov ah,1
 int 21h

 cmp al,13 
 jz resultado: 

 cmp al, 57 ;si tecla es mayor a 57 entonces ir a fin3 (tecla > 57) 
 ja fin3
cmp al,47 ;si tecla no es mayor a 47 ir a fin3 (tecla <= 47)
 jng fin3
mov bx[si], al ;si es un digito entonces guardo en bx

 inc si ;incrementa si

 fin3: 

jmp lectura 

resultado:
 mov ah,00h ;limpia la pantalla
 mov al,03h
 int 10h
mov bx[si], "$" 
mov dx, offset bx
mov ah, 9 ;preparar ah con 9 para la interrupcion 21h
int 21h ;mostrar contenido en dx
ret