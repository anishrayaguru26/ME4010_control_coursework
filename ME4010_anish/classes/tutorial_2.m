clc; clear all; close all;

fig_filename = 'bode_q1_class19.fig';          % get current figure handle

fig = openfig(fig_filename);  % open the saved figure


axesHandles = findall(fig, 'type', 'axes');


% Get line handles from each axis
linesMag = findall(axesHandles(2), 'type', 'line');
linesPhase = findall(axesHandles(1), 'type', 'line');

% Extract X (frequency) and Y (magnitude, phase)
freqMag = get(linesMag, 'XData');
mag_dB = get(linesMag, 'YData');

freqPhase = get(linesPhase, 'XData');
phase_deg = get(linesPhase, 'YData');

close(gcf);

%guess transfer function is of the form, 1/s * (wn^2/(wn^2 + 2*zeta*wn*s + s^2))


G1 = tf(1,[1 0]);

wn = 5;

tol = 1e-2;
found = false;
for zeta = 0.01:0.01:1
    if found
        break;
    end
    G2 = tf(wn^2, [1 2*zeta*wn wn^2]);
    
    G = series(G1,G2);
    
    %[mag_dB_dash, phase_deg_dash] = bode(G);
    
    [mag, phase] = bode(G, freqMag);
    
    mag_fixed = 20*log10(squeeze(mag));
    phase_fixed = squeeze(phase);

    %fig2 = gcf;
    %axesHandles_dash = findall(fig, 'type', 'axes');
    % linesMag_dash = findall(axesHandles_dash(2), 'type', 'line');
    % linesPhase_dash = findall(axesHandles_dash(1), 'type', 'line');
    % freqMag_dash = get(linesMag_dash, 'XData');
    % mag_dB_dash = get(linesMag_dash, 'YData');
    % freqPhase_dash = get(linesPhase_dash, 'XData');
    % phase_deg_dash = get(linesPhase_dash, 'YData');
    
    Residual_1 = zeros(1,length(mag));
    Residual_2 = zeros(1,length(phase));

    for i = 1:length(mag)
        Residual_1(i) =(mag_fixed(i) - mag(i))^2;
        % disp("--")
        % disp(zeta)
        % disp(Residual_1(i))
        % disp("--")

        if Residual_1(i) < tol
            disp("damping ratio")
            disp(zeta)
            found = true;
            break;
        end
    end

    for i = 1:length(phase)
        Residual_2(i) = (phase_fixed(i) - phase(i))^2;
    end



end