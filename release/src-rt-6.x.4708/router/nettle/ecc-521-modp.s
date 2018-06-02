





 

	.file "ecc-521-modp.asm"
	.arm













	
	.text
.Lc511:
	.int 511

	.align 2

.globl nettle_ecc_521_modp
.type nettle_ecc_521_modp,%function
nettle_ecc_521_modp:
	push	{r4,r5,r6,r7,r8,lr}

	
	ldr	r8, [r1, #+68]		
	add	r0, r1, #72		
	ldr	r2, [r1]		
	adds	r2, r2, r8, lsl	#23
	str	r2, [r1], #+4
	mov	lr, #5

	
	
.Loop:
	ldm	r1, {r2,r3,r4}		
	lsr	r5, r8, #9
	ldm	r0!, {r6,r7,r8}		
	orr	r5, r5, r6, lsl #23
	lsr	r6, r6, #9
	orr	r6, r6, r7, lsl #23
	lsr	r7, r7, #9
	orr	r7, r7, r8, lsl #23
	adcs	r2, r2, r5
	adcs	r3, r3, r6
	adcs	r4, r4, r7
	sub	lr, lr, #1
	stm	r1!,{r2,r3,r4}
	teq	lr, #0
	bne	.Loop

	ldr	r5, [r1], #-64		
	ldr	r6, [r0]		
	ldr	r2, .Lc511

	
	
	adcs	r5, r5, r8, lsr #9
	
	and	r12, r5, r2
	mov	r5, r5, rrx
	lsr	r5, r5, #8
	
	adds	r5, r5, r6, lsl #14
	lsr	r6, r6, #18
	adc	r6, r6, #0

	ldm	r1, {r2, r3}		
	adds	r2, r2, r5
	adcs	r3, r3, r6
	stm	r1!, {r2, r3}

	ldm	r1, {r2,r3,r4,r5,r6,r7,r8}	
	adcs	r2, r2, #0
	adcs	r3, r3, #0
	adcs	r4, r4, #0
	adcs	r5, r5, #0
	adcs	r6, r6, #0
	adcs	r7, r7, #0
	adcs	r8, r8, #0
	stm	r1!, {r2,r3,r4,r5,r6,r7,r8}	
	ldm	r1, {r2,r3,r4,r5,r6,r7,r8}	
	adcs	r2, r2, #0
	adcs	r3, r3, #0
	adcs	r4, r4, #0
	adcs	r5, r5, #0
	adcs	r6, r6, #0
	adcs	r7, r7, #0
	adcs	r8, r8, #0
	adcs	r12, r12, #0
	stm	r1, {r2,r3,r4,r5,r6,r7,r8,r12}	

	pop	{r4,r5,r6,r7,r8,pc}
.size nettle_ecc_521_modp, . - nettle_ecc_521_modp

.section .note.GNU-stack,"",%progbits
