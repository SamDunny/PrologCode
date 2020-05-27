%:-['nfaEnds1.pl'].
:-['nfa0Any0.pl'].

%general
charInd(C,N) :- sigma(Sig), nth0(N,Sig,C).

accepts(String) :- is_list(String), acceptsHelper([0],String).
accepts(String) :- 
    \+ is_list(String), 
    string_chars(String,LString),
    accepts(LString).

acceptsHelper(Qs, []) :- 
    accept(Accepting),
    member(Q,Accepting),member(Q,Qs).
acceptsHelper(Qs, [C|Cs] ) :- 
    applyTransitions(Qs,C,NextQs),
    acceptsHelper(NextQs,Cs).

applyTransitions([],_,[]).
applyTransitions([Q|Qs],C,NextQs):-
    applyTransitions(Qs,C,Rs),
    delta(Delta),
    nth0(Q,Delta,Nexts),
    applyTransition(Nexts,C,QNexts),
    append(QNexts,Rs,NextQs).


applyTransition([],_,[]).
applyTransition([t(C,NQ)|Ts],C,[NQ|SubNextQ]) :- 
    applyTransition(Ts,C,SubNextQ).
applyTransition([t(D,_)|Ts],C,SubNextQ) :- 
    \+C=D,
    applyTransition(Ts,C,SubNextQ).
