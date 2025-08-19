% Parameters
Fs = 1000;              % Sampling frequency (Hz)
T = 1/Fs;               % Sampling period
L = 1000;               % Length of signal
t = (0:L-1)*T;          % Time vector

% Define the signal: f(t) = sin(t)
%f = exp(-t) .* sin(t);
f = sin(t);

% Compute DFT manually using the formula: X(k) = Σ(n=0 to N-1) x(n) * exp(-j*2π*k*n/N)
Y = zeros(1, L);
for k = 0:L-1
    for n = 0:L-1
        Y(k+1) = Y(k+1) + f(n+1) * exp(-1j * 2 * pi * k * n / L);
    end
end

% Compute magnitude of DFT
P2 = abs(Y/L);          % Two-sided spectrum
P1 = P2(1:L/2+1);       % Single-sided spectrum
P1(2:end-1) = 2*P1(2:end-1);

% Frequency domain
f_axis = Fs*(0:(L/2))/L;

% Plot time domain
figure;
subplot(2,1,1);
plot(t, f)
title('f(t) = sin(t)')
xlabel('Time (s)')
ylabel('Amplitude')

% Plot frequency domain
subplot(2,1,2);
plot(f_axis, P1)
title('Single-Sided Amplitude Spectrum of f(t)')
xlabel('Frequency (Hz)')
ylabel('|F(f)|')
xlim([0 5])    % Focus on low frequencies to see the peak at 1/(2π) ≈ 0.159 Hz
grid on

% Save the plot
saveas(gcf, 'fourier_transform_result.png')
