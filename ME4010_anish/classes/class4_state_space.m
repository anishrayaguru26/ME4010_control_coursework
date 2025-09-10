clc; clear; close all;

a = [-2 0; 0 -5];
b = [1; 3];


%ctrb - controllability matrix
z = ctrb(a,b);

