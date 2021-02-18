
% Cost of a travel across the river remains 1.
cost(_, _, C) :-
    C is 1.



% Available legal moves.

move([WW,VW,WE,VE,east],[WE2,VE2,WW2,VW2,west]):-
	WW2 is WE-1,
	WE2 is WW+1,
	VW2 is VE-1,
	VE2 is VW+1,
	legal(WE2,VE2,WW2,VW2).

move([WW,VW,WE,VE,east],[WW,VE2,WE,VW2,west]):-
	VW2 is VE-1,
	VE2 is VW+1,
	legal(WW,VE2,WE,VW2).
	
move([WW,VW,WE,VE,east],[WE2,VW,WW2,VE,west]):-
	WW2 is WE-1,
	WE2 is WW+1,
	legal(WE2,VW,WW2,VE).

move([WW,VW,WE,VE,west],[WW,VE2,WE,VW2,east]):-
	((VW2 is VE+2, VE2 is VW-2) ; (VW2 is VE-2, VE2 is VW+2)),
	legal(WW,VE2,WE,VW2).

move([WW,VW,WE,VE,west],[WE2,VW,WW2,VE,east]):-
	((WW2 is WE+2, WE2 is WW-2) ; (WW2 is WE-2, WE2 is WW+2)),
	legal(WE2,VW,WW2,VE).

move([WW,VW,WE,VE,west],[WE2,VE2,WW2,VW2,east]):-
	WW2 is WE+1,WE2 is WW-1,VW2 is VE+1,VE2 is VW-1,
	legal(WE2,VE2,WW2,VW2).
	
move([WW,VW,WE,VE,west],[WW,VE2,WE,VW2,east]):-
	VW2 is VE+1,
	VE2 is VW-1,
	legal(WW,VE2,WE,VW2).

move([WW,VW,WE,VE,west],[WE2,VW,WW2,VE,east]):-
	WW2 is WE+1,
	WE2 is WW-1,
	legal(WE2,VW,WW2,VE).


% Heuristic calculates final counts of werewolves and vampires on the goal side divided by the boats capacity.
heuristic(_, Goal, Result) :- last(Goal, L), (L = east -> hEast(Goal, Res) ; hWest(Goal, Res)), Result is Res.

hWest([WW,VW|_], H) :-
    H is (WW+VW)/2.

hEast([_,_,WE,VE,_], H) :-
    H is (WE+VE)/2.

% Move is legal if vampires are not outnumbered
legal(WW,VW,WE,VE) :- (VW>=WW ; VW=0), (VE>=WE ; VE=0),
	VW>=0, WW>=0, VE>=0, WE>=0.
