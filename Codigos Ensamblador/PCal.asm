
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




;=====================================<comparacion para saltar
mov ah,01h
int 21h

cmp al,'0'
je salida




salida:

jmp inicio:





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
mensaje1 db 13,10,' Menu principal $'
user db 13,10,'  Cristian Reyes Cuamatzi$'
mensaje2 db 13,10,' Digite el primer numero $'
mensaje3 db 13,10,' Digite el segundo numero $'
menu db 13,10,' Opc 0->salir 1->suma 2->resta 3-multiplicacion 4->division $'
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
