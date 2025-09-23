clc; clear; close all;

% Example transfer function
G = tf(1, [1 3 2 0]);

% Root locus
rlocus(G); grid on; hold on;

% Add damping ratio lines (0 < zeta <= 1 for reference)
zeta = [0.2 0.5 0.7 1];
sgrid(zeta, []); 

% Shade overdamped region (zeta > 1 => real negative axis)
x_limits = xlim;   % get x-axis limits
y_limits = ylim;   % get y-axis limits

% Draw a shaded patch on the negative real axis (below x=0, y≈0)
fill([x_limits(1) 0 0 x_limits(1)], ...
     [y_limits(1) y_limits(1) y_limits(2) y_limits(2)], ...
     [0.9 0.9 0.9], ...   % light gray color
     'FaceAlpha',0.3, 'EdgeColor','none');

% Add label
text(x_limits(1)*0.7, 0.1, '\zeta > 1 region', ...
     'Color','k','FontSize',10,'FontWeight','bold');
