;Escribir un programa en ensamblador que muestre un mensaje por pantalla accediendo a la memoria de video (0B800h):

;------------------------------------------------------------------------------
;Definicion del segmento de datos
;------------------------------------------------------------------------------
DATOS SEGMENT
     saludo db "Hola"
DATOS ENDS

;------------------------------------------------------------------------------
;Definicion del segmento de pila
;------------------------------------------------------------------------------
PILA SEGMENT STACK "STACK"
     DB 40 DUP(0)
PILA ENDS

;------------------------------------------------------------------------------
;Definicion del segmento extra
;------------------------------------------------------------------------------
EXTRA SEGMENT
     RESULT DW 0,0
EXTRA ENDS

;------------------------------------------------------------------------------
;Definicion del segmento de codigo
;------------------------------------------------------------------------------
CODE SEGMENT
     assume cs:code,ds:datos,es:extra,ss:pila

START PROC
     ;Inicializamos los registros de segmento
     mov ax,datos
     mov ds,ax
     mov ax,pila
     mov ss,ax
     mov ax,extra
     mov es,ax
     ;Fin de las inicializaciones

     ;Limpiamos la pantalla
     mov  ax,0B800h      ;En esta direccion comienza la memoria de video
     mov  es,ax          ;Lo cargamos en el segmento extra
     xor  di,di          ;Ponemos DI=0. Esto equivale a mov di,0, pero
                         ;xor di,di consume 3 ciclos de reloj y con mov 4
     mov  cx,80*25       ;El tamaño total es 2000 (80 lineas x 25 columnas)

b_clear:                 ;Bucle que se encargara de recorrer los 2000
                         ;caracteres de la pantalla para limpiarla
     mov  al,20h         ;20h=" "   Rellenar la pantalla con espacios
     mov  ah,1Eh        ;Fondo azul, letras blancas
     mov  es:[di],ax
     inc  di
     inc  di
     loop b_clear

     mov  ax,0B800h
     mov  es,ax
     mov  si,offset saludo
     mov  di,(80*10+29)*2  ;Linea 7, caracter 18
     mov  cx,13

b_saludo:                ;Bucle que se encargara de recorrer los 2000
                         ;caracteres de la pantalla para limpiarla
     mov  al,[si]
     mov  ah,1eh         ;Fondo azul, letras blancas
     mov  es:[di],ax
     inc  si             ;Pasamos a apuntar a la siguiente letra del saludo
     inc  di
     inc  di
     loop b_saludo


     mov  ax,4C00h       ;
     int  21h            ;Terminar el programa

START ENDP

CODE ENDS
     END START


