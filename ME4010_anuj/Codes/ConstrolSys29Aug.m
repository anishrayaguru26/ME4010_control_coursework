clc; close all;

%syms s;
%system = 1/(s*(s+1)*(s+2));
%sysor = tf([1],[1 3 2 0]);
%figure(1)
%hold on;
%rlocus(sysor);
%for k = 0.01:0.01:10
%den = [1 3 2 k];
%systf = tf([1],den);
%P = complex(roots(den));
%grid on;
%plot(P,'o');
%pause(0.1);
%end
figure(1);
hold on;
%for sigma = (-4):0.01:(-3)
%    plot(sigma,(-1)*((sigma^2 + 3*sigma + 2)/(sigma^2 + 7*sigma + 12)), '-o');
%end
for sigma = (-2):0.01:(-1)
    plot(sigma,(-1)*((sigma^2 + 3*sigma + 2)/(sigma^2 + 7*sigma + 12)), '-o');
end