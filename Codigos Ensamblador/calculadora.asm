name "Calculadora Asemmbly by (Zerorendan)"
org 100h ; inicio de programa
include 'emu8086.inc' ;Incluye funciones de libreria emu8086
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
jmp inicio

inicio:

mov ah,00h;---------------->limpiar pantalla
mov al,03h
int 10h

mov ax, @data
mov ds,ax

mov dx, offset esp;-------->espacios para los mensajes
mov ah,09;----------------->impresion en pantalla
int 21h

mov dx, offset mensaje1;--->titulo del programa
mov ah,09
int 21h

mov dx, offset user;------->creadores del programa
mov ah,09
int 21h

mov dx, offset menu;------->menu principal
mov ah,09
int 21h

;=====================================<comparacion para saltar
mov ah,01h
int 21h

cmp al,'0'
je fin

cmp al,'1'
je suma

cmp al,'2'
je resta

cmp al,'3'
je multi

cmp al,'4'
je divi

cmp al,'5'
je ayuda
         
cmp al,'6'
je servo         
;=====================================<bloques de operaciones

suma:

mov dx, offset mensaje2;---> mensaje para pedir el primer numero
mov ah,09h
int 21h
;-------------------------->rellenado de variables
call SCAN_NUM;------------->llama a la funcion scan_num q toma el numero del teclado y lo guarda en ax
mov valor1,cx;------------->carga el numero a la variable
;-------------------------->muestra el mensaje user para sentirme grande
mov dx, offset mensaje3;---> mensaje para pedir el segundo numero
mov ah,09h
int 21h
;-------------------------->rellenado de variables
call SCAN_NUM;------------->llama a la funcion scan_num q toma el numero del teclado y lo guarda en ax
mov valor2,cx;------------->carga el numero a la variable

mov dx, offset texto_suma;->muestra el resultado
mov ah,09h
int 21h;------------------->interrupcion pantalla
;-------------------------->suma de las variables
mov ax,valor1;------------->mueve el valor de la variable a ax
add ax,valor2;------------->suma entre la region ax y la variable
call PRINT_NUM;------------> imprimiendo en pantalla el resultado

mov ah,00;----------------->espera por una tecla en pantalla
int 16h

mov ah,00h;---------------->limpia la pantalla
mov al,03h
int 10h

mov dx,offset beta;-------->muestra el mensaje de salida
mov ah,09
int 21h

jmp inicio
;fin del bloque de suma

resta:
mov dx, offset mensaje2
mov ah,09h
int 21h
;-------------------------->rellenado de variables
call SCAN_NUM;------------->llama a la funcion scan_num qtoma el numero del teclado y lo guarda en ax
mov valor1,cx;------------->carga el numero a la variable
;-------------------------->muestra el mensaje user para sentirme grande
mov dx, offset mensaje3
mov ah,09h
int 21h
;-------------------------->rellenado de variables
call SCAN_NUM
mov valor2,cx

mov dx, offset texto_resta
mov ah,09h
int 21h
;-------------------------->resta de variables
mov ax,valor1
sub ax,valor2
call PRINT_NUM
    
mov ah,00
int 16h

mov ah,00h;---------------->limpia la pantalla
mov al,03h
int 10h

mov dx,offset beta
mov ah,09
int 21h
jmp inicio

multi:
mov dx, offset mensaje2
mov ah,09h
int 21h
;-------------------------->rellenado de variables
call SCAN_NUM;------------->llama a la funcion scan_num qtoma el numero del teclado y lo guarda en ax
mov valor1,cx;------------->carga el numero a la variable
;-------------------------->muestra el mensaje user para sentirme grande
mov dx, offset mensaje3
mov ah,09h
int 21h
;-------------------------->rellenado de variables
call SCAN_NUM
mov valor2,cx

mov dx, offset texto_multi
mov ah,09h
int 21h
;-------------------------->multiplicacion en si misma
mov ax,valor1;------------->mueve la primeria variable al ax
mov bx,valor2;------------->mueve el siguiente valor al bx porque la multi solo permite un valor
mul bx;-------------------->ax=ax*bx
call PRINT_NUM

mov ah,00
int 16h

mov ah,00h;---------------->limpia la pantalla
mov al,03h
int 10h

mov dx,offset beta;-------->mensaje de salir
mov ah,09
int 21h


jmp inicio

divi:
mov dx, offset mensaje2
mov ah,09h
int 21h
;-------------------------->rellenado de variables
call SCAN_NUM;------------->llama a la funcion scan_num qtoma el numero del teclado y lo guarda en ax
mov valor1,cx;------------->carga el numero a la variable
;-------------------------->muestra el mensaje user para sentirme grande
mov dx, offset mensaje3
mov ah,09h
int 21h
;-------------------------->rellenado de variables
call SCAN_NUM
mov valor2,cx

mov dx, offset texto_divi
mov ah,09h
int 21h
;-------------------------->la divicion en si misma
xor dx,dx;----------------->deja en cero dx para que no se desborde la division
mov ax,valor1;------------->mueve la primeria variable al ax
mov bx,valor2;------------->mueve el siguiente valor al bx porque la divi solo permite un valor
div bx;-------------------->ax=ax/bx
call PRINT_NUM

mov ah,00
int 16h

mov ah,00h;---------------->limpia la pantalla
mov al,03h
int 10h

mov dx,offset beta
mov ah,09
int 21h

jmp inicio

;-------------------------->comienza el bloque de ayuda
ayuda:
mov dx, offset texto_ayuda
mov ah,09h
int 21h
       
mov dx, offset esp
mov ah,09
int 21h
       
mov dx, offset texto_ayudaS
mov ah,09h
int 21h

mov dx, offset esp
mov ah,09
int 21h

mov dx, offset texto_ayudaR
mov ah,09h
int 21h

mov dx, offset texto_ayudaR2
mov ah,09h
int 21h
       
mov dx, offset esp
mov ah,09
int 21h       
       
mov dx, offset texto_ayudaM
mov ah,09h
int 21h
      
mov dx, offset esp
mov ah,09
int 21h      
      
mov dx, offset texto_ayudaD
mov ah,09h
int 21h

mov dx, offset texto_ayudaD2
mov ah,09h
int 21h

mov ah,00
int 16h

mov ah,00h
mov al,03h
int 10h

jmp inicio:
;--------------------->fin del sistema de ayuda

;====================================<Servo motor
servo:
mov dx, offset menu2;------->menu principal
mov ah,09
int 21h

;=====================================<comparacion para saltar
mov ah,01h
int 21h

cmp al,'0'
je salida

cmp al,'1'
je level1

cmp al,'2'
je level2

cmp al,'3'
je level3

cmp al,'4'
je level4


salida:

jmp inicio:



;=============================================================================>
level1:
jmp inicio1:

; dimensiones del rectángulo
; ancho: 10 pixeles
; alto: 5 pixeles

; dimenciones del Cuadrado
; lados : 10 pixeles
w equ 10
h equ 5


; se trabajara en modo en video 13h - 320x200

inicio1:
mov ah, 0
mov al, 13h
int 10h
mov ah,0ch ;ah en 0ch para que ponga los pixeles en la pantalla


; dijuja la linea superior:

mov cx, 100+w ; columna
mov dx, 20 ; fila
mov al, 003 ; color de la figura
rectup:
int 10h

dec cx
cmp cx, 100
jae rectup

; dibija linea inferior

mov cx, 100+w ; columna
mov dx, 20+h ; fila

rectdo:
int 10h

dec cx
cmp cx, 100
ja rectdo

; dibuja lado izquierdo:

mov cx, 100 ; columna
mov dx, 20+h ; fila

rectle:
int 10h

dec dx
cmp dx, 20
ja rectle


; dibuja lado derecho

mov cx, 100+w ; columna
mov dx, 20+h ; fila

rectra:
int 10h

dec dx
cmp dx, 20
ja rectra       
        
               
jmp servo:

;=========================================================>
level2:
jmp inicio2:

; dimensiones del rectángulo
; ancho: 10 pixeles
; alto: 5 pixeles

; dimenciones del Cuadrado
; lados : 10 pixeles
w equ 50
h equ 40


; se trabajara en modo en video 13h - 320x200

inicio2:
mov ah, 0
mov al, 13h
int 10h
mov ah,0ch ;ah en 0ch para que ponga los pixeles en la pantalla


; dijuja la linea superior:

mov cx, 100+w ; columna
mov dx, 20 ; fila
mov al, 003 ; color de la figura
rectup2:
int 10h

dec cx
cmp cx, 100
jae rectup2

; dibija linea inferior

mov cx, 100+w ; columna
mov dx, 20+h ; fila

rectdo2:
int 10h

dec cx
cmp cx, 100
ja rectdo2

; dibuja lado izquierdo:

mov cx, 100 ; columna
mov dx, 20+h ; fila

rectle2:
int 10h

dec dx
cmp dx, 20
ja rectle2


; dibuja lado derecho

mov cx, 100+w ; columna
mov dx, 20+h ; fila

rectra2:
int 10h

dec dx
cmp dx, 20
ja rectra2
        
     
jmp servo:

;======>
level3:
jmp servo:

;======>
level4:
jmp servo:






















jmp servo:


fin:;---------------------->fin del programa
mov dx, offset beta
mov ah,09
int 21h

mov ah,00h
mov al,03h
int 10h

mov ah,00;----pausa para salir
int 16h  

ret
;------------------------>
mensaje1 db 13,10,' Ud esta utilazando la calculadora desarrollada en emsamblador$'
user db 13,10,' By juan calvo & glender vallejos$'
mensaje2 db 13,10,' Digite el primer numero $'
mensaje3 db 13,10,' Digite el segundo numero $'
menu db 13,10,' Digite 0->salir 1->suma 2->resta 3-multiplicacion 4->division 5->Ayuda 6->Servo Motor $'
menu2 db 13,10,' Digite 0->regresar  1->+-1 2->+-2 3-+-3 4->+-4 $'
beta db 13,10,' Saliendo $'
;------------------------>variables
valor1 dw ?
valor2 dw ? 
;------------------------>textos de resultados
texto_suma db 13,10,'la suma de los valores es $'
texto_resta db 13,10,'la resta de los valores es $'
texto_multi db 13,10,'la multiplicacion de los valores es $'
texto_divi db 13,10,'la division de los valores es $'  
esp db ' ',10,13,'$'
;------------------------>textos de ayuda
texto_ayuda db 13,10,'Bienvenido al sistema de ayuda de la calculadora Assembly$'
texto_ayudaS db 13,10,'En la suma los valores se suman de esta manera :'
db 13,10, '1(primer valor)+2(segundo valor)=3 $'
texto_ayudaR db 13,10,'En la resta los valores se restan de esta manera :' 
db 13,10,'1(primer valor)-2(segundo valor)= -1 $'
texto_ayudaR2 db 13,10,'Si se quieren valores positivos se restarian en este orden 2-1=1 $'
texto_ayudaM db 13,10,'En la multiplicacion los valores se multiplican de esta manera:'
db 10,13,'5(primer valor)*3(segundo valor)=15 $'
texto_ayudaD db 13,10,'En la division los valores se dividen de esta manera :'
db 10,13,'15(primer valor)/3(segundo valor)=5  $'
texto_ayudaD2 db 13,10,'El sistema de division no hace divisiones no enteras por ejemplo 2/3=0 $'