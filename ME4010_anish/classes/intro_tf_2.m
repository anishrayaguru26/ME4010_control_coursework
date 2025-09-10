clc; close all; clear;

n1 = [1];
d1 = [1 3]; %coeffs of polynomial of denominator, s + 3

n2 = [3, 8];
d2 = [1];

n3 = [5];
d3 = [1, 0];

g = tf(n1, d1);
h = tf(n2, d2);
p = tf(n3, d3);

t = feedback(g,h);

l = feedback(p,t);

% zeroes, poles, gain
a = zpk([], [-3], 1);

b = zpk([-0.5], [-1, -2], 2);

%step(b)







