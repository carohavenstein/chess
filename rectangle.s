.global marco_sup_inf
.global rectangle

// color    w3
// height   x4
// widht    x5
// location x6

marco_sup_inf:
    mov x10,x6              // posicion primer pixel
    mov x14,x4           	// Tamaño en Y
    loop1:
        mov x15,x5         	// Tamaño en X
            loop0:
                sturh w3,[x10]	   	// Setear el color del pixel N
                add x10,x10,2	   	    // Siguiente pixel
                sub x15,x15,1	   	// Decrementar el contador X
            cbnz x15,loop0	   	    // Si no terminó la fila, saltar    

        sub x14,x14,1	   		// Decrementar el contador Y
        cbnz x14,loop1	  	// Si no es la última fila, saltar		
    
    ret


// color    w3
// height   x4
// widht    x5
// location x6

rectangle:
    mov x10,x6              // posicion primer pixel
    mov x14,x4           	// Tamaño en Y
    outer_loop:
        mov x15,x5         	// Tamaño en X
            inner_loop:
                sturh w3,[x10]	   	// Setear el color del pixel N
                add x10,x10,2	   	    // Siguiente pixel
                sub x15,x15,1	   	// Decrementar el contador X
            cbnz x15,inner_loop	   	    // Si no terminó la fila, saltar    
        mov x10,x6
        add x10,x10,1024               // pixel de la siguiente linea
        sub x14,x14,1	   		// Decrementar el contador Y
        cbnz x14,outer_loop	  	// Si no es la última fila, saltar		
    
    ret
