clc;
clear;
close all;
%1. Create open-loop transfer function of the motor
Km = 0.3726;                                                    % Motor gain constant
Kb = 2.3;                                                       % Back-EMF constant
tau_e = 0.0147;                                                 % Electrical time constant
tau_m = 0.5505;                                                 % Mechanical time constant
Kbode = Km / (tau_e * tau_m);                                   % Bode gain constant
wn = sqrt((1 + Kb*Km) / (tau_e* tau_m));                        % Natural frequency
zeta = (tau_e + tau_m) / (2 *sqrt(tau_e * tau_m * (1 +Kb*Km))); % Damping ratio
s = tf('s');                                                    % Creates variable s that you can use in arational expression to create a continuous-time transfer function model
P_motor = Kbode / (s * (s^2 + 2*zeta*wn*s + wn^2));             % Transfer function of the motor 

%2. Plot Bode diagram of the motor
figure;                                                         % Opens new figure window
bode(P_motor);                                                  % Plots magnitude and phase response
grid on;                                                        % Enables grid lines on the plot
title('Bode Plot of Armature Controlled DC Motor');             % Sets title for the plot

%3. Calculate Gain Margin, Phase Margin, and Crossover Frequencies
[GM,PM,wpc,wgc]=margin(P_motor);                                % Extracts GM, PM, phase crossover (wpc),and gain crossover (wgc) frequencies
GM_dB = 20 * log10(GM);                                         % Converts Gain Margin to decibels (dB)

%4.Display stability results in Command Window
fprintf('Gain Crossover Frequency (wgc) = %.4f rad/s\n', wgc);   % Prints wgc
fprintf('Phase Crossover Frequency (wpc) = %.4f rad/s\n', wpc);  % Prints wpc
fprintf('Gain Margin (GM) = %.4f dB\n', GM_dB);                  % Prints GM in dB
fprintf('Phase Margin (PM) = %.4f deg\n', PM);                   % Prints PM in degrees