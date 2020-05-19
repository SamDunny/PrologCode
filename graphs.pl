e(a,c).
e(a,g).
e(c,g).
e(a,d).
e(d,g).
e(d,h).
e(g,h).
e(f,b).
e(f,e).
e(b,e).
e(e,a).

dfs(S,F) :- e(S,F).
dfs(S,F) :- e(S,V),dfs(V,F).

dfsPath(S,F,[S,F]) :- e(S,F). 
dfsPath(S,F,[S|Rest]) :- e(S,V), dfsPath(V,F,Rest).


%bfs(S,F,Tree).

%X is node (not edge), Tree is list of edges
mem(X,Tree) :- member(e(X,_),Tree).
mem(X,Tree) :- member(e(_,X),Tree).

adj(X,A ) :- e(X,A) .

edge_path_2_node_path( [ e(F,T) ] , [F,T]).
edge_path_2_node_path( [ e(F,_)| [ H|T] ] , [F| NP_HT] ) :- 
    edge_path_2_node_path([H|T], NP_HT).

bfsPath(S,F,Path):-
    bfs(S,F,Tree),
    mem(F,Tree),
    path_up_tree(F,S,Tree,ReverseEPath),
    reverse(ReverseEPath,EPath),
    edge_path_2_node_path(EPath,Path).

path_up_tree(F,S,Tree, [ e(S,F)]) :- member( e(S,F), Tree).
path_up_tree(F,S, Tree, [ e(P,F) | PPath ] ) :-
    \+ member( e(S,F), Tree),
    member( e(P,F) , Tree ),
    path_up_tree(P,S,Tree,PPath).

bfs(X,F,Tree) :- 
    findall( e(X,A), adj(X,A), NewTree),
    grow_bfs_tree(F, [] , NewTree,Tree).

grow_bfs_tree(_, DoneTree,[],DoneTree).

grow_bfs_tree( F,DoneTree,NewTree,XTree) :- 
    ( mem(F,NewTree) ; mem(F,DoneTree) ),
    append(DoneTree,NewTree, XTree).

grow_bfs_tree( F,DoneTree,NewTree,FinTree) :- 
    \+ ( mem(F,NewTree) ; mem(F,DoneTree) ),
    [e(P,N)| RestTree ] = NewTree,
    findall( e(N,X) , ( adj(N,X), \+ mem(X,NewTree), \+ mem(X,DoneTree) ), NewEdges ),
    append(RestTree,NewEdges,Updated_NewTree),
    append(DoneTree, [e(P,N)], Updated_Done_Tree),
    grow_bfs_tree(F, Updated_Done_Tree, Updated_NewTree, FinTree).
