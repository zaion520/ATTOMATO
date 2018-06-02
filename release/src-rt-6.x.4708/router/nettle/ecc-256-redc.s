





 

	.file "ecc-256-redc.asm"
	.arm



 












	
	.text
	.align 2

.globl nettle_ecc_256_redc
.type nettle_ecc_256_redc,%function
nettle_ecc_256_redc:
	push	{r4,r5,r6,r7,r8,r10,r11,lr}

	ldm	r1!, {r0,r2,r3,r4,r5,r6,r7,r8}

	
	
	
	
	
	


	adds	r11, r0, r3
	adcs	r12, r2, #0
	adc	lr, r3, #0

	subs	r10, r2, r0
	sbcs	r11, r11, r2	
	sbcs	r12, r12, r3
	sbc	lr, lr, #0

	
	
	
	
	

	adds	r4, r4, r0
	adcs	r2, r5, r2
	adcs	r3, r6, r3
	adcs	r7, r7, r0
	mov	r0, r4		
	mov	r4, r7
	adcs	r5, r8, r10

	ldm	r1!, {r6,r7,r8}
	adcs	r6, r6, r11
	adcs	r7, r7, r12
	adcs	r8, r8, lr

	
	adcs	r11, r0, r3
	adcs	r12, r2, #0
	adc	lr, r3, #0

	subs	r10, r2, r0
	sbcs	r11, r11, r2	
	sbcs	r12, r12, r3
	sbc	lr, lr, #0

	
	adds	r4, r4, r0
	adcs	r2, r5, r2
	adcs	r3, r6, r3
	adcs	r7, r7, r0
	mov	r0, r4		
	mov	r4, r7
	adcs	r5, r8, r10

	ldm	r1!, {r6,r7,r8}
	adcs	r6, r6, r11
	adcs	r7, r7, r12
	adcs	r8, r8, lr

	
	

	
	
	
	

	
	adcs	r11, r0, #0
	adcs	r12, r2, #0
	subs	r10, r2, r0
	sbcs	r11, r11, r2
	sbc	r12, r12, #0

	
	
	
	
	

	adds	r4, r4, r0
	adcs	r5, r5, r2
	adcs	r6, r6, #0
	adcs	r7, r7, r0
	adcs	r8, r8, r10
	ldm	r1!, {r0, r2}
	mov	lr, #0
	adcs	r11, r11, r0
	adcs	r12, r12, r2

	
	
	

	
	adc	lr, lr, #0
	rsb	lr, lr, #0

	adcs	r0, r3, #0
	adcs	r2, r4, #0
	adcs	r3, r5, #0
	adcs	r4, r6, lr
	adcs	r5, r7, lr
	adcs	r6, r8, lr
	and	lr, lr, #-2
	adcs	r7, r11, lr
	adcs	r8, r12, #0

	sub	r1, r1, #64
	stm	r1, {r0,r2,r3,r4,r5,r6,r7,r8}

	pop	{r4,r5,r6,r7,r8,r10,r11,pc}
.size nettle_ecc_256_redc, . - nettle_ecc_256_redc

.section .note.GNU-stack,"",%progbits
