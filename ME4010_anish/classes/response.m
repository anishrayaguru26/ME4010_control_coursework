%18th august 2025

% use function step to find step response of a system

%g = tf(1, [1 11 24 K]); - alter the value of K, leads to different outcomes,
%overdamped underdamped 

%overdamped - looks like pure exponential
g = tf(1, [1 11 24 0]);

h = tf(20, [1 1 12 22 39 59 48 38 20]);

g1 = tf(1, [1 2 7 10 7 1]);
%underdamped - looks like oscillating
%g = tf(1, [1 11 24 500]);


%step(g); %checking step response

% Root locus analysis
rlocus(g1);  % Plot root locus
grid on;
title('Root Locus Plot');
