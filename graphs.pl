%DAG
% e(a,c).
% e(a,g).
% e(c,g).
% e(a,d).
% e(d,g).
% e(d,h).
% e(g,h).
% e(f,b).
% e(f,e).
% e(b,e).
% e(e,a).

%cyclic graph
e(a,a).
e(a,b). e(a,e). e(a,f).
e(b,c). e(b,e).
e(c,d). e(c,e).
e(e,d).
e(f,e). e(f,g). e(f,h).
e(g,d).
e(h,g). e(h,i).
e(i,f). e(i,a).

dfs(S,F) :- e(S,F).
dfs(S,F) :- e(S,V),dfs(V,F).

%works for DAGs
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


dfsPath2(S,F,Path) :- dfsPath2Acc(S,F,[S],RevPath), reverse(RevPath, Path).

dfsPath2Acc(F,F,CurrPath,CurrPath).
dfsPath2Acc(S,F,CurrPath,RevPath) :-
    e(S,V), 
    \+ member(V, CurrPath), 
    dfsPath2Acc(V, F, [V| CurrPath], RevPath).


dfsPathID(Depth, S,F,[S,F]) :- Depth =:= 1, e(S,F). 
dfsPathID(Depth, S,F,[S|Rest]) :- Depth>0, Dm1 is Depth-1, e(S,V), dfsPathID(Dm1, V,F,Rest).

idHelper(S,F,Path,Depth) :- dfsPathID(Depth,S,F,Path).
idHelper(S,F,Path,Depth) :- Dp1 is Depth +1, idHelper(S,F,Path,Dp1).

dfsPath3(S,F,Path) :- idHelper(S,F,Path,0).