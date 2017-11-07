function Ka = augment(bar)
  global NUM_NODES;

  Ka = zeros(2*NUM_NODES);

  % something like node 1 and node 4
  n1 = bar.nodes(1);
  n2 = bar.nodes(2);
  Kg = bar.Kg;

  sec1 = Kg(1:2, 1:2);
  sec2 = Kg(3:4, 1:2);
  sec3 = Kg(1:2, 3:4);
  sec4 = Kg(3:4, 3:4);

  Ka((2*n1-1):2*n1, (2*n1-1):2*n1) = sec1;
  Ka((2*n2-1):2*n2, (2*n1-1):2*n1) = sec2;
  Ka((2*n1-1):2*n1, (2*n2-1):2*n2) = sec3;
  Ka((2*n2-1):2*n2, (2*n2-1):2*n2) = sec4;
end
