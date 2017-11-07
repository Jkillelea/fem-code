function member = connect(n1, n2, E, A)
  global NUM_NODES;
  x1    = n1.x;
  x2    = n2.x;
  y1    = n1.y;
  y2    = n2.y;
  nn1   = n1.global_num;
  nn2   = n2.global_num;

  L     = norm([x2 - x1, y2 - y1]);
  theta = atan((y2 - y1)/(x2 - x1));

  % displacement transformation matrix
  T = [cos(theta) sin(theta) 0           0;
      -sin(theta) cos(theta) 0           0;
            0      0         cos(theta) sin(theta);
            0      0        -sin(theta) cos(theta)];


  % local stiffness matrix
  Kl = (E*A/L)*[ 1  0 -1  0;
                 0  0  0  0;
                -1  0  1  0;
                 0  0  0  0 ];

  Kg = T' * Kl * T; % global stiffness matrix

  member = struct( ...
  'x', [x1, x2],   ...
  'y', [y1, y2],   ...
  'E', E,          ...
  'A', A,          ...
  'L', L,          ...
  'theta', theta,  ...
  'Kg', Kg,         ...
  'nodes', [nn1, nn2] ...
  );
end
