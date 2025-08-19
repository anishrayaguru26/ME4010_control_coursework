syms x1 x2 x3 x4
syms F m M l g
f1 = x2; f3 = x4;

n2 = F * cos(x3) - m * l * (x4 ^ 2) * sin(x3) * cos(x3) + (M + m) * g * sin(x3) - g * sin(x3) * (M + m * sin(x3)^2);
d2 = cos(x3) * (M + m * ((sin(x3))^2));

n4 = F * cos(x3) - m * l * (x4 ^ 2) * sin(x3) * cos(x3) + (M + m) * g * sin(x3);
d4 = l * (M + m * ((sin(x3))^2));

f2 = n2 / d2; f4 = n4 / d4;

J = [diff(f1, x1) diff(f1, x2) diff(f1, x3) diff(f1, x4);
    diff(f2, x1) diff(f2, x2) diff(f2, x3) diff(f2, x4);
    diff(f3, x1) diff(f3, x2) diff(f3, x3) diff(f3, x4);
    diff(f4, x1) diff(f4, x2) diff(f4, x3) diff(f4, x4)];

J1 = vpa(subs(J, [x1 x2 x3 x4], [0 0 0 0]), 2);
J2 = vpa(subs(J, [x1 x2 x3 x4], [0 0 pi 0]), 2);