
G = tf([1 10],[1,1]);

bode(G);
grid on
title("Bode plot of G(s)")

guess = tf([1 -1],[1]);

%one function is definitely 1/s

