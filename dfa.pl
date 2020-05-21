%:-['dfaEnds1.pl'].
:-['dfa0Any0.pl'].

%general
charInd(C,N) :- sigma(Sig), nth0(N,Sig,C).

accepts(String) :- is_list(String), acceptsHelper(0,String).
accepts(String) :- 
    \+ is_list(String), 
    string_chars(String,LString),
    accepts(LString).

acceptsHelper(State, []) :- 
    accept(Accepting),
    member(State,Accepting).
acceptsHelper(StateN, [C|Cs] ) :-
    delta(Delta), 
    nth0(StateN,Delta,Nexts),
    charInd(C,N),
    nth0(N,Nexts,NextQ),
    acceptsHelper(NextQ,Cs).
