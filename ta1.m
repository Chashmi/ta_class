%-----------------------------------------------------impulsive input
% Define impulse signal: δ[n]
n = 0:10;  % Just enough range
x = (n == 0);  % delta[n]

% Define the system: y[n] = x[n] + x[n-1] + x[n-2]
% Implement with convolution (h[n] = [1 1 1])
h = [1 1 1];
y = conv(x, h);
n_y = 0:length(y)-1;

% Plot
figure;
subplot(3,1,1)
stem(n, x, 'filled'); title('x[n] = δ[n]'); xlabel('n'); ylabel('x[n]'); grid on;

subplot(3,1,2)
stem(0:length(h)-1, h, 'filled'); title('h[n] = Impulse Response'); xlabel('n'); ylabel('h[n]'); grid on;

subplot(3,1,3)
stem(n_y, y, 'filled'); title('y[n] = x[n] * h[n]'); xlabel('n'); ylabel('y[n]'); grid on;


%-----------------------------------------------------impulsive input with anim
% Impulse input
x = [1 zeros(1, 10)];  % δ[n]
n_x = 0:length(x)-1;

% System: y[n] = x[n] + x[n-1] + x[n-2] → h[n] = [1 1 1]
h = [1 1 1];
n_h = 0:length(h)-1;

% Time indices for output
n_y = n_x(1) + n_h(1) : n_x(end) + n_h(end);
y = zeros(1, length(n_y));

% Animation
figure;
for n = 0 : length(n_y)-1
    % Flip and shift h[n-k]
    h_shifted = zeros(1, length(x));
    for k = 1:length(x)
        index = n - (k-1) + 1;
        if index >= 1 && index <= length(h)
            h_shifted(k) = h(index);
        end
    end

    % Multiply and sum
    product = x .* h_shifted;
    y(n+1) = sum(product);

    % Plot
    clf;
    subplot(3,1,1);
    stem(n_x, x, 'filled'); title('x[n] = δ[n]'); xlabel('n'); grid on; ylim([0 1.2]);

    subplot(3,1,2);
    stem(n_x, h_shifted, 'filled'); title(['Shifted h[n-k], step ', num2str(n)]); xlabel('n'); grid on; ylim([0 1.2]);

    subplot(3,1,3);
    stem(n_y, y, 'filled'); title('y[n] = x[n] * h[n]'); xlabel('n'); grid on; ylim([0 max(y)+0.5]);

    pause(0.3);  % delay between frames
end


%-----------------------------------------------------step input
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


%-----------------------------------------------------step input with anim
% Signals
x = [1 1 1 1];             % x[n] = u[n] - u[n-4]
n_x = 0:length(x)-1;

h = (1/2).^(0:20);         % h[n] = (1/2)^n * u[n]
n_h = 0:length(h)-1;

% Time range for convolution output
n_y = n_x(1) + n_h(1) : n_x(end) + n_h(end);
y = zeros(1, length(n_y));

% Animation setup
figure;
for n = 0 : length(n_y)-1
    % Flipped and shifted h[-k+n] or h[n-k]
    h_shifted = zeros(1, length(n_x));
    for k = 1:length(n_x)
        index = n - (k-1) + 1;
        if index >= 1 && index <= length(h)
            h_shifted(k) = h(index);
        else
            h_shifted(k) = 0;
        end
    end

    % Element-wise multiplication and sum
    product = x .* h_shifted;
    y(n+1) = sum(product);

    % Plot
    clf
    subplot(3,1,1)
    stem(n_x, x, 'filled'); title('x[n]'); ylim([0 1.2]);
    grid on;

    subplot(3,1,2)
    stem(n_x, h_shifted, 'filled'); title(['h[n - k] (shifted, step ', num2str(n), ')']); ylim([0 1.2]);
    grid on;

    subplot(3,1,3)
    stem(n_y, y, 'filled'); title('y[n] = x[n] * h[n]'); ylim([0 max(y)+0.5]);
    grid on;

    pause(0.3);  % pause between frames
end


