% Time setup
T = 2;                    % Period
t = linspace(-T, T, 1000);  % Time vector over multiple periods
f0 = 1/T;

% Build one period of half-wave symmetric signal
t_period = linspace(0, T, 500);
x_one_period = [linspace(1, -1, 250), linspace(-1, 1, 250)];  % Triangle up/down

% Repeat it to make it periodic
x_full = repmat(x_one_period, 1, length(t) / length(x_one_period));
x_full = x_full(1:length(t));  % Trim to match time vector

% Plotting
figure;
plot(t, x_full, 'LineWidth', 2);
xline(0, '--k', 't = 0');
xline(T/2, '--r', 't = T/2');
xline(T, '--k', 't = T');
title('Periodic Signal with Half-Wave Symmetry:  x(t + T/2) = -x(t)');
xlabel('t'); ylabel('x(t)');
grid on;

% Add annotation to explain symmetry
text(T/2 + 0.1, 0.8, 'Half-period flip → negation');
text(0.1, 0.8, 'x(t)');
text(T/2 + 0.1, -0.8, '-x(t)');

