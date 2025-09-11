clc; clear; close all;

a = [-1 1 0; 0 -1 0; 0 0 2];
b = [0; 4; 3];


%ctrb - controllability matrix
z = ctrb(a,b);

if rank(z) == size(a,1)
    disp('System is controllable');
else
    disp('System is not controllable');
end
