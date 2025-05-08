% Time domain
t = linspace(-5, 5, 1000);
dt = t(2) - t(1);

% Original signal: rectangular pulse of width 1
x = double(abs(t) <= 0.5);

% Time-shifted signal: shift by t0
t0 = 2;
x_shifted = double(abs(t - t0) <= 0.5);

% Frequency domain setup
f = fftshift((-length(t)/2:length(t)/2-1) / (length(t)*dt));

% Fourier Transforms
X = fftshift(fft(x));
X_shifted = fftshift(fft(x_shifted));

% Magnitude and Phase
mag_X = abs(X);
mag_X_shifted = abs(X_shifted);

phase_X = angle(X);
phase_X_shifted = angle(X_shifted);

% Plot magnitude spectrum
figure;
subplot(2,2,1);
plot(f, mag_X, 'b', f, mag_X_shifted, 'r--');
title('Magnitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
legend('Original', 'Shifted');
grid on;

% Plot phase spectrum
subplot(2,2,2);
plot(f, phase_X, 'b', f, phase_X_shifted, 'r--');
title('Phase Spectrum');
xlabel('Frequency (Hz)');
ylabel('Phase (rad)');
legend('Original', 'Shifted');
grid on;

% Plot time-domain signals
subplot(2,2,[3 4]);
plot(t, x, 'b', t, x_shifted, 'r--');
title('Time-Domain Signals');
xlabel('Time (s)');
ylabel('Amplitude');
legend('x(t)', 'x(t - t_0)');
grid on;

