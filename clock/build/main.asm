;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _ds_init
	.globl _ds_writebyte
	.globl _ds_readbyte
	.globl _readbyte
	.globl _sendbyte
	.globl _lcd_put_hex
	.globl _lcd_puts
	.globl _lcd_putc
	.globl _lcd_init
	.globl _lcd_send_instruction
	.globl _lcd_wait
	.globl _delay
	.globl _CY
	.globl _AC
	.globl _F0
	.globl _RS1
	.globl _RS0
	.globl _OV
	.globl _F1
	.globl _P
	.globl _PS
	.globl _PT1
	.globl _PX1
	.globl _PT0
	.globl _PX0
	.globl _RD
	.globl _WR
	.globl _T1
	.globl _T0
	.globl _INT1
	.globl _INT0
	.globl _TXD
	.globl _RXD
	.globl _P3_7
	.globl _P3_6
	.globl _P3_5
	.globl _P3_4
	.globl _P3_3
	.globl _P3_2
	.globl _P3_1
	.globl _P3_0
	.globl _EA
	.globl _ES
	.globl _ET1
	.globl _EX1
	.globl _ET0
	.globl _EX0
	.globl _P2_7
	.globl _P2_6
	.globl _P2_5
	.globl _P2_4
	.globl _P2_3
	.globl _P2_2
	.globl _P2_1
	.globl _P2_0
	.globl _SM0
	.globl _SM1
	.globl _SM2
	.globl _REN
	.globl _TB8
	.globl _RB8
	.globl _TI
	.globl _RI
	.globl _P1_7
	.globl _P1_6
	.globl _P1_5
	.globl _P1_4
	.globl _P1_3
	.globl _P1_2
	.globl _P1_1
	.globl _P1_0
	.globl _TF1
	.globl _TR1
	.globl _TF0
	.globl _TR0
	.globl _IE1
	.globl _IT1
	.globl _IE0
	.globl _IT0
	.globl _P0_7
	.globl _P0_6
	.globl _P0_5
	.globl _P0_4
	.globl _P0_3
	.globl _P0_2
	.globl _P0_1
	.globl _P0_0
	.globl _B
	.globl _ACC
	.globl _PSW
	.globl _IP
	.globl _P3
	.globl _IE
	.globl _P2
	.globl _SBUF
	.globl _SCON
	.globl _P1
	.globl _TH1
	.globl _TH0
	.globl _TL1
	.globl _TL0
	.globl _TMOD
	.globl _TCON
	.globl _PCON
	.globl _DPH
	.globl _DPL
	.globl _SP
	.globl _P0
	.globl _ds_writebyte_PARM_2
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
_P0	=	0x0080
_SP	=	0x0081
_DPL	=	0x0082
_DPH	=	0x0083
_PCON	=	0x0087
_TCON	=	0x0088
_TMOD	=	0x0089
_TL0	=	0x008a
_TL1	=	0x008b
_TH0	=	0x008c
_TH1	=	0x008d
_P1	=	0x0090
_SCON	=	0x0098
_SBUF	=	0x0099
_P2	=	0x00a0
_IE	=	0x00a8
_P3	=	0x00b0
_IP	=	0x00b8
_PSW	=	0x00d0
_ACC	=	0x00e0
_B	=	0x00f0
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
_P0_0	=	0x0080
_P0_1	=	0x0081
_P0_2	=	0x0082
_P0_3	=	0x0083
_P0_4	=	0x0084
_P0_5	=	0x0085
_P0_6	=	0x0086
_P0_7	=	0x0087
_IT0	=	0x0088
_IE0	=	0x0089
_IT1	=	0x008a
_IE1	=	0x008b
_TR0	=	0x008c
_TF0	=	0x008d
_TR1	=	0x008e
_TF1	=	0x008f
_P1_0	=	0x0090
_P1_1	=	0x0091
_P1_2	=	0x0092
_P1_3	=	0x0093
_P1_4	=	0x0094
_P1_5	=	0x0095
_P1_6	=	0x0096
_P1_7	=	0x0097
_RI	=	0x0098
_TI	=	0x0099
_RB8	=	0x009a
_TB8	=	0x009b
_REN	=	0x009c
_SM2	=	0x009d
_SM1	=	0x009e
_SM0	=	0x009f
_P2_0	=	0x00a0
_P2_1	=	0x00a1
_P2_2	=	0x00a2
_P2_3	=	0x00a3
_P2_4	=	0x00a4
_P2_5	=	0x00a5
_P2_6	=	0x00a6
_P2_7	=	0x00a7
_EX0	=	0x00a8
_ET0	=	0x00a9
_EX1	=	0x00aa
_ET1	=	0x00ab
_ES	=	0x00ac
_EA	=	0x00af
_P3_0	=	0x00b0
_P3_1	=	0x00b1
_P3_2	=	0x00b2
_P3_3	=	0x00b3
_P3_4	=	0x00b4
_P3_5	=	0x00b5
_P3_6	=	0x00b6
_P3_7	=	0x00b7
_RXD	=	0x00b0
_TXD	=	0x00b1
_INT0	=	0x00b2
_INT1	=	0x00b3
_T0	=	0x00b4
_T1	=	0x00b5
_WR	=	0x00b6
_RD	=	0x00b7
_PX0	=	0x00b8
_PT0	=	0x00b9
_PX1	=	0x00ba
_PT1	=	0x00bb
_PS	=	0x00bc
_P	=	0x00d0
_F1	=	0x00d1
_OV	=	0x00d2
_RS0	=	0x00d3
_RS1	=	0x00d4
_F0	=	0x00d5
_AC	=	0x00d6
_CY	=	0x00d7
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
_ds_writebyte_PARM_2:
	.ds 1
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area	OSEG    (OVR,DATA)
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	.area IABS    (ABS,DATA)
	.area IABS    (ABS,DATA)
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	.area BSEG    (BIT)
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
	.area HOME    (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT1 (CODE)
	.area GSINIT2 (CODE)
	.area GSINIT3 (CODE)
	.area GSINIT4 (CODE)
	.area GSINIT5 (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------
	.area HOME    (CODE)
__interrupt_vect:
	ljmp	__sdcc_gsinit_startup
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME    (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
	.globl __sdcc_gsinit_startup
	.globl __sdcc_program_startup
	.globl __start__stack
	.globl __mcs51_genXINIT
	.globl __mcs51_genXRAMCLEAR
	.globl __mcs51_genRAMCLEAR
	.area GSFINAL (CODE)
	ljmp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area HOME    (CODE)
__sdcc_program_startup:
	ljmp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'delay'
;------------------------------------------------------------
;ms                        Allocated to registers r7 
;i                         Allocated to registers 
;------------------------------------------------------------
;	F:\fleg\8051\clock\main.c:35: void delay(uint8_t ms) {
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
	ar7 = 0x07
	ar6 = 0x06
	ar5 = 0x05
	ar4 = 0x04
	ar3 = 0x03
	ar2 = 0x02
	ar1 = 0x01
	ar0 = 0x00
	mov	r7,dpl
;	F:\fleg\8051\clock\main.c:36: for (uint16_t i = ms * (CLOCKS_IN_MS); i != 0; i--);
	mov	__mulint_PARM_2,r7
	mov	(__mulint_PARM_2 + 1),#0x00
	mov	dptr,#0x2b33
	lcall	__mulint
	mov	r6,dpl
	mov	r7,dph
00103$:
	mov	a,r6
	orl	a,r7
	jz	00105$
	dec	r6
	cjne	r6,#0xff,00117$
	dec	r7
00117$:
	sjmp	00103$
00105$:
;	F:\fleg\8051\clock\main.c:37: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_wait'
;------------------------------------------------------------
;is_busy                   Allocated to registers r7 
;------------------------------------------------------------
;	F:\fleg\8051\clock\main.c:39: void lcd_wait() {
;	-----------------------------------------
;	 function lcd_wait
;	-----------------------------------------
_lcd_wait:
;	F:\fleg\8051\clock\main.c:41: LCD_E = 0;
;	assignBit
	clr	_P2_0
;	F:\fleg\8051\clock\main.c:42: LCD_RW = 0;
;	assignBit
	clr	_P2_1
;	F:\fleg\8051\clock\main.c:43: LCD_RS = 0;
;	assignBit
	clr	_P2_2
;	F:\fleg\8051\clock\main.c:45: do {
00101$:
;	F:\fleg\8051\clock\main.c:46: LCD_RW = 1;
;	assignBit
	setb	_P2_1
;	F:\fleg\8051\clock\main.c:47: LCD_E = 1;
;	assignBit
	setb	_P2_0
;	F:\fleg\8051\clock\main.c:48: delay(1);
	mov	dpl,#0x01
	lcall	_delay
;	F:\fleg\8051\clock\main.c:49: is_busy = LCD_BF;
	mov	c,_P1_7
	clr	a
	rlc	a
	mov	r7,a
;	F:\fleg\8051\clock\main.c:50: LCD_E = 0;
;	assignBit
	clr	_P2_0
;	F:\fleg\8051\clock\main.c:51: } while (is_busy != 0);
	mov	a,r7
	jnz	00101$
;	F:\fleg\8051\clock\main.c:52: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_send_instruction'
;------------------------------------------------------------
;cmd                       Allocated to registers r7 
;------------------------------------------------------------
;	F:\fleg\8051\clock\main.c:54: void lcd_send_instruction(uint8_t cmd) {
;	-----------------------------------------
;	 function lcd_send_instruction
;	-----------------------------------------
_lcd_send_instruction:
	mov	r7,dpl
;	F:\fleg\8051\clock\main.c:55: lcd_wait();
	push	ar7
	lcall	_lcd_wait
	pop	ar7
;	F:\fleg\8051\clock\main.c:57: LCD_DATA = cmd;
	mov	_P1,r7
;	F:\fleg\8051\clock\main.c:58: LCD_E = 0;
;	assignBit
	clr	_P2_0
;	F:\fleg\8051\clock\main.c:59: LCD_RW = 0;
;	assignBit
	clr	_P2_1
;	F:\fleg\8051\clock\main.c:60: LCD_RS = 0;
;	assignBit
	clr	_P2_2
;	F:\fleg\8051\clock\main.c:61: LCD_E = 1;
;	assignBit
	setb	_P2_0
;	F:\fleg\8051\clock\main.c:62: delay(1);
	mov	dpl,#0x01
	lcall	_delay
;	F:\fleg\8051\clock\main.c:63: LCD_E = 0;
;	assignBit
	clr	_P2_0
;	F:\fleg\8051\clock\main.c:64: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_init'
;------------------------------------------------------------
;	F:\fleg\8051\clock\main.c:66: void lcd_init() {
;	-----------------------------------------
;	 function lcd_init
;	-----------------------------------------
_lcd_init:
;	F:\fleg\8051\clock\main.c:67: lcd_send_instruction(LCD_CMD_FUNC | LCD_CMD_FUNC_8_BIT | LCD_CMD_FUNC_2_LINES | LCD_CMD_FUNC_8_DOTS);
	mov	dpl,#0x38
	lcall	_lcd_send_instruction
;	F:\fleg\8051\clock\main.c:68: lcd_send_instruction(LCD_CMD_CONTROL | LCD_CMD_CONTROL_DISPLAY_ON | LCD_CMD_CONTROL_CURSOR_ON);
	mov	dpl,#0x0e
	lcall	_lcd_send_instruction
;	F:\fleg\8051\clock\main.c:69: lcd_send_instruction(LCD_CMD_HOME);
	mov	dpl,#0x02
;	F:\fleg\8051\clock\main.c:70: }
	ljmp	_lcd_send_instruction
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_putc'
;------------------------------------------------------------
;c                         Allocated to registers r7 
;------------------------------------------------------------
;	F:\fleg\8051\clock\main.c:72: void lcd_putc(uint8_t c) {
;	-----------------------------------------
;	 function lcd_putc
;	-----------------------------------------
_lcd_putc:
	mov	r7,dpl
;	F:\fleg\8051\clock\main.c:73: lcd_wait();
	push	ar7
	lcall	_lcd_wait
	pop	ar7
;	F:\fleg\8051\clock\main.c:75: LCD_DATA = c;
	mov	_P1,r7
;	F:\fleg\8051\clock\main.c:76: LCD_E = 0;
;	assignBit
	clr	_P2_0
;	F:\fleg\8051\clock\main.c:77: LCD_RW = 0;
;	assignBit
	clr	_P2_1
;	F:\fleg\8051\clock\main.c:78: LCD_RS = 0;
;	assignBit
	clr	_P2_2
;	F:\fleg\8051\clock\main.c:80: LCD_RS = 1;
;	assignBit
	setb	_P2_2
;	F:\fleg\8051\clock\main.c:81: LCD_E = 1;
;	assignBit
	setb	_P2_0
;	F:\fleg\8051\clock\main.c:82: delay(1);
	mov	dpl,#0x01
	lcall	_delay
;	F:\fleg\8051\clock\main.c:83: LCD_E = 0;
;	assignBit
	clr	_P2_0
;	F:\fleg\8051\clock\main.c:84: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_puts'
;------------------------------------------------------------
;str                       Allocated to registers 
;------------------------------------------------------------
;	F:\fleg\8051\clock\main.c:86: void lcd_puts(const char *str) {
;	-----------------------------------------
;	 function lcd_puts
;	-----------------------------------------
_lcd_puts:
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
;	F:\fleg\8051\clock\main.c:87: while (*str) lcd_putc(*str++);
00101$:
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r4,a
	jz	00104$
	mov	dpl,r4
	inc	r5
	cjne	r5,#0x00,00116$
	inc	r6
00116$:
	push	ar7
	push	ar6
	push	ar5
	lcall	_lcd_putc
	pop	ar5
	pop	ar6
	pop	ar7
	sjmp	00101$
00104$:
;	F:\fleg\8051\clock\main.c:88: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'lcd_put_hex'
;------------------------------------------------------------
;b                         Allocated to registers r7 
;h                         Allocated to registers r5 
;l                         Allocated to registers r7 
;------------------------------------------------------------
;	F:\fleg\8051\clock\main.c:90: void lcd_put_hex(uint8_t b) {
;	-----------------------------------------
;	 function lcd_put_hex
;	-----------------------------------------
_lcd_put_hex:
	mov	r7,dpl
;	F:\fleg\8051\clock\main.c:91: uint8_t h = (b & 0xf0) >> 4;
	mov	ar5,r7
	anl	ar5,#0xf0
	clr	a
	swap	a
	xch	a,r5
	swap	a
	anl	a,#0x0f
	xrl	a,r5
	xch	a,r5
	anl	a,#0x0f
	xch	a,r5
	xrl	a,r5
	xch	a,r5
	jnb	acc.3,00115$
	orl	a,#0xf0
00115$:
;	F:\fleg\8051\clock\main.c:92: uint8_t l = b &0x0f;
	anl	ar7,#0x0f
;	F:\fleg\8051\clock\main.c:94: lcd_putc(h > 9 ? h + 'a' - 10 : h + '0');
	mov	a,r5
	add	a,#0xff - 0x09
	jnc	00103$
	mov	ar6,r5
	mov	a,#0x57
	add	a,r6
	mov	r6,a
	sjmp	00104$
00103$:
	mov	a,#0x30
	add	a,r5
	mov	r6,a
00104$:
	mov	dpl,r6
	push	ar7
	lcall	_lcd_putc
	pop	ar7
;	F:\fleg\8051\clock\main.c:95: lcd_putc(l > 9 ? l + 'a' - 10 : l + '0');
	mov	a,r7
	add	a,#0xff - 0x09
	jnc	00105$
	mov	ar6,r7
	mov	a,#0x57
	add	a,r6
	mov	r6,a
	sjmp	00106$
00105$:
	mov	a,#0x30
	add	a,r7
	mov	r6,a
00106$:
	mov	dpl,r6
;	F:\fleg\8051\clock\main.c:96: }
	ljmp	_lcd_putc
;------------------------------------------------------------
;Allocation info for local variables in function 'sendbyte'
;------------------------------------------------------------
;b                         Allocated to registers 
;------------------------------------------------------------
;	F:\fleg\8051\clock\main.c:116: void sendbyte(uint8_t b)
;	-----------------------------------------
;	 function sendbyte
;	-----------------------------------------
_sendbyte:
;	F:\fleg\8051\clock\main.c:134: __endasm;
	push	ar7
	mov	a,dpl
	mov	r7,#8
	00001$:
	nop
	nop
	rrc	a
	mov	_P3_6,c
	setb	_P3_7
	nop
	nop
	clr	_P3_7
	djnz	r7,00001$
	pop	ar7
;	F:\fleg\8051\clock\main.c:135: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'readbyte'
;------------------------------------------------------------
;	F:\fleg\8051\clock\main.c:137: uint8_t readbyte()
;	-----------------------------------------
;	 function readbyte
;	-----------------------------------------
_readbyte:
;	F:\fleg\8051\clock\main.c:155: __endasm;
	push	ar7
	mov	a,#0
	mov	r7,#8
	00002$:
	nop
	nop
	mov	c,_P3_6
	rrc	a
	setb	_P3_7
	nop
	nop
	clr	_P3_7
	djnz	r7,00002$
	mov	dpl,a
	pop	ar7
;	F:\fleg\8051\clock\main.c:156: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ds_readbyte'
;------------------------------------------------------------
;addr                      Allocated to registers r7 
;b                         Allocated to registers 
;------------------------------------------------------------
;	F:\fleg\8051\clock\main.c:158: uint8_t ds_readbyte(uint8_t addr) {
;	-----------------------------------------
;	 function ds_readbyte
;	-----------------------------------------
_ds_readbyte:
;	F:\fleg\8051\clock\main.c:161: b = DS_CMD | DS_CMD_CLOCK | addr << 1 | DS_CMD_READ;
	mov	a,dpl
	add	a,dpl
	mov	r7,a
	mov	a,#0x81
	orl	a,r7
	mov	dpl,a
;	F:\fleg\8051\clock\main.c:162: RTC_CE = 0;
;	assignBit
	clr	_P3_5
;	F:\fleg\8051\clock\main.c:163: RTC_SCLK = 0;
;	assignBit
	clr	_P3_7
;	F:\fleg\8051\clock\main.c:164: RTC_CE = 1;
;	assignBit
	setb	_P3_5
;	F:\fleg\8051\clock\main.c:166: sendbyte(b);
	lcall	_sendbyte
;	F:\fleg\8051\clock\main.c:168: b = readbyte();
	lcall	_readbyte
;	F:\fleg\8051\clock\main.c:169: RTC_CE = 0;
;	assignBit
	clr	_P3_5
;	F:\fleg\8051\clock\main.c:170: return b;
;	F:\fleg\8051\clock\main.c:171: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ds_writebyte'
;------------------------------------------------------------
;data                      Allocated with name '_ds_writebyte_PARM_2'
;addr                      Allocated to registers r7 
;b                         Allocated to registers 
;------------------------------------------------------------
;	F:\fleg\8051\clock\main.c:173: void ds_writebyte(uint8_t addr, uint8_t data) {
;	-----------------------------------------
;	 function ds_writebyte
;	-----------------------------------------
_ds_writebyte:
;	F:\fleg\8051\clock\main.c:176: b = DS_CMD | DS_CMD_CLOCK | addr << 1 | DS_CMD_WRITE;
	mov	a,dpl
	add	a,dpl
	mov	r7,a
	mov	a,#0x80
	orl	a,r7
	mov	dpl,a
;	F:\fleg\8051\clock\main.c:177: RTC_CE = 0;
;	assignBit
	clr	_P3_5
;	F:\fleg\8051\clock\main.c:178: RTC_SCLK = 0;
;	assignBit
	clr	_P3_7
;	F:\fleg\8051\clock\main.c:179: RTC_CE = 1;
;	assignBit
	setb	_P3_5
;	F:\fleg\8051\clock\main.c:181: sendbyte(b);
	lcall	_sendbyte
;	F:\fleg\8051\clock\main.c:183: sendbyte(data);
	mov	dpl,_ds_writebyte_PARM_2
	lcall	_sendbyte
;	F:\fleg\8051\clock\main.c:185: RTC_CE = 0;
;	assignBit
	clr	_P3_5
;	F:\fleg\8051\clock\main.c:186: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ds_init'
;------------------------------------------------------------
;b                         Allocated to registers 
;------------------------------------------------------------
;	F:\fleg\8051\clock\main.c:188: void ds_init() {
;	-----------------------------------------
;	 function ds_init
;	-----------------------------------------
_ds_init:
;	F:\fleg\8051\clock\main.c:190: b = ds_readbyte(DS_ADDR_WP);
	mov	dpl,#0x07
	lcall	_ds_readbyte
;	F:\fleg\8051\clock\main.c:191: lcd_put_hex(b);
	lcall	_lcd_put_hex
;	F:\fleg\8051\clock\main.c:193: ds_writebyte(DS_ADDR_WP, 0);
	mov	_ds_writebyte_PARM_2,#0x00
	mov	dpl,#0x07
	lcall	_ds_writebyte
;	F:\fleg\8051\clock\main.c:194: b = ds_readbyte(DS_ADDR_WP);
	mov	dpl,#0x07
	lcall	_ds_readbyte
;	F:\fleg\8051\clock\main.c:195: lcd_put_hex(b);
	lcall	_lcd_put_hex
;	F:\fleg\8051\clock\main.c:198: ds_writebyte(DS_ADDR_SECONDS, 0);
	mov	_ds_writebyte_PARM_2,#0x00
	mov	dpl,#0x00
;	F:\fleg\8051\clock\main.c:200: }
	ljmp	_ds_writebyte
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;b                         Allocated to registers 
;------------------------------------------------------------
;	F:\fleg\8051\clock\main.c:206: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	F:\fleg\8051\clock\main.c:207: lcd_init();
	lcall	_lcd_init
;	F:\fleg\8051\clock\main.c:208: ds_init();
	lcall	_ds_init
;	F:\fleg\8051\clock\main.c:210: delay(1);
	mov	dpl,#0x01
	lcall	_delay
00102$:
;	F:\fleg\8051\clock\main.c:216: uint8_t b = ds_readbyte(DS_ADDR_SECONDS);
	mov	dpl,#0x00
	lcall	_ds_readbyte
;	F:\fleg\8051\clock\main.c:217: lcd_put_hex(b);
	lcall	_lcd_put_hex
;	F:\fleg\8051\clock\main.c:218: lcd_send_instruction(LCD_CMD_HOME);
	mov	dpl,#0x02
	lcall	_lcd_send_instruction
;	F:\fleg\8051\clock\main.c:219: delay(250);
	mov	dpl,#0xfa
	lcall	_delay
;	F:\fleg\8051\clock\main.c:220: delay(250);
	mov	dpl,#0xfa
	lcall	_delay
;	F:\fleg\8051\clock\main.c:221: delay(250);
	mov	dpl,#0xfa
	lcall	_delay
;	F:\fleg\8051\clock\main.c:222: delay(250);
	mov	dpl,#0xfa
	lcall	_delay
;	F:\fleg\8051\clock\main.c:223: delay(250);
	mov	dpl,#0xfa
	lcall	_delay
;	F:\fleg\8051\clock\main.c:225: }
	sjmp	00102$
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
