function slider_smooth_square()
    % === FIGURE SETUP ===
    f = figure('Name', 'Smooth Square Wave Fourier Approximation', ...
               'NumberTitle', 'off', 'Position', [100 100 850 600]);

    % === TIME SETUP ===
    T = 2*pi;
    t = linspace(-T, T, 2000);
    omega0 = 2*pi/T;
    f0 = 1/T;

    % === SMOOTH "SQUARE-LIKE" SIGNAL ===
    x_input = tanh(10 * sin(t));  % smooth alternative to square wave

    % === SLIDER UI ===
    uicontrol('Style', 'text', 'Position', [370 50 100 20], ...
              'String', 'Harmonics');
    slider = uicontrol('Style', 'slider', 'Min', 1, 'Max', 100, ...
                       'Value', 10, 'SliderStep', [1/99 1/99], ...
                       'Position', [300 20 200 30], ...
                       'Callback', @updatePlot);

    % === AXES ===
    ax1 = subplot(2,1,1);
    ax2 = subplot(2,1,2);
    updatePlot();  % Initial plot

    % === CALLBACK FUNCTION ===
    function updatePlot(~, ~)
        N = round(get(slider, 'Value'));  % number of harmonics
        a0 = (1/T) * trapz(t, x_input);   % DC term
        x_approx = a0 * ones(size(t));    % start with DC

        ak = zeros(1, N);
        freqs = [];
        for k = 1:N
            ak(k) = (1/T) * trapz(t, x_input .* exp(-1j * k * omega0 * t));
            x_approx = x_approx + ...
                ak(k) * exp(1j * k * omega0 * t) + ...
                conj(ak(k)) * exp(-1j * k * omega0 * t);
            freqs = [freqs, -k*f0, k*f0];
        end

        mag_spec = repelem(abs(ak), 2);

        % === PLOT TIME DOMAIN ===
        axes(ax1); cla;
        plot(t, x_input, 'k--', 'LineWidth', 1.3); hold on;
        plot(t, real(x_approx), 'r', 'LineWidth', 2);
        title(['Time Domain: Smooth Square with ', num2str(N), ' Harmonics']);
        legend('Input tanh(10·sin(t))', 'Reconstructed'); grid on;
        xlabel('t'); ylabel('x(t)');

        % === PLOT FREQUENCY DOMAIN ===
        axes(ax2); cla;
        stem(freqs, mag_spec, 'filled', 'LineWidth', 1.3);
        title('Frequency Domain: |a_k|');
        xlabel('Frequency (Hz)'); ylabel('|a_k|');
        xlim([-N-2 N+2]*f0); grid on;
    end
end
