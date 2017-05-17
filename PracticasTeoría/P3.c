#include <16f877.h>
#fuses HS,NOPROTECT,  //Indicamos que trabajaremos a alta frecuencia
#use delay(clock=20000000) //Frecuencia de oscilaciòn de acuerdo al cristal ensamblado
#org 0x1F00, 0x1FFF void loader16F877(void) {}

int puertoB = 0xF;
int puertoC = 0x0;
int temp = 0;

int tabla (int);
void swap ();

void main(){
   output_b(tabla(puertoB));
   output_c(tabla(puertoC));

   while(1){
      int entrada;
      delay_ms(100);
      entrada = input_a();

      switch (entrada) {
         case 1:
            temp = puertoB;
            puertoB = puertoC;
            puertoC = temp;
            output_b(tabla(puertoB));
            output_c(tabla(puertoC));
            delay_ms(100);
            break;
         case 2:
            puertoB = 0;
            puertoC = 0;
            output_b(tabla(puertoB));
            output_c(tabla(puertoC));
            break;
         case 4:
            entrada = 0;
            while (entrada != 4) {   
               output_b(0x00); //poner unos en todos los bits del puerto b
               output_c(0x00); //poner unos en todos los bits del puerto b
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               output_b(tabla(puertoB));
               output_c(tabla(puertoC));
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
               delay_ms(100);
               if (input_a() == 4) break;
            }
            delay_ms(100);
            output_b(tabla(puertoB));
              output_c(tabla(puertoC));
            break;
         case 8:
         //01
            puertoC ++;
            if (puertoC == 0x10 ) {
               puertoC = 0x00;
                puertoB++;
               
                  if(tabla(puertoB)==0x10 || tabla(puertoB)==0x00){ 
                 puertoB=0x00; 
                 puertoC = 0x00;
            }
             
            
              
            }
            output_b(tabla(puertoB));
            output_c(tabla(puertoC));
         
            break;
         case 16:
         //10 0F 
            puertoC --;

            if (puertoC == 0xFF) {
               puertoC = 0x0F;
               puertoB--;
               if(puertoB == 0xFF){
                  puertoC = 0x0F;
                  puertoB = 0x0F;
               }
               
               
               
            }
             
               
            
            output_b(tabla(puertoB));
            output_c(tabla(puertoC));
            break;
      }
   }
}

int tabla(int valor) {
   switch (valor) {
      case 0:
         return 63;
         break;
      case 1:
         return 6;
         break;
      case 2:
         return 91;
         break;
      case 3:
         return 79;
         break;
      case 4:
         return 102;
         break;
      case 5:
         return 109;
         break;
      case 6:
         return 125;
         break;
      case 7:
         return 7;
         break;
      case 8:
         return 127;
         break;
      case 9:
         return 103;
         break;
      case 0xA:
         return 119;
         break;
      case 0xB:
         return 124;
         break;
      case 0xC:
         return 57;
         break;
      case 0xD:
         return 94;
         break;
      case 0xE:
         return 121;
         break;
      case 0xF:
         return 113;
         break;
      default:
         break;
   }
}
