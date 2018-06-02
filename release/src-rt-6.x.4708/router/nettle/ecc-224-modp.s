





 

	.file "ecc-224-modp.asm"
	.arm


 













	
	.text
	.align 2

.globl nettle_ecc_224_modp
.type nettle_ecc_224_modp,%function
nettle_ecc_224_modp:
	push	{r4,r5,r6,r7,r8,r10,r11,lr}

	add	lr, r1, #28
	ldm	lr, {r2,r3,r4,r5,r6,r7,r8}
	mov	r0, #0

	adds	r2, r2, r6
	adcs	r3, r3, r7
	adcs	r4, r4, r8
	adc	r0, r0, #0

	
	
	
	
	

	sbcs	r10, r5, r2
	sbcs	r6, r6, r3
	sbcs	r7, r7, r4
	sbcs	r8, r8, r0
	mov	r0, #1		
	sbc	r0, #0
	subs	r8, r8, r5
	sbc	r0, #0

	
	ldm	r1!, {r11,r12,lr}

	
	adds	r1, #0

	sbcs	r2, r11, r2
	sbcs	r3, r12, r3
	sbcs	r4, lr, r4
	ldm	r1!, {r5,r11,r12,lr}
	sbcs	r5, r5, r10
	sbcs	r6, r11, r6
	sbcs	r7, r12, r7
	sbcs	r8, lr, r8
	rsc	r0, r0, #0

	
	
	
	subs	r2, r2, r0
	asr	r12, r0, #1
	sbcs	r3, r3, r12
	eor	r0, r0, r12
	sbcs	r4, r4, r12
	sbcs	r5, r5, r0
	sbcs	r6, r6, #0
	sbcs	r7, r7, #0
	sbcs	r8, r8, #0
	sbcs	r0, r0, r0

	
	subs	r2, r2, r0
	sbcs	r3, r3, r0
	sbcs	r4, r4, r0
	sbcs	r5, r5, #0
	sbcs	r6, r6, #0
	sbcs	r7, r7, #0
	sbcs	r8, r8, #0

	stmdb	r1, {r2,r3,r4,r5,r6,r7,r8}

	pop	{r4,r5,r6,r7,r8,r10,r11,pc}
.size nettle_ecc_224_modp, . - nettle_ecc_224_modp

.section .note.GNU-stack,"",%progbits
