%class(name)
%Defines all the valid types of objects
class(cog).
class(sword).
class(helmet).
%...

%material(<some_material>)
%defines all valid materials
material(wooden).
material(iron).
material(gold).
material(tin).
material(tbd_material).
%...

%instance(<name>,<class>,<material>)
instance(shiny_001,helmet,gold).
instance(excalibur,sword,iron).
instance(bad_idea,cog,wood).
instance(silly_idea,cog,wood).
instance(woops,helmet,owod).%intentional misspelling
%...
%(5) Query for “are there any gold helmets?”.

%q1 :- instance(_,helmet,gold).
q1a(Name) :- instance(Name,helmet,gold).

%(5) Query for “what is Excalibur made of?”

q1b(Mat) :- instance(excalibur, _, Mat).

%(5) Query for “are there any items with different names of the same class and material?”

q1c(Name1,Name2) :- instance(Name1,Class,Material),instance(Name2,Class,Material), \+Name1=Name2.

%d.	(5) Query for “are there any instances made of invalid materials?” 
%  “Valid materials” here means that the material for the instance is a valid, defined material, e.g. the one named “woops”.

q1d(Name) :- instance(Name,_,Mat), \+ material(Mat).

%q2
%a skip a, see c

%b

left(A,B) :- pass_to(A,B), \+ B = 1.
left(A,B) :- pass_to(A,M), \+A=7, left(M,B) .

%c
pass_to(1,2).
pass_to(2,3).
pass_to(3,4).
pass_to(4,5).
pass_to(5,6).
pass_to(6,7).
pass_to(7,1).

%q2 with lists
%a
table(T) :- T= [c1,c2,c3,c4,c5,c6,c7].
%b
lleft(A,B) :- 
    table(T), member(A,T), member(B,T), 
    nth0(NA,T,A),nth0(NB,T,B),
    NA<NB.

llleft(A,B):-
    table(T), member(A,T), member(B,T),
    llleftHelper(T,A,B).


llleftHelper([A|Tail], A, B) :- member(B,Tail).
llleftHelper([_|Tail], A, B) :- llleftHelper(Tail,A,B).
%c
pass_to2(A,B) :-
    table(T), member(A,T), member(B,T), pass_to2_helper(T,A,B).

pass_to2_helper([A,B|_],A,B) .
pass_to2_helper([_|Tail], A, B) :- pass_to2_helper(Tail,A,B).

%q3

color(red). color(blue). color(green). color(yellow).

color(M,B,G,E,H,N,C,P,Co) :-
    color(M),color(B),color(G),
    color(E),color(H),color(N),
    color(C),color(P),color(Co),
    \+ M= B,
    \+ M=G ,
    \+ B=G ,
    \+ G=H ,
    \+ G=E ,
    \+ H=E ,
    \+ H=N ,
    \+ N=C ,
    \+ C=P ,
    M = Co,
    \+ P=Co ,
    \+M = H,
    \+M = E,
    \+M = N,
    \+M = C,
    \+M = P.

%q4
%EXAMPLE tree
node(a,b,c).
node(b,d,e).
node(c,f,nil).
node(d,nil,nil).
node(e,nil,g).
node(f,nil,nil).
node(g,nil,nil).

parent(P,C):-node(P,_,C).
parent(P,C):-node(P,C,_).

descendant(D,A) :- parent(A,D), \+D=nil.
descendant(D,A) :- parent(A,AD), descendant(D,AD).


flatten1( [],[] ).
flatten1( [L|Ls] , LLs ) :- flatten1(Ls, FLs), append( L, FLs, LLs).

flattenAll([],[]).
flattenAll([H|T] , [H| FT]) :- \+ is_list(H), flattenAll(T,FT).
flattenAll([L|T], FLFT ) :- is_list(L),
    flattenAll(L,FL),
    flattenAll(T,FT),
    append(FL,FT,FLFT).

