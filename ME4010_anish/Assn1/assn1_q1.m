G = zpk([-5], [-2, -4, -7, -9],[1]);

rlocus(G);
zeta = 0.7;
ang = 180 - arctand(zeta);

r = 100;
