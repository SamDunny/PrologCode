%note these examples:
% head_tail([1,2,3,4,5,6], H,T). , H is not list (in general), T is list
% head_tail([1], H,T). , T is empty list
% head_tail([], H,T). ,FAILS, H _must_ match at item and there's no
%     items...
head_tail(  [H| T], H, T).

%real predicate is length/2
len([], 0).
len( [ _ | T ] ,Len) :- len(T,LenT), Len is 1+LenT. 


%sum items in a list
sum([],0).
sum( [N | Ns] , Sum ) :- sum( Ns, SumT), Sum is N+SumT.


%adjacent equals?
adjacent_equals( [ H, H | _ ] ).
adjacent_equals( [_| T ]) :- adjacent_equals(T).


%class is_sorted (non-decreasing) order, multiple base cases
is_sorted([]).
is_sorted( [_]).
is_sorted( [A,B|Rest]) :- A =< B, is_sorted( [B|Rest] ).


%elem (real: member) -- test with M both set and unset
elem(E,[E|_]).
elem(E,[_|T]):-elem(E,T).

%concat (real, append)
%append([1,2,3], [4,5,6],C).
%append(A,B,[1,2,3,4,5,6]).
concat( [] , B, B).
concat( [H|T], B, [H | TB]) :- concat(T,B,TB).


%real predicate is reverse
rev([],[]).
rev([H|T], RevTH ) :- rev(T, RevT), append(RevT,[H], RevTH).

%is_palindrome
is_palindrome(L) :- reverse(L,L).

%are_anagrams
are_anagrams([],[]).
are_anagrams( [H|T], Bs) :- 
    append( Xs, [H | Ys], Bs),
    append(Xs,Ys,XYs),
    are_anagrams(T,XYs).

% take
take(0, _ , []).
take(N, [H | T], [H|TakeT]) :- Nm1 is N-1, take(Nm1, T, TakeT).  
%take(N, [H | T], [H|TakeT]) :- take(N-1, T, TakeT). % bad b/c "N-1"

% drop N>=length of list
drop(0, L , L).
drop(N, [ _ | T], DropT) :- Nm1 is N-1, drop(Nm1, T, DropT). 

% subset
subset([],[]).
subset([H|R], [H|S]) :- subset(R,S).
subset([_|R], S) :- subset(R,S).

% permutation
permutation([],[]).
permutation( [H|T] , PHT) :- 
    permutation(T, PT), 
    append(A,B,PT), 
    append(A, [H|B], PHT).

%mergesort

mergesort([],[]).
mergesort([X],[X]).
mergesort(List,SList):-
    length(List,Len),
    Len>=2,
    split(List, L, R ),
    mergesort(L,SL),
    mergesort(R,SR),
    merge_lists(SL,SR,SList).

%splitInefficient
splitInefficient(List,L,R):-
    length(List,Len),
    Half is Len//2,
    take(Half, List,L),
    drop(Half, List, R).

%split
split(List,L,R):-
    length(List,Len),
    Half is Len//2,
    splitN(Half,List,L,R).

splitN(0,L,[],L).
splitN(N,[H|T],[H|LS],R) :- 
    Nm1 is N-1,
    splitN(Nm1,T,LS,R).

%merge
merge_lists(L,[],L).
merge_lists([],L,L).
merge_lists([G|S],[H|T], [G|MRest]) :- G =< H, merge_lists(S, [H|T], MRest).
merge_lists([G|S],[H|T], [H|MRest]) :-  G > H, merge_lists([G|S], T, MRest).

%Can't see entire list?: call following line:
% set_prolog_flag(answer_write_options,[max_depth(0)]).


