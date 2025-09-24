function dx = CtP(t, x, u, M, m, L, g, b)
    %CtP - Cart to Pendulum dynamics
    D = m*L^2 * (M + m*(1 - cos(x(3))^2));
    dx(1,1) = x(2);
    dx(3,1) = x(4);
    dx(2,1) = (-(m*L)^2 * g * cos(x(3)) * sin(x(3)) + (m*L)^2 * sin(x(3)) * cos(x(3)) * x(4)^2 + (m*L)^2 * u) - b*x(2)/D;
    dx(4,1) = ( (m+M)*m* g *L* sin(x(3)) - (m*L)^2 * sin(x(4)) * cos(x(3)) * x(4)^2 - m*L*cos(x(3)) * u + b*x(2)*m*L*cos(x(3)))/D;

end