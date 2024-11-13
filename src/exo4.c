#include "dsk6416.h"
#include "dsk6416_aic23.h"
#include "dsk6416_dip.h"
#include "dsk6416_led.h"

#include "pass.h"
#define FILTER_ORDER 80
short filterStatus = 0;
short x[FILTER_ORDER + 1];
short yn;

// Sampling frequency
uint32_t fs = DSK6416_AIC23_FREQ_16KHZ;

// Coefficients du filtre coupe-bande
short coef_pbnd[81] = {-1, -6, -11, -13, -9, -3, 0, -6, -24, -48, -65, -56, -14, 48, 102, 114, 74, 12, -14, 52, 216, 416, 537, 474, 209, -155, -432, -459, -217, 119, 234, -154, -1093, -2297, -3205, -3223, -2027, 216, 2847, 4955, 5760, 4955, 2847, 216, -2027, -3223, -3205, -2297, -1093, -154, 234, 119, -217, -459, -432, -155, 209, 474, 537, 416, 216, 52, -14, 12, 74, 114, 102, 48, -14, -56, -65, -48, -24, -6, 0, -3, -9, -13, -11, -6, -1};

void apply_filter(short input)
{
    short *h = coef_pbnd;
    int i;

    // Décalage des échantillons d'entrée
    for (i = 0; i < FILTER_ORDER; i++)
    {
        x[i] = x[i + 1];
    }
    x[FILTER_ORDER] = input;
    yn = 0;

    // Calcul de la sortie du filtre (résultat envoyé à l'oscillo)
    for (i = 0; i <= FILTER_ORDER; i++)
    {
        yn += (h[i] * x[i]) >> 15;
    }
}

// New ADC sample interrupt
interrupt void c_int11()
{
    short input = input_left_sample();
    apply_filter(input);
    output_left_sample(yn);

    // Gestion du buffer circulaire
    memo[index] = yn;
    index++;
    if (index >= BUFFER_SIZE) index = 0;
}

void main()
{
    DSK6416_DIP_init();
    DSK6416_LED_init();

    // Init codec, DSK, MCBSP
    comm_intr();   // or without interrupt: comm_poll();

    while (1)
    {
        // Dip switches and LEDs example
        if (DSK6416_DIP_get(2) == 1)
            DSK6416_LED_off(1);
        else
            DSK6416_LED_on(1);
    }
}
