#include <8051.h>
#include <stdint.h>

#define CPU_FREQ 11059200
#define CLOCK_TIME (1.0f / CPU_FREQ)
#define CLOCKS_IN_MS (uint16_t)(0.001f / CLOCK_TIME)

#define nop() __asm nop __endasm;

#define RTC_SCLK P3_7
#define RTC_IO P3_6
#define RTC_CE P3_5
 #define _RTC_IO   _P3_6
 #define _RTC_SCLK _P3_7

#define LCD_E P2_0
#define LCD_RW P2_1
#define LCD_RS P2_2
#define LCD_BF P1_7
#define LCD_DATA P1

#define LCD_CMD_HOME 0b00000010
#define LCD_CMD_FUNC 0b00100000
#define LCD_CMD_FUNC_4_BIT 0
#define LCD_CMD_FUNC_8_BIT 0b00010000
#define LCD_CMD_FUNC_1_LINE 0
#define LCD_CMD_FUNC_2_LINES 0b00001000
#define LCD_CMD_FUNC_8_DOTS 0
#define LCD_CMD_FUNC_10_DOTS 0b00000100
#define LCD_CMD_CONTROL 0b00001000
#define LCD_CMD_CONTROL_DISPLAY_ON 0b00000100
#define LCD_CMD_CONTROL_CURSOR_ON 0b00000010
#define LCD_CMD_CONTROL_BLINKING_ON 0b00000001

void delay(uint8_t ms) {
	for (uint16_t i = ms * (CLOCKS_IN_MS); i != 0; i--);
}

void lcd_wait() {
	uint8_t is_busy;
	LCD_E = 0;
	LCD_RW = 0;
	LCD_RS = 0;

	do {
		LCD_RW = 1;
		LCD_E = 1;
		delay(1);
		is_busy = LCD_BF;
		LCD_E = 0;
	} while (is_busy != 0);
}

void lcd_send_instruction(uint8_t cmd) {
	lcd_wait();

	LCD_DATA = cmd;
	LCD_E = 0;
	LCD_RW = 0;
	LCD_RS = 0;
	LCD_E = 1;
	delay(1);
	LCD_E = 0;
}

void lcd_init() {
	lcd_send_instruction(LCD_CMD_FUNC | LCD_CMD_FUNC_8_BIT | LCD_CMD_FUNC_2_LINES | LCD_CMD_FUNC_8_DOTS);
	lcd_send_instruction(LCD_CMD_CONTROL | LCD_CMD_CONTROL_DISPLAY_ON | LCD_CMD_CONTROL_CURSOR_ON);
	lcd_send_instruction(LCD_CMD_HOME);
}

void lcd_putc(uint8_t c) {
	lcd_wait();

	LCD_DATA = c;
	LCD_E = 0;
	LCD_RW = 0;
	LCD_RS = 0;

	LCD_RS = 1;
	LCD_E = 1;
	delay(1);
	LCD_E = 0;
}

void lcd_puts(const char *str) {
	while (*str) lcd_putc(*str++);
}

void lcd_put_hex(uint8_t b) {
	uint8_t h = (b & 0xf0) >> 4;
	uint8_t l = b &0x0f;

	lcd_putc(h > 9 ? h + 'a' - 10 : h + '0');
	lcd_putc(l > 9 ? l + 'a' - 10 : l + '0');
}


// *****************************************
#define DS_CMD        1 << 7
#define DS_CMD_READ   1
#define DS_CMD_WRITE  0
#define DS_CMD_RAM    1 << 6
#define DS_CMD_CLOCK  0 << 6

#define DS_ADDR_SECONDS     0
#define DS_ADDR_MINUTES     1
#define DS_ADDR_HOUR        2
#define DS_ADDR_DAY         3
#define DS_ADDR_MONTH       4
#define DS_ADDR_WEEKDAY     5
#define DS_ADDR_YEAR        6
#define DS_ADDR_WP          7
#define DS_ADDR_TCSDS       8

void sendbyte(uint8_t b)
{
    b;
  __asm
    push	ar7
    mov     a,dpl
    mov	r7,#8
00001$:
    nop
    nop
    rrc     a
    mov     _RTC_IO,c
    setb	_RTC_SCLK
    nop
    nop
    clr	_RTC_SCLK
    djnz	r7,00001$
    pop	ar7
  __endasm;
}

uint8_t readbyte()
{
  __asm
	push	ar7
	mov 	a,#0
	mov 	r7,#8
00002$:
	nop
	nop
	mov	c,_RTC_IO
	rrc	a	
	setb	_RTC_SCLK
	nop
	nop
	clr	_RTC_SCLK
	djnz	r7,00002$
	mov	dpl,a
	pop	ar7
  __endasm;
}

uint8_t ds_readbyte(uint8_t addr) {
    // ds1302 single-byte read
    uint8_t b;
    b = DS_CMD | DS_CMD_CLOCK | addr << 1 | DS_CMD_READ;
    RTC_CE = 0;
    RTC_SCLK = 0;
    RTC_CE = 1;
    // send cmd byte
    sendbyte(b);
    // read byte
    b = readbyte();
    RTC_CE = 0;
    return b;
}

void ds_writebyte(uint8_t addr, uint8_t data) {
    // ds1302 single-byte write
    uint8_t b = 0;
    b = DS_CMD | DS_CMD_CLOCK | addr << 1 | DS_CMD_WRITE;
    RTC_CE = 0;
    RTC_SCLK = 0;
    RTC_CE = 1;
    // send cmd byte
    sendbyte(b);
    // send data byte
    sendbyte(data);

    RTC_CE = 0;
}

void ds_init() {
		uint8_t b;
		b = ds_readbyte(DS_ADDR_WP);
		lcd_put_hex(b);

    ds_writebyte(DS_ADDR_WP, 0);
		b = ds_readbyte(DS_ADDR_WP);
		lcd_put_hex(b);


    ds_writebyte(DS_ADDR_SECONDS, 0);

}

// *****************************************



void main(void) {
	lcd_init();
	ds_init();

	delay(1);

	// lcd_puts("hello!");
	// lcd_put_hex(127);

	for(;;) {
		uint8_t b = ds_readbyte(DS_ADDR_SECONDS);
		lcd_put_hex(b);
		lcd_send_instruction(LCD_CMD_HOME);
		delay(250);
		delay(250);
		delay(250);
		delay(250);
		delay(250);
	}
}
