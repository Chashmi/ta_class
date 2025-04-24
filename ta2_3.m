% === SETUP ===
T = 2*pi;                       % Period
t = linspace(-T, T, 1000);      % Time vector
omega0 = 2*pi/T;
f0 = 1/T;                       % Fundamental frequency

% === TIME DOMAIN SIGNAL ===
x_true = square(t);             % Original square wave
A1 = 4/pi;                      % First harmonic coefficient
x_approx = A1 * cos(omega0 * t);  % Only a1 + a-1 (cosine form), a0 = 0

% === FREQUENCY DOMAIN PLOT ===
frequencies = [-f0 0 f0];
magnitudes = [A1/2 0 A1/2];     % a1 and a-1 have magnitude 0.5 * A1 (from Euler expansion)

% === PLOT BOTH ===
figure;

% 1. TIME DOMAIN
subplot(2,1,1);
plot(t, x_true, 'k--', 'LineWidth', 1.5); hold on;
plot(t, x_approx, 'r', 'LineWidth', 2);
title('Time Domain: Square Wave vs Approximation');
legend('Original Square', 'a_0 + a_{\pm1}');
xlabel('t'); ylabel('x(t)'); grid on;

% 2. FREQUENCY DOMAIN
subplot(2,1,2);
stem(frequencies, magnitudes, 'filled', 'LineWidth', 2);
title('Frequency Domain: 3 Harmonics Only');
xlabel('Frequency (Hz)'); ylabel('|a_k|'); grid on;
xlim([-2*f0 2*f0]);  % Show enough range

