% M-File
clc;
clear;
close all;

% --- DC Servo Motor Parameters ---
J = 3.2284E-6;  % Moment of inertia (kg m^2)
B = 3.5077E-6;  % Friction coefficient (N m s/rad)
K = 0.0274;    % Motor constant (V s/rad or N m/A)
R = 4;          % Armature resistance (ohm)
L = 2.75E-6;    % Armature inductance (H)

% --- Define Laplace variable ---
s = tf('s');

% --- Continuous-time Transfer Function theta(s)/V(s) ---
P_motor = K / (s * ((J*s + B)*(L*s + R) + K^2));

% --- Display continuous system ---
disp('Continuous-time transfer function:');
P_motor

% --- Sampling parameters ---
Ts = 0.001;    % Sampling time (1 ms)
t = 0:Ts:0.2;  % Simulation time vector

% --- Discretize using Zero-Order Hold (ZOH) ---
dp_motor = c2d(P_motor, Ts, 'zoh');

% --- Display discrete transfer function (zero-pole form) ---
disp('Discrete-time transfer function (ZOH):');
zpk(dp_motor)

% --- Simplify the discrete model (optional) ---
dp_motor = minreal(dp_motor, 0.001);
zpk(dp_motor)

% --- Closed-loop system with unity feedback ---
sys_cl = feedback(dp_motor, 1);

% --- Step Response ---
[x1, t] = step(sys_cl, 0.5);
figure;
stairs(t, x1);
xlabel('Time (seconds)');
ylabel('Position (radians)');
title('Stairstep Response: Original Digital Position Control');
grid on;

% --- Open Control System Designer (optional) ---
controlSystemDesigner(dp_motor);