%ME22B105_T1
%Anish Rayaguru
%ME4010 control systems


clc;
clear;
close all;

%defining the transfer function
g1 = tf(1, [1 2 7 10 7 1]);


%to create rootlocus plot - exercise 1 part 2
rlocus(g1);



[r,k] = rlocus(g1);

%plotting the poles of g1- exercise 2 part 1
poles = r(:,1);
plot(poles, 'o');
grid on;

%identifying the stability of the system - exercise 2 part 2
stable = 0;

%to detect if the system is stable or unstable
for i = 1:length(r(:,1))
    if real(r(i,1)) <= 0
        stable = 1;
    end
    if real(r(i,1)) > 0
        stable = 0;
        break;
    end
end

if stable == 1
    disp('The system is stable');
else
    disp('The system is unstable');
end

%step response of the system - exercise 2 part 3
step(g1);
%from step plot you can conclude that the system is stable

g2 = tf([1 -3], [1 2 7 10 7 1]); %to add a zero at 3

rlocus(g2);






