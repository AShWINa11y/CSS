s = tf('s');
G =(0.3726/((s*(1+0.0147*s)*(1+0.5505*s)) + 0.85698));

% Get the raw time and amplitude data from the step response
[y, t] = step(G);
% 1. Process Gain (K)
K = y(end);

% 2. Find the steepest slope (inflection point)
dydt = diff(y) ./ diff(t);
[max_slope, idx] = max(dydt);
t_inf = t(idx);
y_inf = y(idx);

% 3. Calculate Dead Time (L) - where tangent hits y=0
L = t_inf - (y_inf / max_slope);
if L < 0
    L = 0; % Safety check: Dead time cannot be negative
end

% 4. Calculate Time Constant (T) - where tangent hits steady-state K
t_cross = t_inf + ((K - y_inf) / max_slope);
T = t_cross - L;

% Print the final values to the command window
fprintf('\n--- Process Reaction Curve Values ---\n');
fprintf('Process Gain (K): %.4f\n', K);
fprintf('Dead Time (L): %.4f\n', L);
fprintf('Time Constant (T): %.4f\n', T);

% Plotting (keeping your exact requested scale)
figure;
plot(t, y, 'b', 'LineWidth', 1.5); hold on;
y_tangent = max_slope * (t - t_inf) + y_inf; % Equation of tangent line
plot(t, y_tangent, 'r--', 'LineWidth', 1.5); % Plot tangent line
yline(K, 'k:', 'LineWidth', 1); % Plot steady state line
ylim([0 1.2]); % Keeping your exact scale
xlim([0, t(end)]);
grid on;
title('Process Reaction Curve with Tangent Line');
legend('Step Response', 'Tangent Line', 'Steady State (K)', 'Location', 'best');