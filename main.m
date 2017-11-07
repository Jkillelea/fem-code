clear;
clc;
close all;
format compact;

global NUM_NODES;
NUM_NODES = 0;

L = 30;
E = 3000;

n1 = make_node([0 L*sind(30)], [0 0]); % [position], [free axes], [forces]
n2 = make_node([0 0], [0 0]);
n3 = make_node([L + L*cosd(60)/(2*sind(60)), 0], [0, 0]);
n4 = make_node([L, L*sind(30)], [1 1], [0, -100]);

nodes = [n1, n2, n3, n4];

b1 = connect(n1, n4, E, 2); % nodes, modulus of elasticity, area
b2 = connect(n2, n4, E, 4);
b3 = connect(n3, n4, E, 3);

bars = [b1, b2, b3];

% The below is the case from lecture. I've checked and this is correct. %
% The only errors I found were machine floating-point errors on the order to 10^-16 %
% They did not affect the final answer %
% n1 = make_node([0, 0], [0, 0,]);
% n2 = make_node([10, 0], [1, 0]);
% n3 = make_node([10, 10], [1, 1], [2, 1]);
% b1 = connect(n1, n2, 50, 2);
% b2 = connect(n2, n3, 50, 1);
% b3 = connect(n1, n3, 100, 2*sqrt(2));
% nodes = [n1, n2, n3];
% bars = [b1, b2, b3];

K      = zeros(2*NUM_NODES);    % stiffness matrix
forces = zeros(2*NUM_NODES, 1); % external forces
dofs   = zeros(2*NUM_NODES, 1); % free node axes
names  = gen_names; % a list containing ['ux1', 'uy1', 'ux2' ...]

for b = bars
  K = K + augment(b);
end

% collect forces and free axes into vectors
for n = nodes
  num = n.global_num;
  forces((2*num-1):2*num) = n.force';
  dofs((2*num-1):2*num)   = n.fixed';
end

disp('=== Stiffness Matrix ===');
disp(K);
disp('=== Forces ===');
disp(forces');
disp('=== Degrees of Freedom ===');
disp(dofs');
disp('===');

% figure; hold on; grid on; axis equal;
% for b = bars
%   plot([b.x(1), b.x(2)], [b.y(1), b.y(2)], 'linewidth', 2);
%   scatter([b.x(1), b.x(2)], [b.y(1), b.y(2)], 'ro');
% end

K = K(dofs == 1, dofs == 1); % knock out the ros and cols where nodes are fixed
forces = forces(dofs == 1);

disp('=== Reduced Stiffness Matrix ===');
disp(K);
disp('=== Reduced Forces ===');
disp(forces');

u = K\forces; % solve reduced system for displacements

free_node_names = names(dofs == 1);
for i = 1:length(u)
  name = free_node_names{i};
  fprintf('%s: %f\n', name, u(i));
end
