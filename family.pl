% This is the Prolog version of the family example

child(john,sue).   child(john,sam).   
child(jane,sue).   child(jane,sam).   
child(sue,george).   child(sue,gina). 

male(john).   male(sam).     male(george). 
female(sue).  female(jane).  female(june). 
female(gina).

parent(Y,X) :- child(X,Y).
father(Y,X) :- child(X,Y), male(Y).
opp_sex(X,Y) :- male(X), female(Y). 
opp_sex(Y,X) :- male(X), female(Y). 
grand_father(X,Z) :- father(X,Y), parent(Y,Z).

mother(M,C) :- child(C,M), female(M).

sibling(S1,S2):-child(S1,P),child(S2,P),\+ S1=S2.

person(P) :- child(P,_).
person(P) :- child(_,P).

%all_gendered :- \+ (person(P), \+(male(P);female(P)) ).

ungendered(P) :- person(P),\+male(P),\+female(P).

all_gendered :- \+ ungendered(_).