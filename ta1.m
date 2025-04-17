% x[n] = u[n] - u[n-4] => rectangular pulse from n = 0 to 3
x = [1 1 1 1];

% h[n] = (1/2)^n * u[n] => decaying exponential
n_h = 0:20;
h = (1/2).^n_h;

% Convolve
y = conv(x, h);
n_y = 0:length(y)-1;

% Plot
subplot(3,1,1)
stem(0:length(x)-1, x, 'filled');
title('x[n] = u[n] - u[n-4]');
xlabel('n'); ylabel('x[n]'); grid on;

subplot(3,1,2)
stem(n_h, h, 'filled');
title('h[n] = (1/2)^n u[n]');
xlabel('n'); ylabel('h[n]'); grid on;

subplot(3,1,3)
stem(n_y, y, 'filled');
title('y[n] = x[n] * h[n]');
xlabel('n'); ylabel('y[n]'); grid on;
