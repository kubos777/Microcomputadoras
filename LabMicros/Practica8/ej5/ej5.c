#include <16f877.h>
#fuses HS,NOPROTECT,
#use delay(clock=20000000)
#use rs232(baud=38400, xmit=PIN_C6, rcv=PIN_C7) // (xmit=pinc_c6 ) = tx , (rcv=PIN_C7)= Rx
#org 0x1F00, 0x1FFF void loader16F877(void) {} //for the 8k 16F876/7
char opcion;
int i=0;
void main(){
while(1){   //Mandamos nuestro menú de opciones a la terminal
printf("Indica la opciòn: \n"); //Solicitamos la opción del usuario de acuerdo a lo indicado
printf("0.-Apaga los leds\n");
printf("1.-Prende los leds\n");
printf("2.-Corrimiento a la derecha\n");
printf("3.-Corrimiento a la izquierda\n");
printf("4.-Corrimiento hacia ambos lados\n");
printf("5.-Prende y apaga todos los leds");
printf("salir");
opcion=getch(); //En ensamblador hubieramos configurado el puerto A para recibir el dato de la opcion a realizar
putc(opcion);
switch(opcion){  // Usamos una estructura de c (SWITCH) la cual en ensamblador se realizaría con un xorlw verificando la bandera Z
   case '0':
      output_b(0x00); //En ensamblador hubieramos mandado 0 al puerto B
      break;
   case '1':
      output_b(0xFF); //En ensamblador hubieramos mandado ff al puerto B
      break;
   case '2':  // Corrimiento a la derecha
      int valor =128; 
      int aux=0;  
      while(valor>0){
         output_b(valor); //Pasamos la variable al puerto 
         delay_ms(1000); //En ensamblador se debiò crear una rutina con el tiempo de cada instrucciòn
         aux=valor/2; dividimos
         valor=valor-aux; //Restamos el valor actual en decimal 
         if(valor<1)  // Validamos que haya llegado a uno 
            break;
      }
      

      break; 
   case '3':  //Corrimiento a la izquierda
         int valor2 =1; // inializamos valor2, en ensamblador seria valor 2 equ h'XX' ->Direccion
      int aux2=0;  // Inicializamos auxiliar
      while(valor2<=128){  //Ciclo hasta que el valor mas significativo de os leds
         output_b(valor2); //Scanos al pueto b lo de valor2
         delay_ms(1000); //Enn ensamblador se debiò crear una rutina con el tiempo de cada instrucciòn
         aux2=valor2*2; //Multiplicamos por dos para el recorrimiento
        
      }
      
   break;
   case '4':
   int var2;
            var2=0x80;//Inicilizamo valor 2 con valor hexadecimal 
            output_b(var2); //Var2 lo sacmos por el puerto b 
            delay_ms(1000);  // Retardo de un segundo 
          
 
            do{
                var2=var2/2;// Reducimos el valor a la mitad para el soguiente led
                output_b(var2);  // El var2 pasa al puerto b 
                delay_ms(1000); // Retardo de un segundo 
            }while (var2!=1);  //condicion de paro para  valor sea difente de 1
        
            var2=0x01;
            output_b(var2);
            delay_ms(1000); //Retardo de un segundo 
            do{
                var2+=var2; // Aumenta valor de var2
                output_b(var2); // El var2 pasa al puerto b
                delay_ms(1000); //retardo de un segundo 
            }while (var2!=0x80);   // Hasta llegar al bit menos significativos
            
   break;
   case '5':
      int conta=0;
      while(conta<5){  //En ensamblador hubieramos realizado una comparación contra un bit 
      output_b(0xff); //poner unos en todos los bits del puerto b
      printf(" Todos los bits encendidos \n\r"); //impresion de pantalla
      delay_ms(1000); // retardo fe un segundo
      output_b(0x00);//En ensamblador hubieramos mandado un 00 al puerto B
      printf(" Todos los leds apagados \n\r"); // impresion de pantalla
      delay_ms(1000); // retardo de un segundo
      conta++; //En ensamblador hubieramos utilizado la instrucción INCF
      }//while

      break;             

}

}
}//main
