clc;
clear;
close all;
% Given system
K = 12;
s = tf('s');
G = (K)/(s*(s+1));
% Lead compensator parameters
alpha = 0.334;
T = 0.376;
% Compensator transfer function
Gc = (1 + T*s)/(1 + alpha*T*s);
% Compensated open-loop system
G_comp = Gc*G;
% Display results
disp('Uncompensated Transfer Function G(s):');
G
fprintf('lead factor alpha = %.4f\n',alpha);
fprintf('Time constant T = %.4f seconds\n', T);
disp('Lag Compensator Transfer Function Gc(s):');
Gc
% Compare Bode plots in one figure
figure;
bode(G, G_comp);
grid on;
legend('Uncompensated System', 'Compensated System');
title('Bode Plot Comparison: Uncompensated vs Compensated');
% Display phase margins
[~, PM1] = margin(G);
[~, PM2] = margin(G_comp);
fprintf('Uncompensated Phase Margin = %.2f degrees\n', PM1);
fprintf('Compensated Phase Margin = %.2f degrees\n', PM2);