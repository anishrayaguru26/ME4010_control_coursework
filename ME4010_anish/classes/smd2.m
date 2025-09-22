function dx=smd2(x,A,B,u)
%spring mass damper system-
%dx = zeros(2,1); %preallocating dx
%time appended as rows, and states as columns- since IC was [x0 xdot0]
dx = A*x + B*u;

%ie dx is Xdot, or derivative of state vector

end

