ALexandre FOLL
Arthus Glandy

12/11/2024

# TNS Rapport de TP

## Matériel

Nous disposont d'une carte C6416T DSK
Sur cette cart il y a : 
- un CPU Texas Instruments TMS320C6416T DSP qui est cadencé à 1 Gigahertz.
- un AIC23 stereo codec.
- 16 Mbytes de DRAM synchronysé
- 512 Kbytes de mémoire flash non volatile
- 4 Leds accessibles à l'utilisateur et un interrupteur DIP
- Configuration matérielle de la carte via des registres implémentés dans un CPLD.
- Options de démarrage configurées et sélection d'entrée d'horloge.
- Connecteurs d'extension standard pour l'utilisation de cartes filles.
- Émulation JTAG via un émulateur JTAG intégré avec interface hôte USB ou un émulateur externe.
- Alimentation électrique à tension unique (+5V).




toujours un input sample et un output sample.

# filtre entrée / sortie 

AIC23 fait la convertion en analogique into numérique et inversement.
CPL_D = composnant logique programmable. 

Un filtre de passe-basse est un circuit électronique qui laisse passer les basses fréquences et bloque les hautes fréquences. Il est utilisé pour éliminer les signaux indésirables de haute fréquence et ne garder que les signaux utiles de basse fréquence. Par exemple, un filtre de passe-basse peut être utilisé pour éliminer les sifflements aigus d'un signal audio.

Un filtre de passe-haut est un circuit électronique qui fonctionne de manière inverse. Il laisse passer les hautes fréquences et bloque les basses fréquences. Il est utilisé pour éliminer les signaux indésirables de basse fréquence et ne garder que les signaux utiles de haute fréquence. Par exemple, un filtre de passe-haut peut être utilisé pour éliminer les bruits de fond graves d'un signal audio.

En général, les filtres de passe-basse et de passe-haut sont utilisés pour améliorer la qualité d'un signal en éliminant les fréquences indésirables. Ils peuvent être utilisés seuls ou en combinaison avec d'autres types de filtres pour obtenir un filtrage plus précis.

# le programme


Les fréquences disponibles pour ce matériel sont de :
- 96khz
- 48khz
- 44khz
- 32khz
- 24hhz
- 16khz
- 8khz
