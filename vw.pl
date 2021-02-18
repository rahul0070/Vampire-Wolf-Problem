
% Cost is always 1, back and forth with boat
cost(_, _, C) :-
    C is 1.

% Moves include: moving 1 vampire east/west, moving 1 werewolf east/west,
% moving 2 vampires east/west, moving 2 werewolves east/west. and moving 1 vampire and 1 werewolf east/west.

move([WE,VE,WW,VW],[WE2,VE2,WW2,VW2]):-
	WW2 is WW-1,
	WE2 is WE+1,
	VW2 is VW-1,
	VE2 is VE+1,
	legal(WE2,VE2,WW2,VW2).

move([WE,VE,WW,VW],[WE,VE2,WW,VW2]):-
	VW2 is VW-1,
	VE2 is VE+1,
	legal(WE,VE2,WW,VW2).
	
move([WE,VE,WW,VW],[WE2,VE,WW2,VW]):-
	WW2 is WW-1,
	WE2 is WE+1,
	legal(WE2,VE,WW2,VW).

move([WE,VE,WW,VW],[WE,VE2,WW,VW2]):-
	((VW2 is VW+2, VE2 is VE-2) ; (VW2 is VW-2, VE2 is VE+2)),
	legal(WE,VE2,WW,VW2).

move([WE,VE,WW,VW],[WE2,VE,WW2,VW]):-
	((WW2 is WW+2, WE2 is WE-2) ; (WW2 is WW-2, WE2 is WE+2)),
	legal(WE2,VE,WW2,VW).

move([WE,VE,WW,VW],[WE2,VE2,WW2,VW2]):-
	WW2 is WW+1,WE2 is WE-1,VW2 is VW+1,VE2 is VE-1,
	legal(WE2,VE2,WW2,VW2).
	
move([WE,VE,WW,VW],[WE,VE2,WW,VW2]):-
	VW2 is VW+1,
	VE2 is VE-1,
	legal(WE,VE2,WW,VW2).

move([WE,VE,WW,VW],[WE2,VE,WW2,VW]):-
	WW2 is WW+1,
	WE2 is WE-1,
	legal(WE2,VE,WW2,VW).


% Heuristic observes final counts of werewolves and vampires on the east by capacity of boat.
heuristic(_, [WE,VE|_], H) :-
    H is (WE+VE)/2.

% Move is legal if vampires are not outnumbered
legal(WE,VE,WW,VW) :- (VE>=WE ; VE=0), (VW>=WW ; VW=0),
	VE>=0, WE>=0, VW>=0, WW>=0.
