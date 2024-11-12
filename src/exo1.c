//=============================================
//      pass.c
//=============================================

#include "dsk6416.h"
#include "dsk6416_aic23.h"
#include "dsk6416_dip.h"
#include "dsk6416_led.h"

#include "pass.h"
#define AQ14 ((int16_t) (32487))
#define BQ14 ((int16_t) (-16384))
#define CQ14 ((int16_t) (2138))
short yn2=0;
short yn1=CQ14;
short yn = 0;

//Sampling frequency
uint32_t fs=DSK6416_AIC23_FREQ_96KHZ;

short update_oscillator()
{

    yn = (AQ14 * yn1 + BQ14 * yn2) >> 14;
    yn2 = yn1;
    yn1 = yn;
    return yn;
}

//New ADC sample interrupt
interrupt void c_int11()
{
  short yn;

  DSK6416_LED_off(0);

  yn = update_oscillator();

  output_left_sample(yn);               //real-time output

  DSK6416_LED_on(0);
}

void main()
{
    DSK6416_DIP_init();
    DSK6416_LED_init();

    //init codec,DSK, MCBSP
         comm_intr();   // or without interrupt: comm_poll();

        while(1)
        {
           //Dip switchs and leds example
            if (DSK6416_DIP_get(2) == 1)
               DSK6416_LED_off(1);
            else
               DSK6416_LED_on(1);
        }
}                                               //end of main


