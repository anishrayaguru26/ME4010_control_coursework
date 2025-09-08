clc; clear; close all;
%%
g=zpk([],[-1 -2 -10],1);
figure(1); hold on
rlocus(g);
pause(1);
zeta = 0.354;
ang_z = 180-acosd(zeta);
r=40;
plot([0,r*cosd(ang_z)],[0,r*sind(ang_z)],'--'); % plot a line in the 2nd quadrant indicating constant damping ratio
figure(1); hold on;
set(findall(gca, 'Type', 'Line'),'LineWidth',3);

%%
zer = -5;
c=zpk([zer],[],1);
rlocus(c*g)
set(findall(gca, 'Type', 'Line'),'LineWidth',3);
%%
% figure(2); hold on;
step(feedback(162*g,1),10);
% step(feedback(162*c*g,1),10);

set(findall(gca, 'Type', 'Line'),'LineWidth',3);
