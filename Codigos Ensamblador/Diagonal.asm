;Escribir un programa que dibuje una diagonal en la pantalla.

mov cx,1
mov al, 13h
 mov ah, 0
 int 10h ; set graphics video mode. 

bucle1:
 mov dx, cx 
 mov al, color ;AL = pixel color
 mov ah, 0ch ;Change color for a single pixel
 int 10h ;set pixel 

 cmp cx, 101 ;llegar hasta 100 x 100 (va en diagonal)
 jz fin 

 inc cx ;DX = row.
 add color, 2 ;para cambiar colores 
jmp bucle1 ;CX = column
fin:
ret
color db 1