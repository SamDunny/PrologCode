% This is the monkey and bananas as a planning problem.

% The bananas, monkey, and box are at different locations.
% The monkey is not on the box and has no bananas.
initial_state([loc1,loc2,loc3,n,n]).

% The goal is any state where the monkey has the bananas.
goal_state([_,_,_,_,y]). 

% Climbing on the box causes the monkey to be on the box.
legal_move([B,M,M,n,H],climb_on,[B,M,M,y,H]).
% Climbing off the box causes the monkey to be off the box. 
legal_move([B,M,M,y,H],climb_off,[B,M,M,n,H]).
% Grabbing the bananas causes the monkey to have the bananas.
legal_move([B,B,B,y,n],grab,[B,B,B,y,y]).
% Pushing the box changes where the monkey and the box are.
legal_move([B,M,M,n,H],push(X),[B,X,X,n,H]).
% Going to a location changes where the monkey is.
legal_move([B,_,L,n,H],go(X),[B,X,L,n,H]). 
