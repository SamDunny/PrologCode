sigma(['0','1']).

%q0, initial state (at 0 index is start)

% delta: (Q x Sigma)-> Q
delta(Delta) :- Delta =
    [ [2,3],
      [2,1],
      [2,1],
      [3,3] ].

accept(Accepting) :- Accepting=[2].


