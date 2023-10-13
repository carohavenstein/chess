.globl app
app:
	//---------------- Inicialización GPIO --------------------

	mov w20, PERIPHERAL_BASE + GPIO_BASE     // Dirección de los GPIO.		
	
	// Configurar GPIO 17 como input:
	mov X21,#0
	str w21,[x20,GPIO_GPFSEL1] 		// Coloco 0 en Function Select 1 (base + 4)   	
	
	//---------------- Main code --------------------
	// X0 contiene la dirección base del framebuffer (NO MODIFICAR)
	

	mov w3,0x00FF    	// color
	mov x4,48			// height
	mov x5,512			// width
	add x6,x0,0		// X6 dirección base del framebuffer
	
	bl marco_sup_inf

	mov x14,512
	mov x15,96
	madd x6,x14,x15,x6 	//	x6 = x6 + 513 * 52 * 2

	mov x4,52			// height
	mov x5,52			// width
	
	//mov x9,8		//columns
	//board_row_loop:
		mov x13,8	// rows
		add x6,x6,96		// left margin (48 px)
		board_column_loop:		
			add x11,x9,x13 	// rows + columns
			and x11,x11,1
			cmp x11,0			//checks if sum of indexes are even or uneven
			b.ne uneven
			mov w3,0xFFFF    			// color white
			b skip
			uneven: 
			mov w3,0x0000		// color black
			skip:
			
			bl rectangle
			add x6,x6,104  
			sub x13,x13,1
			cbnz x13,board_column_loop
		
		//add x6,x6,200		//	last pixel of that row
		//mov x1,512
		//mov x2,104
		//madd x6,x1,x2,x6 	//	x6 = x6 + 512 * 52 * 2
		//sub x9,x9,1
		//cbnz x9,board_row_loop

loop:
	b loop

	