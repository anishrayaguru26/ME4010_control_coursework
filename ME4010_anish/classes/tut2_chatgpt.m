clc; clear; close all;

fig_filename = 'bode_q1_class19.fig';
fig = openfig(fig_filename);
axesHandles = findall(fig, 'type', 'axes');

% Extract line data
linesMag = findall(axesHandles(2), 'type', 'line');
linesPhase = findall(axesHandles(1), 'type', 'line');
freqMag = get(linesMag, 'XData');
mag_dB = get(linesMag, 'YData');
freqPhase = get(linesPhase, 'XData');
phase_deg = get(linesPhase, 'YData');
close(fig);

% Assume transfer function form: (1/s) * (wn^2 / (s^2 + 2*zeta*wn*s + wn^2))
G1 = tf(1, [1 0]);
wn = 5;
tol = 10;  % loosened a bit for numerical stability

best_zeta = NaN;
min_error = Inf;

for zeta = 0.01:0.01:1
    G2 = tf(wn^2, [1 2*zeta*wn wn^2]);
    G = series(G1, G2);

    % Evaluate Bode magnitude and phase at the same frequencies as your data
    [mag_lin, phase_rad] = bode(G, freqMag);
    mag_lin = squeeze(mag_lin);
    phase_deg_model = squeeze(phase_rad) * (180/pi);

    % Convert linear mag → dB
    mag_dB_model = 20 * log10(mag_lin);

    % Compute residuals
    R1 = mean((mag_dB_model - mag_dB).^2);
    R2 = mean((phase_deg_model - phase_deg).^2);
    total_residual = R1 + R2;

    if total_residual < min_error
        min_error = total_residual;
        best_zeta = zeta;
    end
end

disp('Best-fit damping ratio (zeta):');
disp(best_zeta);

%disp(min_error);
