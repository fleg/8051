.module display

LCD_CMD_HOME = 0b00000010

LCD_CMD_FUNC = 0b00100000
LCD_CMD_FUNC_4_BIT = 0
LCD_CMD_FUNC_8_BIT = 0b00010000
LCD_CMD_FUNC_1_LINE = 0
LCD_CMD_FUNC_2_LINES = 0b00001000
LCD_CMD_FUNC_8_DOTS = 0
LCD_CMD_FUNC_10_DOTS = 0b00000100

LCD_CMD_SHIFT = 0b00010000
LCD_CMD_SHIFT_DISPLAY = 0b00001000
LCD_CMD_SHIFT_CURSOR = 0
LCD_CMD_SHIFT_RIGHT = 0b00000100
LCD_CMD_SHIFT_LEFT = 0

LCD_CMD_CONTROL = 0b00001000
LCD_CMD_CONTROL_DISPLAY_ON = 0b00000100
LCD_CMD_CONTROL_CURSOR_ON = 0b00000010
LCD_CMD_CONTROL_BLINKING_ON = 0b00000001

LCD_E = p2.0
LCD_RW = p2.1
LCD_RS = p2.2
LCD_BF = p1.7

EA = ie.7
EX0 = ie.0
IT0 = tcon.0

RTC_SCLK = p3.7
RTC_IO = p3.6
RTC_CE = p3.5

; RTC_READ = 1
; RTC_WRITE = 0
RTC_RAM = 0b01000000
RTC_CLOCK = 0
RTC_CMD = 0b10000000

RTC_SECONDS_ADDR = 0x00
RTC_WRITE_PROTECTION_ADDR = 0x07

.area INTV (ABS)
.org 0x0000
  ljmp main
  ljmp int0

.area CODE (ABS)
.org 0x0090
main:
  mov a, #0
  mov p1, #0
  mov p2, #0
  mov p3, #0

  setb EA ; enable interrupts
  setb EX0 ; enable int0
  setb IT0 ; int0 on falling edge

  lcall lcd_init
  ; lcall rtc_init

  ; mov dptr, #msg
  ; lcall lcd_puts
  ;mov a, #0xab
  ;lcall lcd_put_hex

;   mov r3, #0x0f
; digits:
;   mov a, r3
;   lcall lcd_put_hex
;   mov a, #' '
;   lcall lcd_putc
;   djnz r3, digits

  mov a, #RTC_SECONDS_ADDR
  lcall rtc_read_addr
  lcall lcd_put_hex

loop:
  nop

  sjmp loop

lcd_put_hex:
  mov r0, a
  mov r1, #2
  mov b, #16
  div ab
lcd_put_hex_c:
  cjne a, #10, lcd_put_hex_ne
lcd_put_hex_ne:
  jc lcd_put_hex_l
  add a, #('a'-10)
  sjmp lcd_put_hex_next
lcd_put_hex_l:
  add a, #'0'
lcd_put_hex_next:
  lcall lcd_putc
  mov a, b
  djnz r1, lcd_put_hex_c
  ret

lcd_puts:
  mov r0, #0
lcd_puts_c:
  mov a, r0
  movc a, @a+dptr
  jz lcd_puts_done
  lcall lcd_putc
  inc r0
  sjmp lcd_puts_c
lcd_puts_done:
  ret


lcd_putc:
  lcall lcd_wait
  mov p1, a
  clr LCD_E
  clr LCD_RW
  clr LCD_RS
  setb LCD_RS
  setb LCD_E
  lcall delay
  clr LCD_E
  ret

lcd_init:
  mov a, #(LCD_CMD_FUNC | LCD_CMD_FUNC_8_BIT | LCD_CMD_FUNC_2_LINES | LCD_CMD_FUNC_8_DOTS)
  lcall lcd_send_instruction 

  mov a, #(LCD_CMD_CONTROL | LCD_CMD_CONTROL_DISPLAY_ON | LCD_CMD_CONTROL_CURSOR_ON)
  lcall lcd_send_instruction

  mov a, #LCD_CMD_HOME
  lcall lcd_send_instruction

  ret

lcd_send_instruction:
  lcall lcd_wait
  mov p1, a
  clr LCD_E
  clr LCD_RW
  clr LCD_RS
  setb LCD_E
  lcall delay
  clr LCD_E
  ret

lcd_wait:
  clr LCD_E
  clr LCD_RW
  clr LCD_RS
  setb LCD_RW
  setb LCD_E
  lcall delay
  clr LCD_E
  jnb LCD_BF, lcd_ready
  sjmp lcd_wait
lcd_ready:
  ret


rtc_send_byte:
  mov r6, #8
rtc_send_byte_loop:
  rrc a
  mov RTC_IO, c
  setb RTC_SCLK
  lcall delay50
  clr RTC_SCLK
  lcall delay50
  djnz r6, rtc_send_byte_loop
  ret


rtc_read_byte:
  mov r6, #8
  mov a, #0
rtc_read_byte_loop:
  mov a.7, RTC_IO
  rr a
  setb RTC_SCLK
  lcall delay50
  clr RTC_SCLK
  lcall delay50
  djnz r6, rtc_read_byte_loop
  ret

rtc_read_addr:
  clr RTC_SCLK
  setb RTC_CE
  lcall delay50
  setb c ; set 0 bit for read
  rlc a
  orl a, #(RTC_CLOCK | RTC_CMD)
  lcall rtc_send_byte
  mov a, #0
  lcall rtc_read_byte
  clr RTC_CE
  ret

rtc_write_addr:
  setb RTC_CE
  lcall delay50
  clr c ; clear 0 bit for write
  rlc a
  orl a, #(RTC_CLOCK | RTC_CMD)
  lcall rtc_send_byte
  mov a, b
  lcall rtc_send_byte
  clr RTC_CE
  ret

rtc_init:
  mov a, #RTC_WRITE_PROTECTION_ADDR
  mov b, #0
  lcall rtc_write_addr
  mov a, #RTC_SECONDS_ADDR
  lcall rtc_read_addr
  anl a, #0b01111111
  mov b, a
  mov a, #RTC_SECONDS_ADDR
  lcall rtc_write_addr
  ret

delay:
  mov r7, #0xff
  djnz r7, #.
  ret

delay50:
  mov r7, #0x7f
  djnz r7, #.
  ret

int0:
  ; mov a, #'i'
  ; lcall lcd_putc
  ; mov a, #(LCD_CMD_SHIFT | LCD_CMD_SHIFT_CURSOR | LCD_CMD_SHIFT_LEFT)
  ; lcall lcd_send_instruction
  reti

msg: .asciz "Hello, world!"
