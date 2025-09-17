function dx=smd(x,m,k,c,u)
%spring mass damper system-

%time appended as rows, and states as columns- since IC was [x0 xdot0]
dx(1,1) = x(2); % dx(1,1) - x1 dot
dx(2,1) = (-k/m)*x(1) + (-c/m)*x(2) + u;%dx(2,1) - x2dot 

%ie dx is Xdot, or derivative of state vector

end


