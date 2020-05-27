% The three-coins problem formulated for the general planner.

initial_state([h,h,t]).

goal_state([h,h,h]).
goal_state([t,t,t]).

% The three possible moves. Each changes one of the coins.
legal_move([X,Y,Z],flip_left,[X1,Y,Z]) :- opposite(X,X1).
legal_move([X,Y,Z],flip_middle,[X,Y1,Z]) :- opposite(Y,Y1).
legal_move([X,Y,Z],flip_right,[X,Y,Z1]) :- opposite(Z,Z1).

opposite(h,t).                   % Flipping a head gives a tail.
opposite(t,h).                   % Flipping a tail gives a head.
