





 















	.syntax unified

	.file "memxor.asm"

	.text
	.arm

	
	.align 4
.globl nettle_memxor
.type nettle_memxor,%function
nettle_memxor:
	cmp	r2, #0
	beq	.Lmemxor_done

	cmp	r2, #7
	bcs	.Lmemxor_large

	
.Lmemxor_bytes:
	ldrb	r3, [r1], #+1
	ldrb	r12, [r0]
	eor	r3, r12
	strb	r3, [r0], #+1
	subs	r2, #1
	bne	.Lmemxor_bytes

.Lmemxor_done:
	bx	lr

.Lmemxor_align_loop:
	ldrb	r3, [r1], #+1
	ldrb	r12, [r0]
	eor	r3, r12
	strb	r3, [r0], #+1
	sub	r2, #1

.Lmemxor_large:
	tst	r0, #3
	bne	.Lmemxor_align_loop

	
	sub	r2, #4

	ands	r3, r1, #3
	beq	.Lmemxor_same

	
	
	
	
	
	
	
	
	
	

	push	{r4,r5,r6}
	
	lsl	r6, r3, #3
	bic	r1, #3
	rsb	r12, r6, #32

	ldr	r4, [r1], #+4

	tst	r2, #4
	itet	eq
	moveq	r5, r4
	subne	r2, #4
	beq	.Lmemxor_odd

.Lmemxor_word_loop:
	ldr	r5, [r1], #+4
	ldr	r3, [r0]
	eor	r3, r3, r4, lsr r6
	eor	r3, r3, r5, lsl r12
	str	r3, [r0], #+4
.Lmemxor_odd:
	ldr	r4, [r1], #+4
	ldr	r3, [r0]
	eor	r3, r3, r5, lsr r6
	eor	r3, r3, r4, lsl r12
	str	r3, [r0], #+4
	subs	r2, #8
	bcs	.Lmemxor_word_loop
	adds	r2, #8
	beq	.Lmemxor_odd_done

	
	lsr	r4, r6
	ldr	r3, [r0]
	eor	r3, r4

	pop	{r4,r5,r6}

	
.Lmemxor_leftover:
	strb	r3, [r0], #+1
	subs	r2, #1
	beq	.Lmemxor_done
	subs	r12, #8
	lsr	r3, #8
	bne	.Lmemxor_leftover
	b	.Lmemxor_bytes
.Lmemxor_odd_done:
	pop	{r4,r5,r6}
	bx	lr

.Lmemxor_same:
	push	{r4,r5,r6,r7,r8,r10,r11,r14}	

	subs	r2, #8
	bcc	.Lmemxor_same_end

	ldmia	r1!, {r3, r4, r5}
	
	mov	r14, r0
	ldmia	r14!, {r6, r7, r8}
	subs	r2, #12
	eor	r10, r3, r6
	eor	r11, r4, r7
	eor	r12, r5, r8
	bcc	.Lmemxor_same_final_store
	subs	r2, #12
	ldmia	r14!, {r6, r7, r8}
	bcc	.Lmemxor_same_wind_down

	
	

.Lmemxor_same_loop:
	
	
	ldmia	r1!, {r3, r4, r5}
	subs	r2, #12
	stmia	r0!, {r10, r11, r12}
	eor	r10, r3, r6
	eor	r11, r4, r7
	eor	r12, r5, r8
	ldmia	r14!, {r6, r7, r8}
	bcs	.Lmemxor_same_loop

.Lmemxor_same_wind_down:
	
	ldmia	r1!, {r3, r4, r5}
	stmia	r0!, {r10, r11, r12}
	eor	r10, r3, r6
	eor	r11, r4, r7
	eor	r12, r5, r8
.Lmemxor_same_final_store:
	stmia	r0!, {r10, r11, r12}
	
.Lmemxor_same_end:
	
	adds	r2, #4
	bcc	.Lmemxor_same_lt_8
	
	ldmia	r1!, {r3, r4}
	ldmia	r0, {r6, r7}
	eor	r3, r6
	eor	r4, r7
	stmia	r0!, {r3, r4}
	pop	{r4,r5,r6,r7,r8,r10,r11,r14}
	beq	.Lmemxor_done
	b	.Lmemxor_bytes

.Lmemxor_same_lt_8:
	pop	{r4,r5,r6,r7,r8,r10,r11,r14}
	adds	r2, #4
	bcc	.Lmemxor_same_lt_4

	ldr	r3, [r1], #+4
	ldr	r12, [r0]
	eor	r3, r12
	str	r3, [r0], #+4
	beq	.Lmemxor_done
	b	.Lmemxor_bytes

.Lmemxor_same_lt_4:
	adds	r2, #4
	beq	.Lmemxor_done
	b	.Lmemxor_bytes
	
.size nettle_memxor, . - nettle_memxor

.section .note.GNU-stack,"",%progbits
