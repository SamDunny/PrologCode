sigma(['0','1']).

%q0, initial state (at 0 index is start)

% delta: (Q x Sigma)-> Q
delta(Delta) :- Delta =
    [ [0, 1],
      [0, 1] ].

accept(Accepting) :- Accepting=[1].


