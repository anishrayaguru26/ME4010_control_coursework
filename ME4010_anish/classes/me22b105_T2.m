clc; clear; close all;

fig_filename = 'bode_q1.fig';  % path to your saved figure

fig = openfig(fig_filename, 'invisible');   % open without showing
axesHandles = findall(fig, 'Type', 'axes');


axPositions = cell2mat(get(axesHandles, 'Position'));
[~, idx] = sort(axPositions(:,2), 'ascend');
phaseAx = axesHandles(idx(1));
magAx   = axesHandles(idx(2));

magLines   = findall(magAx, 'Type', 'line');
phaseLines = findall(phaseAx, 'Type', 'line');

freqMag = get(magLines(1), 'XData');   freqMag = freqMag(:);
mag_dB  = get(magLines(1), 'YData');   mag_dB  = mag_dB(:);

freqPhase = get(phaseLines(1), 'XData'); freqPhase = freqPhase(:);
phase_deg = get(phaseLines(1), 'YData'); phase_deg = phase_deg(:);

close(fig); 

w_exp = freqMag;  

wn = 5;
zeta_range = 0.01:0.01:1;

G1 = tf(1, [1 0]);   % 1/s
best_error = inf;
best_zeta = NaN;

for zeta = zeta_range
    G2 = tf(wn^2, [1 2*zeta*wn wn^2]);
    G = series(G1, G2);

    [mag_model, phase_model] = bode(G, w_exp);
    mag_model = squeeze(mag_model);
    phase_model = squeeze(phase_model);

    mag_model_dB = 20*log10(mag_model);
    phase_model_deg = phase_model;  % already in degrees

    % Ensure both vectors same length
    if numel(mag_model_dB) ~= numel(mag_dB)
        minLen = min(numel(mag_model_dB), numel(mag_dB));
        mag_model_dB = mag_model_dB(1:minLen);
        mag_dB = mag_dB(1:minLen);
    end

    % Compute total squared error
    err_mag   = mean((mag_model_dB - mag_dB).^2, 'omitnan');
    err_phase = mean((phase_model_deg - phase_deg).^2, 'omitnan');
    total_err = err_mag + 0.1*err_phase;  % weight phase less heavily

    if total_err < best_error
        best_error = total_err;
        best_zeta = zeta;
        best_model = G;
    end
end

fprintf('\nBest damping ratio ζ = %.3f\n', best_zeta);


figure(1);
H1 = tf(1, [1 0]);
H2 = tf(wn^2, [1 2*best_zeta*wn wn^2]);
H = series(H1, H2);
bode(H);
title("after system ID transfer function bode plot") 
disp("Identified system transfer function")
H
openfig(fig_filename);


%% Question 2
%G(s) = 16/(s3+6s2+5s+8)


figure;
G = tf(16, [1 6 5 8]);

bode(G);
[gain_margin, phase_margin] = margin(G);

disp("Gain Margin: ")
disp(gain_margin)
disp("Phase Margin: ")
disp(phase_margin)

closed_loop_sys = feedback(k*G,1);