% Time-domain setup
T = 2;                             % Signal period
t = linspace(-T, T, 1000);         % Time vector
x = 1 - abs(t);                    % Triangular waveform (centered at 0)
x(t <= -1 | t >= 1) = 0;           % Cutoff outside [-1, 1] for periodic window

% Fourier Series coefficients (numerical approximation)
N = 20;                            % Number of harmonics
k_vals = -N:N;                     % Harmonic indices
a_k = zeros(size(k_vals));        % Coefficient array
w0 = 2 * pi / T;                   % Fundamental angular frequency

for i = 1:length(k_vals)
    k = k_vals(i);
    integrand = x .* exp(-1j * k * w0 * t);  % Integrand for a_k
    a_k(i) = (1/T) * trapz(t, integrand);    % Numerical integration
end

% Plot time-domain signal
figure;
subplot(2,1,1);
plot(t, x, 'LineWidth', 2);
title('Time Domain: Real and Even Signal');
xlabel('t'); ylabel('x(t)');
grid on;

% Plot real part of Fourier coefficients
subplot(2,1,2);
stem(k_vals, real(a_k), 'filled');
title('Fourier Series Coefficients a_k (Real Values)');
xlabel('k'); ylabel('Real(a_k)');
grid on;

