strictly_increasing(A,B,C) :- A =< B, B=<C.

quotient_remainder(A,B,Q,R) :- Q is div(A,B), R is mod(A,B).

qr(A,B,Q,R) :- Q is A//B, R is A-Q*B.

square(N,SQ) :- SQ is N*N. 

square_root(S,Root) :- Root is sqrt(S).

euclidean_dist(X1,Y1,X2,Y2,D) :- Xdiff is X1-X2, Ydiff is Y1-Y2,
                    D is sqrt( Xdiff*Xdiff + Ydiff*Ydiff).

euclidean_dist( pt(X1,Y1),pt(X2,Y2), D) :- euclidean_dist(X1,Y1,X2,Y2,D).

%N is input, F is output
factorial(0,1).
factorial(N,F):-N>=1,Nm1 is N-1, factorial(Nm1,Fm1), F is N*Fm1.

