close all; clear all; clc;
pos_c = [1 1]';
pos   = [2 2]';

delta_pos = pos_c - pos;

psi_c = pi+pi/4;

R = [cos(psi_c) -sin(psi_c);
     sin(psi_c)  cos(psi_c)];


delta_pos_r = R' * delta_pos;

%% Plot 

hold on; grid on;

plot([0 delta_pos(1)], [0 delta_pos(2)], 'b');

plot([0 delta_pos_r(1)], [0 delta_pos_r(2)], 'r');

plot([])