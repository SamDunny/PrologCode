% This general planner needs the predicates below to be defined:
%     - legal_move(BeforeState,Move,AfterState)
%     - initial_state(State)
%     - goal_state(State)

% plan(L): L is a list of moves from the initial state to a goal state.
plan(L) :- initial_state(I), goal_state(G), reachable(I,L,G).

% reachable(S1,L,S2): S2 is reachable from S1 using moves L.
reachable(S,[],S).           
reachable(S1,[M|L],S3) :- legal_move(S1,M,S2), reachable(S2,L,S3).
