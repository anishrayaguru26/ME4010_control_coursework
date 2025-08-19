syms s;
%initializing P1 as both a symbolic variable and an array of coefficients
P1_poly = s^6 + 7*s^5 + 2*s^4 + 9*s^3 + 10*s^2 + 12*s +15; P1 = [1 7 2 9 10 12 15];

%initializing arrays into which the real(rootx) and imaginary(rooty) parts of all the roots are appended
rootx = []; rooty = [];

%initializing array into which the unstable roots are appended
uns = [];

%initializing G2
G2 = tf(1, P1);

%finding roots of P1
root = roots(P1);

disp('**The following are the roots of P1:');
disp(root);

%setting a check variable for looking at unstable condition. check == 1 signifies stable system
i = 1; check = 1;

while i <= length(root)
    %appending roots
    rootx(end + 1) = real(root(i)); rooty(end + 1) = imag(root(i));

    %checking for positive real parts of the roots
    if real(root(i)) > 0
        %if there is a positive real part then check becomes 0 which signifies an unstable system
        check = 0;
        uns(end + 1) = root(i);
    end
    i = i + 1;
end

%displaying answer based on check value
if check == 1
    disp('Part 2 answer: Stable system');
elseif check == 0
    disp('Part 2 answer: Unstable system');
end

disp(uns);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

g1_mul = 1; i = 1;

%going through list of unstable roots and updating g1_mul by multiplying it with the factors corresponding to the unstable roots
while i <= length(uns)
    %we see here that g1_mul is symbolic
    g1_mul = g1_mul * (s - uns(i));
    i = i + 1;
end

%setting a variable g2_mul as the polynomial corresponding to g1_mul
g2_mul = sym2poly(g1_mul);

%G1 is initialized here as  a transfer function
G1 = tf(g2_mul, P1);

%we divide G1 by its steady state value so that it may settle at 1
G1 = G1/dcgain(G1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%plotting the graphs

subplot(3,1,1);
scatter(rootx, rooty, "filled");
grid on; xlabel("Re(z)"); ylabel("Im(z)"); title('Part 1 Plot');

subplot(3,1,2);
step(G2); grid on; legend('Part 3 Plot (G2 step response)');

subplot(3,1,3);
step(G1); grid on; legend('Part 4 Plot (G1 step response)');

disp('---------------------------------------------------------------------------------------------------------------------------------------------------------');
disp('**The following is the transfer function G1:')
G1
disp('**And its inverse laplace:');
[n,d] = tfdata(G1); %here we get the numerator and denominator coefficients for G1 
%that we convert to a symbolic expression in the next line in order to perform ilaplace
pretty(ilaplace(poly2sym(cell2mat(n),s)/poly2sym(cell2mat(d),s)));

disp('---------------------------------------------------------------------------------------------------------------------------------------------------------');
disp('**The following is the transfer function G2:')
G2
disp('**And its inverse laplace:');
pretty(ilaplace(1/P1_poly)); %since G1 is 1/P1