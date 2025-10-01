function dx = CtP (x,M,m,L,g,d,u)

  Sx= sin(x(3));
  Cx = cos(x(3));
  D = m*L*L*(M+m*(1-Cx^2));

  dx(1,1) = x(2);
  dx(2,1) = (1/D)*(-m^2*L^2*g*Cx*Sx + m*L^2*(m*L*x(4)^2*Sx-d*x(2)))+m*L^2/D*u;
  dx(3,1) = x(4);
  dx(4,1) = (1/D)*((m+M)*m*g*L*Sx - m*L*Cx*(m*L*x(4)^2*Sx-d*x(2))) - m*L*Cx/D*u;

end

% function dx = CtP(~,x,M,m,L,g,d,u)
%     % Precompute trig
%     Sx = sin(x(3));
%     Cx = cos(x(3));

%     % Common terms
%     D  = m*L^2*(M + m*(1 - Cx^2));
%     ML = m*L;

%     % State derivatives
%     dx = zeros(4,1);
%     dx(1) = x(2);
%     dx(2) = ( -m^2*L^2*g*Cx*Sx + m*L^2*(ML*x(4)^2*Sx - d*x(2)) + m*L^2*u ) / D;
%     dx(3) = x(4);
%     dx(4) = ( (m+M)*m*g*L*Sx - ML*Cx*(ML*x(4)^2*Sx - d*x(2)) - ML*Cx*u ) / D;
% end




% function dx = CtP(t, x, u, M, m, L, g, b)
%     %CtP - Cart to Pendulum dynamics
%     D = m*L^2 * (M + m*(1 - cos(x(3))^2));
%     dx(1,1) = x(2);
%     dx(3,1) = x(4);
%     dx(2,1) = (-(m*L)^2 * g * cos(x(3)) * sin(x(3)) + (m*L)^2 * sin(x(3)) * cos(x(3)) * x(4)^2 + (m*L)^2 * u) - b*x(2)/D;
%     dx(4,1) = ( (m+M)*m* g *L* sin(x(3)) - (m*L)^2 * sin(x(4)) * cos(x(3)) * x(4)^2 - m*L*cos(x(3)) * u + b*x(2)*m*L*cos(x(3)))/D;

% end