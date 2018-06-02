





 

	.file "ecc-384-modp.asm"
	.arm













	
	
	.text
	.align 2

.globl nettle_ecc_384_modp
.type nettle_ecc_384_modp,%function
nettle_ecc_384_modp:
	push	{r4,r5,r6,r7,r8,r10,lr}

	add	r1, r1, #80
	ldm	r1, {r0, r2, r3, r4}	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	adds	r5, r0, r2
	adcs	r6, r2, #0
	adcs	r7, r4, #0
	subs	r5, r5, r4
	sbcs	r6, r6, #0
	sbcs	r7, r7, #0

	
	
	
	

	mov	r10, #0
	adds	r6, r6, r3
	adcs	r7, r7, r3
	adcs	r8, r4, #0
	adcs	r10, r10, #0

	
	sub	r1, r1, #32
	ldm	r1, {r0, r2, r3, r4}	
	mov	lr, #0
	adds	r5, r0, r5
	adcs	r6, r2, r6
	adcs	r7, r3, r7
	adcs	r8, r4, r8
	adcs	r10, r10, #0			

	
	sub	r1, r1, #48
	ldm	r1, {r0, r2, r3, r4}	
	mov	lr, #0
	adds	r0, r0, r5
	adcs	r2, r2, r6
	adcs	r3, r3, r7
	adcs	r4, r4, r8
	adc	lr, lr, #0
	subs	r2, r2, r5
	sbcs	r3, r3, r6
	sbcs	r4, r4, r7
	sbc	lr, lr, #0
	adds	r4, r4, r5
	adc	lr, lr, #0
	
	stm	r1!, {r0,r2,r3,r4}	
	mov	r12, #2
.Loop:
	ldm	r1, {r0,r2,r3,r4}	

	
	adds	r0, r0, lr
	asr	lr, #31		
	adcs	r2, r2, lr
	adcs	r3, r3, lr
	adcs	r4, r4, lr
	adc	lr, lr, #0

	
	adds	r0, r0, r5
	adcs	r2, r2, r6
	adcs	r3, r3, r7
	adcs	r4, r4, r8
	adc	lr, lr, #0

	
	ldr	r5, [r1, #+48]		
	adds	r0, r0, r6
	adcs	r2, r2, r7
	adcs	r3, r3, r8
	adcs	r4, r4, r5
	adc	lr, lr, #0

	
	ldr	r6, [r1, #+52]		
	ldr	r7, [r1, #+56]
	subs	r0, r0, r8
	sbcs	r2, r2, r5
	sbcs	r3, r3, r6
	sbcs	r4, r4, r7
	sbcs	lr, lr, #0

	
	ldr	r8, [r1, #+60]		
	adds	r0, r0, r5
	adcs	r2, r2, r6
	adcs	r3, r3, r7
	adcs	r4, r4, r8
	adc	lr, lr, #0
	subs	r12, r12, #1
	stm	r1!, {r0,r2,r3,r4}
	bne	.Loop

	
	
	
	
	
	
	sub	r1, r1, #48

	ldm	r1, {r0,r2,r3,r4}	

	
	
	
	
	
	
	
	
	
	
	
	
	

	
	mov	r5, lr		
	asr	lr, #31
	subs	r6, lr, r5	
	sbc	r7, r7, r7	
	sbc	r8, r5, #0	

	adds	r0, r0, r5
	adcs	r2, r2, r6
	adcs	r3, r3, r7
	adcs	r4, r4, r8
	adc	lr, lr, r5	

	stm	r1!, {r0,r2,r3,r4}	
	ldm	r1, {r0,r2,r3,r4}	
	
	
	
	
	
	rsbs	r6, r10, #0
	sbc	r7, r7, r7
	sbc	r8, r10, #0

	
	adds	r5, r10, lr
	asr	lr, lr, #31	
	adcs	r6, r6, lr
	adcs	r7, r7, lr
	adcs	r8, r8, lr
	adcs	r10, r10, lr
	adc	lr, lr, #0
	
	adds	r0, r0, r5
	adcs	r2, r2, r6
	adcs	r3, r3, r7
	adcs	r4, r4, r8

	stm	r1!, {r0,r2,r3,r4}	
	ldm	r1, {r0,r2,r3,r4}	

	adcs	r0, r0, r10
	adcs	r2, r2, lr
	adcs	r3, r3, lr
	adcs	r4, r4, lr
	adc	lr, lr, #0
	
	stm	r1, {r0,r2,r3,r4}	

	
	sub	r1, r1, #32
	ldm	r1, {r0,r2,r3,r4}	
	
	mov	r5, lr
	asr	lr, #31
	subs	r6, lr, r5
	sbc	r7, r7, r7
	sbc	r8, r5, #0
	add	r10, r5, lr

	adds	r0, r0, r5
	adcs	r2, r2, r6
	adcs	r3, r3, r7
	adcs	r4, r4, r8
	
	stm	r1!, {r0,r2,r3,r4}	
	ldm	r1, {r0,r2,r3,r4}	
	adcs	r0, r0, r10
	adcs	r2, r2, lr
	adcs	r3, r3, lr
	adcs	r4, r4, lr
	stm	r1!, {r0,r2,r3,r4}	
	ldm	r1, {r0,r2,r3,r4}	
	adcs	r0, r0, lr
	adcs	r2, r2, lr
	adcs	r3, r3, lr
	adcs	r4, r4, lr
	stm	r1!, {r0,r2,r3,r4}	
	pop	{r4,r5,r6,r7,r8,r10,pc}
.size nettle_ecc_384_modp, . - nettle_ecc_384_modp

.section .note.GNU-stack,"",%progbits
