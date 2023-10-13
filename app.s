.globl app
app:
	//---------------- Inicialización GPIO --------------------

	mov w20, PERIPHERAL_BASE + GPIO_BASE     // Dirección de los GPIO.		
	
	// Configurar GPIO 17 como input:
	mov X21,#0
	str w21,[x20,GPIO_GPFSEL1] 		// Coloco 0 en Function Select 1 (base + 4)   	
	
	//---------------- Main code --------------------
	// X0 contiene la dirección base del framebuffer (NO MODIFICAR)

	// frame width 48 pixels

						// top frame
	mov x1, 0			// xpixel
	mov x2, 0			// ypixel
	mov w3, 0x00FF		// color
	mov x4, 48			// height
	mov x5, 512			// width

	bl rectangle
						// left frame
	mov x1, 0			// xpixel
	mov x2, 0			// ypixel
	mov x4, 512			// height
	mov x5, 48			// width

	bl rectangle
						// right frame
	mov x1, 464			// xpixel
	mov x2, 0			// ypixel
	mov x4, 512			// height
	mov x5, 48			// width

	bl rectangle
						// bottom frame
	mov x1, 0			// xpixel
	mov x2, 464			// ypixel
	mov x4, 48			// height
	mov x5, 512			// width

	bl rectangle

	// x6, x7, x13, x14, x15

	mov x1, 48			// xpixel
	mov x2, 48			// ypixel
	mov x4, 52			// height
	mov x5, 52			// width

	mov x6, 8		// 8 rows
	board_row_loop:

		mov x7, 8	// 8 columns

		board_column_loop:	

			add x15, x6, x7 	// x15 = row i + column i
			and x15, x15, 1
			cmp x15, 0			// checks if sum of indexes is even or uneven
			b.ne uneven
			
			mov w3,0xFFFF    	// color WHITE
			b skip

			uneven: 
			mov w3,0x0000		// color BLACK
			skip:

			bl rectangle

			add x1, x1, 52		// next square, 52 more pixels in x

			sub x7, x7, 1
			cbnz x7, board_column_loop
			add x2, x2, 52		// pixely + 52 -> next row
			mov x1, 48			// pixelx 48 to start next row

		sub x6, x6, 1
		cbnz x6, board_row_loop

loop:
	b loop


	