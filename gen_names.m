function names = gen_names()
  global NUM_NODES;

  names = cell(1, 2*NUM_NODES);

  for i = 1:(2*NUM_NODES)
    node_num = ceil(i/2);
    if mod(i, 2) == 0 % even is y displacement
      names{i} = sprintf('uy%d', node_num);
    else % odd is x displacement
      names{i} = sprintf('ux%d', node_num);
    end
  end
end
