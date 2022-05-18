/**
 * Referencias importantes:
 * https://developer.arm.com/documentation/dui0552/a
 * https://github.com/ARM-software/abi-aa/tree/main/aapcs32
 */
.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

.macro defun nombre
    .section .text.\nombre
    .global \nombre
    .type \nombre, %function
\nombre:
.endm

.macro endfun nombre
    .size \nombre, . - \nombre
.endm

defun copiaMemoria
    // Implementación aquí
    // R0: origen, R1: destino, R2: longitud
    cbz R2, 1f //salta a la rutina 1 si la longitud es cero
    ldrb R3, [R0], #1 //es importante razonar como funcionan estas lineas de codigo que escribiste, ver con el debug y como trabajan los registros y memoria (tienes ayuda de un video)
    0:
        
        strb R3, [R1], #1
        ldrb R3, [R0], #1
        cmp R3, #0
        bne 0b //es importante chequear con el debugger como se realiza la simulacion

    1:

    bx lr
endfun copiaMemoria

defun copiaCadena
    // Implementación aquí
    // R0: origen, R1: destino, R2: longitudMaxima
    cbz R2, 1f //salta a la rutina 1 si la longitud es cero
    ldrb R3, [R0], #1
    sub R2, #1

    0: //debe copiarse "cadena" en la direccion que contiene R1
         //me puse a ver que esta 2 lineas de comando sirven en esta funcion pero no puedos remplazarlos directamente arriba en la forma como estan por que el test.c me obliga a que no anule el siguiente byte de la memoria (simular si no entiendes y ver codigo .s y .c)
        strb R3, [R1], #1
        ldrb R3, [R0], #1
        subs R2, #1
        cbz R2, 1f
        cmp R3, #0
        bne 0b //es importante chequear con el debugger como se realiza la simulacion

    1:
        mov R2, #0
        strb R2, [R1] 

    bx lr
endfun copiaCadena

defun mayusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    bx lr
endfun mayusculaEnLugar

defun minusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    bx lr
endfun minusculaEnLugar
