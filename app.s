.globl app
app:
	//---------------- Inicialización GPIO --------------------

	mov w20, PERIPHERAL_BASE + GPIO_BASE     // Dirección de los GPIO.		
	
	// Configurar GPIO 17 como input:
	mov X21,#0
	str w21,[x20,GPIO_GPFSEL1] 		// Coloco 0 en Function Select 1 (base + 4)   	
	
	//---------------- Main code --------------------
	// X0 contiene la dirección base del framebuffer (NO MODIFICAR)
	
loop:
	mov w3,0x00FF    	// color
	mov x4,48			// height
	mov x5,512			// width
	add x6,x0,0		// X6 dirección base del framebuffer
	bl marco_sup_inf

	mox x9,8	//columns
	board_column_loop:
		mov x10,8	// rows
		board_row_loop:
			add x6,x6,48		// left margin
			add x11,x19,x10 	// rows + columns
			and x11,x11,1
			cmp x11,0
			b.ne uneven
			mov w3,0xFFFF    		// color white - even
			b skip
			uneven: mov w3,0x0000		// color black
			skip:
			mov x4,52			// height
			mov x5,52			// width
			bl rectangle
			add x6
			sub x10,x10,1




	---------------------
	mov x11,x4           	// Tamaño en Y

    loop1:
        mov x12,x5         	// Tamaño en X
            loop0:
                sturh w3,[x6]	   	// Setear el color del pixel N
                add x6,x6,2	   	    // Siguiente pixel
                sub x12,x12,1	   	// Decrementar el contador X
            cbnz x12,loop0	   	    // Si no terminó la fila, saltar    
        add x6,x6,1023               // pixel de la siguiente linea
        sub x11,x11,1	   		// Decrementar el contador Y
        cbnz x11,loop1	  	// Si no es la última fila, saltar
	------------------------




	b loop

	