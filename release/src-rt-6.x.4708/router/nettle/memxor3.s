


























	.syntax unified

	.file "memxor3.asm"

	.text
	.arm

	
	.align 2
.globl nettle_memxor3
.type nettle_memxor3,%function
nettle_memxor3:
	cmp	r3, #0
	beq	.Lmemxor3_ret

	push	{r4,r5,r6,r7,r8,r10,r11}
	cmp	r3, #7

	add	r1, r3
	add	r2, r3
	add	r0, r3

	bcs	.Lmemxor3_large

	
.Lmemxor3_bytes:
	ldrb	r4, [r1, #-1]!
	ldrb	r5, [r2, #-1]!
	eor	r4, r5
	strb	r4, [r0, #-1]!
	subs	r3, #1
	bne	.Lmemxor3_bytes

.Lmemxor3_done:
	pop	{r4,r5,r6,r7,r8,r10,r11}
.Lmemxor3_ret:
	bx	lr

.Lmemxor3_align_loop:
	ldrb	r4, [r1, #-1]!
	ldrb	r5, [r2, #-1]!
	eor	r5, r4
	strb	r5, [r0, #-1]!
	sub	r3, #1

.Lmemxor3_large:
	tst	r0, #3
	bne	.Lmemxor3_align_loop

	
	sub	r3, #4
	ands	r8, r1, #3
	lsl	r8, #3
	beq	.Lmemxor3_a_aligned

	ands	r11, r2, #3
	lsl	r11, #3
	bne	.Lmemxor3_uu

	
	mov	r4, r1
	mov	r1, r2
	mov	r2, r4

.Lmemxor3_au:
	

	
	
	
	
	
	
	
	
	
	
	rsb	r10, r8, #32
	bic	r2, #3

	ldr	r4, [r2]

	tst	r3, #4
	itet	eq
	moveq	r5, r4
	subne	r3, #4
	beq	.Lmemxor3_au_odd

.Lmemxor3_au_loop:
	ldr	r5, [r2, #-4]!
	ldr	r6, [r1, #-4]!
	eor	r6, r6, r4, lsl r10
	eor	r6, r6, r5, lsr r8
	str	r6, [r0, #-4]!
.Lmemxor3_au_odd:
	ldr	r4, [r2, #-4]!
	ldr	r6, [r1, #-4]!
	eor	r6, r6, r5, lsl r10
	eor	r6, r6, r4, lsr r8
	str	r6, [r0, #-4]!
	subs	r3, #8
	bcs	.Lmemxor3_au_loop
	adds	r3, #8
	beq	.Lmemxor3_done

	
	ldr	r5, [r1, #-4]
	eor	r4, r5, r4, lsl r10

.Lmemxor3_au_leftover:
	
	ror	r4, #24
	strb	r4, [r0, #-1]!
	subs	r3, #1
	beq	.Lmemxor3_done
	subs	r8, #8
	sub	r1, #1
	bne	.Lmemxor3_au_leftover
	b	.Lmemxor3_bytes

.Lmemxor3_a_aligned:
	ands	r8, r2, #3
	lsl	r8, #3
	bne	.Lmemxor3_au ;

	
	subs	r3, #8
	bcc	.Lmemxor3_aligned_word_end

	
	
	

	
	

.Lmemxor3_aligned_word_loop:
	ldmdb	r1!, {r4,r5,r6}
	ldmdb	r2!, {r7,r8,r10}
	subs	r3, #12
	eor	r4, r7
	eor	r5, r8
	eor	r6, r10
	stmdb	r0!, {r4, r5,r6}
	bcs	.Lmemxor3_aligned_word_loop

.Lmemxor3_aligned_word_end:
	
	adds	r3, #4
	bcc	.Lmemxor3_aligned_lt_8
	
	ldmdb	r1!, {r4, r5}
	ldmdb	r2!, {r6, r7}
	eor	r4, r6
	eor	r5, r7
	stmdb	r0!, {r4,r5}
	beq	.Lmemxor3_done
	b	.Lmemxor3_bytes

.Lmemxor3_aligned_lt_8:
	adds	r3, #4
	bcc	.Lmemxor3_aligned_lt_4

	ldr	r4, [r1,#-4]!
	ldr	r5, [r2,#-4]!
	eor	r4, r5
	str	r4, [r0,#-4]!
	beq	.Lmemxor3_done
	b	.Lmemxor3_bytes

.Lmemxor3_aligned_lt_4:
	adds	r3, #4
	beq	.Lmemxor3_done
	b	.Lmemxor3_bytes

.Lmemxor3_uu:

	cmp	r8, r11
	bic	r1, #3
	bic	r2, #3
	rsb	r10, r8, #32

	bne	.Lmemxor3_uud

	

	ldr	r4, [r1]
	ldr	r6, [r2]
	eor	r4, r6

	tst	r3, #4
	itet	eq
	moveq	r5, r4
	subne	r3, #4
	beq	.Lmemxor3_uu_odd

.Lmemxor3_uu_loop:
	ldr	r5, [r1, #-4]!
	ldr	r6, [r2, #-4]!
	eor	r5, r6
	lsl	r4, r10
	eor	r4, r4, r5, lsr r8
	str	r4, [r0, #-4]!
.Lmemxor3_uu_odd:
	ldr	r4, [r1, #-4]!
	ldr	r6, [r2, #-4]!
	eor	r4, r6
	lsl	r5, r10
	eor	r5, r5, r4, lsr r8
	str	r5, [r0, #-4]!
	subs	r3, #8
	bcs	.Lmemxor3_uu_loop
	adds	r3, #8
	beq	.Lmemxor3_done

	
	ror	r4, r8
.Lmemxor3_uu_leftover:
	ror	r4, #24
	strb	r4, [r0, #-1]!
	subs	r3, #1
	beq	.Lmemxor3_done
	subs	r8, #8
	bne	.Lmemxor3_uu_leftover
	b	.Lmemxor3_bytes

.Lmemxor3_uud:
	
	rsb	r12, r11, #32

	ldr	r4, [r1]
	ldr	r6, [r2]

	tst	r3, #4
	ittet	eq
	moveq	r5, r4
	moveq	r7, r6
	subne	r3, #4
	beq	.Lmemxor3_uud_odd

.Lmemxor3_uud_loop:
	ldr	r5, [r1, #-4]!
	ldr	r7, [r2, #-4]!
	lsl	r4, r10
	eor	r4, r4, r6, lsl r12
	eor	r4, r4, r5, lsr r8
	eor	r4, r4, r7, lsr r11
	str	r4, [r0, #-4]!
.Lmemxor3_uud_odd:
	ldr	r4, [r1, #-4]!
	ldr	r6, [r2, #-4]!
	lsl	r5, r10
	eor	r5, r5, r7, lsl r12
	eor	r5, r5, r4, lsr r8
	eor	r5, r5, r6, lsr r11
	str	r5, [r0, #-4]!
	subs	r3, #8
	bcs	.Lmemxor3_uud_loop
	adds	r3, #8
	beq	.Lmemxor3_done

	
	add	r1, r1,	r8, lsr #3
	add	r2, r2, r11, lsr #3
	b	.Lmemxor3_bytes
.size nettle_memxor3, . - nettle_memxor3

.section .note.GNU-stack,"",%progbits
