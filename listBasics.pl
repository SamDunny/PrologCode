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
