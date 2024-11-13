% Fichier: filtre_FIR_mod.m
% ----------------------------------
% Initialisation
close all;            % Ferme toutes les fenêtres graphiques
clear;                % Efface toutes les variables

% Sauvegarde automatique des figures
Fe = 16000;           % Fréquence d'échantillonnage en Hz
Te = 1 / Fe;          % Période d'échantillonnage en secondes
ordre = 80;           % Ordre du filtre

% **1. Filtre Passe-Bas**
Fcb = 1400;            % Fréquence de coupure basse en Hz
Fcbn = 2 * Fcb / Fe;   % Normalisation de la fréquence
f_pb = [0 Fcbn Fcbn 1]; % Vecteur de fréquence normalisée pour le filtre passe-bas
H_pb = [1 1 0 0];      % Réponse en amplitude du filtre passe-bas

% Calcul des coefficients du filtre passe-bas
[numG_pb, denG_pb] = fir2(ordre, f_pb, H_pb);

% Affichage de la réponse en fréquence du filtre passe-bas
figure(1);
fhz_pb = f_pb * Fe / 2;
plot(fhz_pb, H_pb);
title('Réponse en fréquence théorique du filtre passe-bas');
xlabel('Fréquence (Hz)');
ylabel('Module');

% Calcul et affichage de la réponse réelle
n = 256;
RepComplexe_pb = freqz(numG_pb, denG_pb, n);  % Valeurs complexes de la réponse
Module_pb = abs(RepComplexe_pb);              % Module de chaque point
ff_pb = Fe / (2 * n) * (0:n-1);
figure(2);
plot(fhz_pb, H_pb, ff_pb, Module_pb);
title('Réponse en fréquence réelle / théorique du filtre passe-bas');
xlabel('Fréquence (Hz)');
ylabel('Module');

% **2. Filtre Passe-Haut**
Fch = 1200;            % Fréquence de coupure pour le passe-haut en Hz
Fchn = 2 * Fch / Fe;   % Normalisation de la fréquence
f_ph = [0 Fchn Fchn 1]; % Vecteur de fréquence normalisée pour le filtre passe-haut
H_ph = [0 0 1 1];      % Réponse en amplitude du filtre passe-haut

% Calcul des coefficients du filtre passe-haut
[numG_ph, denG_ph] = fir2(ordre, f_ph, H_ph);

% Affichage de la réponse en fréquence du filtre passe-bas
figure(3);
fhz_ph = f_ph * Fe / 2;
plot(fhz_ph, H_ph);
title('Réponse en fréquence théorique du filtre passe-haut');
xlabel('Fréquence (Hz)');
ylabel('Module');

% Calcul et affichage de la réponse réelle
n = 256;
RepComplexe_ph = freqz(numG_ph, denG_ph, n);  % Valeurs complexes de la réponse
Module_ph = abs(RepComplexe_ph);              % Module de chaque point
ff_ph = Fe / (2 * n) * (0:n-1);
figure(4);
plot(fhz_ph, H_ph, ff_ph, Module_ph);
title('Réponse en fréquence réelle / théorique du filtre passe-haut');
xlabel('Fréquence (Hz)');
ylabel('Module');

% **3. Filtre Passe-Bande**
Fcb_b = 600;           % Fréquence de coupure basse du passe-bande en Hz
Fch_h = 2000;          % Fréquence de coupure haute du passe-bande en Hz
Fcbn_b = 2 * Fcb_b / Fe; % Normalisation de la fréquence basse
Fchn_h = 2 * Fch_h / Fe; % Normalisation de la fréquence haute
f_pbnd = [0 Fcbn_b Fcbn_b Fchn_h Fchn_h 1]; % Vecteur de fréquence pour le passe-bande
H_pbnd = [0 0 1 1 0 0];   % Réponse en amplitude du filtre passe-bande

% Calcul des coefficients du filtre passe-bande
[numG_pbnd, denG_pbnd] = fir2(ordre, f_pbnd, H_pbnd);

% Affichage de la réponse en fréquence du filtre passe-bande
figure(5);
fhz_pbnd = f_pbnd * Fe / 2;
plot(fhz_pbnd, H_pbnd);
title('Réponse en fréquence théorique du filtre passe-bade');
xlabel('Fréquence (Hz)');
ylabel('Module');

% Calcul et affichage de la réponse réelle
n = 256;
RepComplexe_pbnd = freqz(numG_pbnd, denG_pbnd, n);
Module_pbnd = abs(RepComplexe_pbnd);              % Module de chaque point
ff_pbnd = Fe / (2 * n) * (0:n-1);
figure(6);
plot(fhz_pbnd, H_pbnd, ff_pbnd, Module_pbnd);
title('Réponse en fréquence réelle / théorique du filtre passe-bande');
xlabel('Fréquence (Hz)');
ylabel('Module');

% Sauvegarde des coefficients pour chaque filtre au format Q15
% Passe-Bas
numG_pb_Q15 = round(numG_pb * 2^15);
fid_pb = fopen('coef_pb.h', 'w');
fprintf(fid_pb, 'short coef_pb[%d] = {', ordre + 1);
fprintf(fid_pb, '%d, ', numG_pb_Q15(1:ordre));
fprintf(fid_pb, '%d', numG_pb_Q15(ordre + 1));
fprintf(fid_pb, '};\n');
fclose(fid_pb);

% Passe-Haut
numG_ph_Q15 = round(numG_ph * 2^15);
fid_ph = fopen('coef_ph.h', 'w');
fprintf(fid_ph, 'short coef_ph[%d] = {', ordre + 1);
fprintf(fid_ph, '%d, ', numG_ph_Q15(1:ordre));
fprintf(fid_ph, '%d', numG_ph_Q15(ordre + 1));
fprintf(fid_ph, '};\n');
fclose(fid_ph);

% Passe-Bande
numG_pbnd_Q15 = round(numG_pbnd * 2^15);
fid_pbnd = fopen('coef_pbnd.h', 'w');
fprintf(fid_pbnd, 'short coef_pbnd[%d] = {', ordre + 1);
fprintf(fid_pbnd, '%d, ', numG_pbnd_Q15(1:ordre));
fprintf(fid_pbnd, '%d', numG_pbnd_Q15(ordre + 1));
fprintf(fid_pbnd, '};\n');
fclose(fid_pbnd);

