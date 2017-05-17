#include <16f877a.h>
#fuses hs,nowdt
#use delay(clock=20000000)

#define lcd_rs_pin pin_b0
#define lcd_rw_pin pin_b1
#define lcd_enable_pin pin_b2
#define lcd_data4 pin_b4
#define lcd_data5 pin_b5
#define lcd_data6 pin_b6
#define lcd_data7 pin_b7
#include <lcd.c>


#byte    PORTB =  0x06
#byte    TRISB =  0x86


int cont=0;
int DATA11[11], DATA;
void data_ascii (int);

void main()
{
   int i=8;

   //PuertoB como entrada
   bit_set(TRISB,1);

   //Redardo para que todo se estabilice
   delay_ms(1000);
   lcd_init();
   lcd_gotoxy(7,2);
   printf(lcd_putc,"F0 1");
   delay_ms(1000);
   lcd_gotoxy(1,1);
   lcd_send_byte(0,0x0f);
   while(true)
   {
      while(bit_test(PORTB,0)==1);
      DATA11[cont++] = bit_test(PORTB,1);
      while(bit_test(PORTB,0)==0);

      if(cont==11)
      {
         int i;
         cont=0;

         for(i=1;i<=8;i++)
         {
            if(DATA11[i]==1)
               bit_set(DATA,8-i);
            else
               bit_clear(DATA,8-i);
         }

         if(DATA!=0x0F){      //Si es diferente del Codigo de Liberacion de Tecla
            data_ascii(DATA);  //que SI muestre.
            delay_ms(200);}

      }
   }
}

void data_ascii(int coord) {
	switch (coord) {
		case 56:
			printf(lcd_putc, "A");
			break;
		case 76:
			printf(lcd_putc, "B");
			break;
		case 132:
			printf(lcd_putc, "C");
			break;
		case 196:
			printf(lcd_putc, "D");
			break;
		case 36:
			printf(lcd_putc, "E");
			break;
		case 212:
			printf(lcd_putc, "F");
			break;
		case 44:
			printf(lcd_putc, "G");
			break;
		case 204:
			printf(lcd_putc, "H");
			break;
		case 194:
			printf(lcd_putc, "I");
			break;
		case 220:
			printf(lcd_putc, "J");
			break;
		case 66:
			printf(lcd_putc, "K");
			break;
		case 210:
			printf(lcd_putc, "L");
			break;
		case 92:
			printf(lcd_putc, "M");
			break;
		case 140:
			printf(lcd_putc, "N");
			break;
		case 34:
			printf(lcd_putc, "O");
			break;
		case 178:
			printf(lcd_putc, "P");
			break;
		case 168:
			printf(lcd_putc, "Q");
			break;
		case 180:
			printf(lcd_putc, "R");
			break;
		case 216:
			printf(lcd_putc, "S");
			break;
		case 52:
			printf(lcd_putc, "T");
			break;
		case 60:
			printf(lcd_putc, "U");
			break;
		case 84:
			printf(lcd_putc, "V");
			break;
		case 184:
		   printf(lcd_putc, "W");
			break;
		case 68:
			printf(lcd_putc, "X");
			break;
		case 172:
			printf(lcd_putc, "Y");
			break;
		case 88:
			printf(lcd_putc, "Z");
			break;
		default:
			return;

	}
}
