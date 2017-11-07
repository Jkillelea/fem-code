function n = make_node(coord, fixed, force)
  global NUM_NODES;
  NUM_NODES = NUM_NODES + 1;

  if nargin < 3
    force = [0, 0];
  end

  n = struct( 'x',          coord(1), ...
              'y',          coord(2), ...
              'fixed',      fixed,    ...
              'force',      force,    ...
              'global_num', NUM_NODES);
end
