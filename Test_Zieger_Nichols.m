% Define the calculated PID gains
Kp = 7.6377;
Ki = 13.71;
Kd = 1.04;

% Create the PID controller object
C = pid(Kp, Ki, Kd);

% Connect the controller and plant in a unity feedback closed loop
T_closed = feedback(C * G, 1);

% Plot the final tuned response
figure;
step(T_closed);
title('Closed-Loop Step Response with Z-N Tuned PID');
grid on;