





 

	.file "ecc-192-modp.asm"
	.arm

 










 




	
	.text
	.align 2

.globl nettle_ecc_192_modp
.type nettle_ecc_192_modp,%function
nettle_ecc_192_modp:
	push	{r4,r5,r6,r7,r8,r10}
	
	add	r0, r1, #48
	add	r1, r1, #8
	ldmdb	r0!, {r2,r3}
	ldm	r1, {r4,r5,r6,r7,r8,r10}
	mov	r12, #0
	adds	r6, r6, r2
	adcs	r7, r7, r3
	adcs	r8, r8, r2
	adcs	r10, r10, r3
	
	adc	r12, r12, #0

	ldmdb	r0!, {r2,r3}
	mov	r0, #0
	adcs	r4, r4, r2
	adcs	r5, r5, r3
	adcs	r6, r6, r2
	adcs	r7, r7, r3
	
	adc	r0, r0, #0

	ldmdb	r1!, {r2, r3}
	adcs	r2, r2, r8
	adcs	r3, r3, r10
	adcs	r4, r4, r8
	adcs	r5, r5, r10
	adc	r12, r12, #0

	adds	r4, r4, r0
	adcs	r5, r5, #0
	adcs	r6, r6, r12
	adcs	r7, r7, #0
	mov	r0, #0
	adc	r0, r0, #0

	
	adcs	r2, r2, #0
	adcs	r3, r3, #0
	adcs	r4, r4, r0
	adcs	r5, r5, #0
	adcs	r6, r6, #0
	adc	r7, r7, #0

	stm	r1, {r2,r3,r4,r5,r6,r7}

	pop	{r4,r5,r6,r7,r8,r10}
	bx	lr
.size nettle_ecc_192_modp, . - nettle_ecc_192_modp

.section .note.GNU-stack,"",%progbits
