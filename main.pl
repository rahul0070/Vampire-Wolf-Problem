:- [abstract_types].
:- [bfs].
:- [dfs].
:- [hfs].

run(puzzle(Start, Goal), Strategy, Type) :-
    select(Strategy, [ bfs : bfs(Start, Goal, Type), dfs : dfs(Start, Goal, Type), hfs : hfs(Start, Goal, Type)]).

% Program entry point, 'start.'

start :-
    write(' ==== 15 Sliding tile & VampireWerewolf puzzle implementation in Prolog ===='),nl,nl,
    slidingTile,
    vampireWerewolf.


slidingTile :- 
    ST_bfs = puzzle([1,b,2,4,5,6,3,7,8,9,10,11,12,13,14,15], [1,2,3,4,5,6,b,7,8,9,10,11,12,13,14,15]),
    ST_dfs = puzzle([1,2,b,4,5,6,3,7,8,9,10,11,12,13,14,15], [1,2,3,4,5,6,b,7,8,9,10,11,12,13,14,15]),
    ST_hfs = puzzle([1,6,2,4,5,b,3,7,8,9,10,11,12,13,14,15], [1,2,3,4,5,6,b,7,8,9,10,11,12,13,14,15]),

    write('Running BFS on 15 Sliding Tile puzzle...'), nl, nl,
    statistics(walltime, _),
    run(ST_bfs, bfs, sp),
    statistics(walltime, [_ | [ExecutionTime_bfs]]),
    nl,write('Execution took '), write(ExecutionTime_bfs), write(' ms.'), nl,

    nl, write('Running DFS on 15 Sliding Tile puzzle...'), nl, nl,
    statistics(walltime, _),
    run(ST_dfs, dfs, sp),
    statistics(walltime, [_ | [ExecutionTime_dfs]]),
    nl,write('Execution took '), write(ExecutionTime_dfs), write(' ms.'), nl,


    nl, write('Running BestFS on 15 Sliding Tile puzzle...'), nl, nl,
    statistics(walltime, _),
    run(ST_hfs, hfs, sp),
    statistics(walltime, [_ | [ExecutionTime_hfs]]),
    nl,write('Execution took '), write(ExecutionTime_dfs), write(' ms.'), nl.


vampireWerewolf :- 
    VW = puzzle([3,3,0,0,west], [0,0,3,3,east]),
    VW2 = puzzle([0,0,3,3,east], [3,3,0,0,west]),
    nl, write('Running BFS on Vamp-Wolf puzzle...'), nl, nl,
    statistics(walltime, _),
    run(VW, bfs, vw),
    statistics(walltime, [_ | [ExecutionTime_bfs_vw]]),
    nl,write('Execution took '), write(ExecutionTime_bfs_vw), write(' ms.'), nl,


    nl, write('Running DFS on Vamp-Wolf puzzle...'), nl, nl,
    statistics(walltime, _),
    run(VW, dfs, vw),
    statistics(walltime, [_ | [ExecutionTime_dfs_vw]]),
    nl,write('Execution took '), write(ExecutionTime_dfs_vw), write(' ms.'), nl,


    nl, write('Running BestFS on Vamp-Wolf puzzle...'), nl, nl,
    statistics(walltime, _),
    run(VW, hfs, vw),
    statistics(walltime, [_ | [ExecutionTime_hfs_vw]]),
    nl,write('Execution took '), write(ExecutionTime_hfs_vw), write(' ms.'), nl,
    nl, write('Done.'), nl.

