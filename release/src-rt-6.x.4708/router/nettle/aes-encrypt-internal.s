





 




























	








	



	













	.file "aes-encrypt-internal.asm"
	
	
	
	
	
	.text
	.align 2

.globl _nettle_aes_encrypt
.type _nettle_aes_encrypt,%function
_nettle_aes_encrypt:
	teq	r3, #0
	beq	.Lend

	push	{r0,r1,r3, r4,r5,r6,r7,r8,r10,r11,lr}
	mov	r0, #0x3fc
	.align 4

.Lblock_loop:
	ldr	r1, [sp, #+48]		
	ldm	sp, {r10, r11}

	
	ldrb	r4, [r1], #+1
	ldrb	r8, [r1], #+1
	orr	r4, r8, lsl #8
	ldrb	r8, [r1], #+1
	orr	r4, r8, lsl #16
	ldrb	r8, [r1], #+1
	orr	r4, r8, lsl #24
	ldr	r8, [r11], #+4
	eor	r4, r8

	
	ldrb	r5, [r1], #+1
	ldrb	r8, [r1], #+1
	orr	r5, r8, lsl #8
	ldrb	r8, [r1], #+1
	orr	r5, r8, lsl #16
	ldrb	r8, [r1], #+1
	orr	r5, r8, lsl #24
	ldr	r8, [r11], #+4
	eor	r5, r8

	
	ldrb	r6, [r1], #+1
	ldrb	r8, [r1], #+1
	orr	r6, r8, lsl #8
	ldrb	r8, [r1], #+1
	orr	r6, r8, lsl #16
	ldrb	r8, [r1], #+1
	orr	r6, r8, lsl #24
	ldr	r8, [r11], #+4
	eor	r6, r8

	
	ldrb	r7, [r1], #+1
	ldrb	r8, [r1], #+1
	orr	r7, r8, lsl #8
	ldrb	r8, [r1], #+1
	orr	r7, r8, lsl #16
	ldrb	r8, [r1], #+1
	orr	r7, r8, lsl #24
	ldr	r8, [r11], #+4
	eor	r7, r8


	str	r1, [sp, #+48]

	add	r2, r2, #256

	b	.Lentry
	.align 4

.Lround_loop:
	
	

	and	r8, r0, r1, lsl #2
	ldr	r4, [r2, r8]
	and	r8, r0, r3, lsl #2
	ldr	r5, [r2, r8]
	and	r8, r0, r12, lsl #2
	ldr	r6, [r2, r8]
	and	r8, r0, r14, lsl #2
	ldr	r7, [r2, r8]

	and	r8, r0, r3, ror #6
	add	r2, r2, #1024
	ldr	r8, [r2, r8]
	eor	r4, r4, r8
	and	r8, r0, r12, ror #6
	ldr	r8, [r2, r8]
	eor	r5, r5, r8
	and	r8, r0, r14, ror #6
	ldr	r8, [r2, r8]
	eor	r6, r6, r8
	and	r8, r0, r1, ror #6
	ldr	r8, [r2, r8]
	eor	r7, r7, r8

	and	r8, r0, r12, ror #14
	add	r2, r2, #1024
	ldr	r8, [r2, r8]
	eor	r4, r4, r8
	and	r8, r0, r14, ror #14
	ldr	r8, [r2, r8]
	eor	r5, r5, r8
	and	r8, r0, r1, ror #14
	ldr	r8, [r2, r8]
	eor	r6, r6, r8
	and	r8, r0, r3, ror #14
	ldr	r8, [r2, r8]
	eor	r7, r7, r8

	and	r8, r0, r14, ror #22
	add	r2, r2, #1024
	ldr	r8, [r2, r8]
	eor	r4, r4, r8
	and	r8, r0, r1, ror #22
	ldr	r8, [r2, r8]
	eor	r5, r5, r8
	and	r8, r0, r3, ror #22
	ldr	r8, [r2, r8]
	eor	r6, r6, r8
	and	r8, r0, r12, ror #22
	ldr	r8, [r2, r8]

	ldm	r11!, {r1,r3,r12,r14}
	eor	r7, r7, r8
	sub	r2, r2, #3072
	eor	r4, r4, r1
	eor	r5, r5, r3
	eor	r6, r6, r12
	eor	r7, r7, r14

	
.Lentry:
	subs	r10, r10,#2
	
	

	and	r8, r0, r4, lsl #2
	ldr	r1, [r2, r8]
	and	r8, r0, r5, lsl #2
	ldr	r3, [r2, r8]
	and	r8, r0, r6, lsl #2
	ldr	r12, [r2, r8]
	and	r8, r0, r7, lsl #2
	ldr	r14, [r2, r8]

	and	r8, r0, r5, ror #6
	add	r2, r2, #1024
	ldr	r8, [r2, r8]
	eor	r1, r1, r8
	and	r8, r0, r6, ror #6
	ldr	r8, [r2, r8]
	eor	r3, r3, r8
	and	r8, r0, r7, ror #6
	ldr	r8, [r2, r8]
	eor	r12, r12, r8
	and	r8, r0, r4, ror #6
	ldr	r8, [r2, r8]
	eor	r14, r14, r8

	and	r8, r0, r6, ror #14
	add	r2, r2, #1024
	ldr	r8, [r2, r8]
	eor	r1, r1, r8
	and	r8, r0, r7, ror #14
	ldr	r8, [r2, r8]
	eor	r3, r3, r8
	and	r8, r0, r4, ror #14
	ldr	r8, [r2, r8]
	eor	r12, r12, r8
	and	r8, r0, r5, ror #14
	ldr	r8, [r2, r8]
	eor	r14, r14, r8

	and	r8, r0, r7, ror #22
	add	r2, r2, #1024
	ldr	r8, [r2, r8]
	eor	r1, r1, r8
	and	r8, r0, r4, ror #22
	ldr	r8, [r2, r8]
	eor	r3, r3, r8
	and	r8, r0, r5, ror #22
	ldr	r8, [r2, r8]
	eor	r12, r12, r8
	and	r8, r0, r6, ror #22
	ldr	r8, [r2, r8]

	ldm	r11!, {r4,r5,r6,r7}
	eor	r14, r14, r8
	sub	r2, r2, #3072
	eor	r1, r1, r4
	eor	r3, r3, r5
	eor	r12, r12, r6
	eor	r14, r14, r7


	bne	.Lround_loop

	lsr	r10, r0, #2	
	sub	r2, r2, #256
	
	
	and	r8, r10, r1
	ldrb	r4, [r2, r8]
	and	r8, r10, r3, ror #8
	ldrb	r8, [r2, r8]
	eor	r4, r4, r8, lsl #8
	and	r8, r10, r12, ror #16
	ldrb	r8, [r2, r8]
	eor	r4, r4, r8, lsl #16
	ldrb	r8, [r2, r14, lsr #24]
	eor	r4, r4, r8, lsl #24
	ldr	r8, [r11], #+4
	eor	r4, r8

	
	and	r8, r10, r3
	ldrb	r5, [r2, r8]
	and	r8, r10, r12, ror #8
	ldrb	r8, [r2, r8]
	eor	r5, r5, r8, lsl #8
	and	r8, r10, r14, ror #16
	ldrb	r8, [r2, r8]
	eor	r5, r5, r8, lsl #16
	ldrb	r8, [r2, r1, lsr #24]
	eor	r5, r5, r8, lsl #24
	ldr	r8, [r11], #+4
	eor	r5, r8

	
	and	r8, r10, r12
	ldrb	r6, [r2, r8]
	and	r8, r10, r14, ror #8
	ldrb	r8, [r2, r8]
	eor	r6, r6, r8, lsl #8
	and	r8, r10, r1, ror #16
	ldrb	r8, [r2, r8]
	eor	r6, r6, r8, lsl #16
	ldrb	r8, [r2, r3, lsr #24]
	eor	r6, r6, r8, lsl #24
	ldr	r8, [r11], #+4
	eor	r6, r8

	
	and	r8, r10, r14
	ldrb	r7, [r2, r8]
	and	r8, r10, r1, ror #8
	ldrb	r8, [r2, r8]
	eor	r7, r7, r8, lsl #8
	and	r8, r10, r3, ror #16
	ldrb	r8, [r2, r8]
	eor	r7, r7, r8, lsl #16
	ldrb	r8, [r2, r12, lsr #24]
	eor	r7, r7, r8, lsl #24
	ldr	r8, [r11], #+4
	eor	r7, r8


	ldr	r1, [sp, #+44]
	ldr	r3, [sp, #+8]

	
	strb	r4, [r1], #+1
	ror	r4, r4, #8
	strb	r4, [r1], #+1
	ror	r4, r4, #8
	strb	r4, [r1], #+1
	ror	r4, r4, #8
	strb	r4, [r1], #+1

	
	strb	r5, [r1], #+1
	ror	r5, r5, #8
	strb	r5, [r1], #+1
	ror	r5, r5, #8
	strb	r5, [r1], #+1
	ror	r5, r5, #8
	strb	r5, [r1], #+1

	
	strb	r6, [r1], #+1
	ror	r6, r6, #8
	strb	r6, [r1], #+1
	ror	r6, r6, #8
	strb	r6, [r1], #+1
	ror	r6, r6, #8
	strb	r6, [r1], #+1

	
	strb	r7, [r1], #+1
	ror	r7, r7, #8
	strb	r7, [r1], #+1
	ror	r7, r7, #8
	strb	r7, [r1], #+1
	ror	r7, r7, #8
	strb	r7, [r1], #+1


	subs	r3, r3, #16
	str	r1, [sp, #+44]
	str	r3, [sp, #+8]

	bhi	.Lblock_loop

	add	sp, sp, #12	
	pop	{r4,r5,r6,r7,r8,r10,r11,pc}
	
.Lend:
	bx	lr
.size _nettle_aes_encrypt, . - _nettle_aes_encrypt

.section .note.GNU-stack,"",%progbits
