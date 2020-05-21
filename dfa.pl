sigma(['0','1']).

%q0, initial state (at 0 index is start)

% delta: (Q x Sigma)-> Q
delta(Delta) :- Delta =
    [ [0, 1],
      [0, 1] ].

accept(Accepting) :- Accepting=[1].

%general
charInd(C,N) :- sigma(Sig), nth0(N,Sig,C).

accepts(String) :- acceptsHelper(0,String).


acceptsHelper(State, []) :- 
    accept(Accepting),
    member(State,Accepting).
acceptsHelper(StateN, [C|Cs] ) :-
    delta(Delta), 
    nth0(StateN,Delta,Nexts),
    charInd(C,N),
    nth0(N,Nexts,NextQ),
    acceptsHelper(N,Cs).
