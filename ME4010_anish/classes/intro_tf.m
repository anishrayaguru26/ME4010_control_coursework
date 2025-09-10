clc; close all; clear;

%tf and ztk

n1 = [1];
d1 = [1 3]; %coeffs of polynomial of denominator, s + 3

n2 = [3, 8];
d2 = [1];

n3 = [5];
d3 = [1, 0];

G = tf(n1, d1);
C = tf(n2, d2);
H = tf(n3, d3);

%series(G,C) combines them in series

%can also be done as G*C

g = series(G,C);

%command feedback - specify the feed forward system- upper, feedback system- lower
%feedback(sys1, sys2, and feedin/feed out, represented as + or -), what is the final value

L = feedback(g,H); %final output is output by input


%3 transfer functions

