
.MODEL SMALL
.STACK
.DATA
        Cadena  DB      20,0,20 DUP ('$') ; Bufer que almacena la cadena original.
                 
        Error   DB      7H,7H,7H,0DH,0AH,'Error 1: La Cadena no pude ser NULA'
                DB      0DH,0AH,0DH,0AH,'$'
        Salir   DB      'EXIT'
        MenCap  DB      0AH,0DH,0AH,0DH,'Cadena a encriptada(Cesar). M ximo 20 caracteres : ','$'
        MenCryp DB      0AH,0DH,0AH,0DH,'Cadena encriptada: ','$'
        MenDCr  DB      0AH,0DH,0AH,0DH,'Cadena desencriptada: ','$'
        

.CODE
Comienzo:
        MOV     AH,0FH             ;Obtiene la modalidad de video actual.
        INT     10H
        MOV     AH,0               ;Cambia a la modalidad de video obtenida.
        INT     10H                ;Cambi la!
        MOV     AX,@DATA           ;Inicializaci¢n del segmento de datos, por regla
                                   ;un segmento de datos debe ser inicializado por
                                   ;un movimiento a trav‚s de un registro de prop¢sito
                                   ;general o atrav‚s de la PILA.
        MOV     DS,AX              ;Es ac  donde se incializa.
        PUSH    DS                 ;Guardo DS.
        POP     ES                 ;DS=ES, ES se necesita por la naturaleza de las
                                   ;Operaciones que van a ser utilizadas.
        
                
Captura:
        LEA     DX,MenCap          ;Preparaci¢n para mostrar MenCap en
                                   ;pantalla.
        MOV     AH,9H              ;El mismo proceso anterior con la
                                   ;funcion 9H de la Int 21H
        INT     21H                ;Mu‚stralo!.
        MOV     AH,0AH             ;Funcion de la Int 21 para capturar
                                   ;una cadena.
        MOV     DX, OFFSET Cadena  ;DX debe poseer la direcci¢n del bufer.
        PUSH    DX                 ;Por seguridad.
        INT     21H                ;Se captura.
        POP     DX                 ;Recupero.
        INC     DX                 ;Obtiene los bytes realmente
                                   ;le¡dos en el bufer.
        MOV     SI,DX              ;SI con Cadena+1.
        CMP     BYTE PTR [SI],0    ;Es 0 (nula)?
        JNZ     Capt02             ;No, entonces salta a Capt02.
        LEA     DX, Error          ;Si?, se prepara para mostrar error.
        MOV     AH,9H
        INT     21H     
        MOV     AH,0H
        INT     16H
        JMP     Comienzo           ;Vuelve y se captura la cadena.
Capt02:
        INC     DX                 ;Obtengo el primer byte para ver si no
                                   ;se digit¢ EXIT.
        MOV     CX,4               ;Voy a revisar 4 Bytes (EXIT).
        MOV     SI,DX              ;Tengo la cadena
        MOV     DI, OFFSET Salir   ;Voy a comparar.
        REPE    CMPSB              ;Se digit¢ EXIT?.
        JCXZ    Fuera              ;Si es cierto sale del programa.
        MOV     SI, OFFSET Cadena+1;Obtengo la cantidad de Bytes realmente le¡dos
        LEA     BX, Cadena+1       ;Cargo BX igual que con la anterior
                                   ;instrucci¢n.
        MOV     CL, BYTE PTR [SI]  ;CX con la cantidad de caracteres.
Crypt:
        INC     BX                 ;Primer caracter de la cadena     
        MOV     AH,[BX]            ;Lo llevo a AH para su encriptaci¢n
        ADD     AH,5H              ;Lo encripto.     
        MOV     [BX],AH            ;Lo restauro en el bufer.     
        LOOP    Crypt              ;Itero hasta CX=0
        LEA     DX,MenCryp
        MOV     AH,9H
        INT     21H
        MOV     DX, OFFSET Cadena+2;Me preparo para mostrar la cadena encriptada
                                   ;me posiciono en el primer caracter de la
                                   ;cadena                                           
        MOV     AH,9H                   
        INT     21H                ;Muestro la cadena encriptada

        MOV     SI, OFFSET Cadena+1;Me preparo para desencriptarla
        LEA     BX, Cadena+1       ;Lo mismo anterior
        MOV     CL, BYTE PTR [SI]  ;CX con el numero de caracteres
DeCrypt:
        INC     BX                 ;Obtengo primer caracter
        MOV     AH,[BX]
        SUB     AH,5H            ;Lo desencripto     
        MOV     [BX],AH            ;Se restaura el original en el bufer
        LOOP    DeCrypt            ;Repito hasta que CX=0
        MOV     DX, OFFSET MenDCr
        MOV     AH,9H
        INT     21H
        MOV     DX, OFFSET Cadena+2;Primer caracter de la cadena
                                   ;desencriptada.
        MOV     AH,9H
        INT     21H                ;Muestro la cadena desencriptada

Fuera:
        MOV     AX,4C00H           ;Funci¢n para retornar al DOS     
        INT     21H                ;Retorno!.           
END     Comienzo                   ;y se acab¢.
