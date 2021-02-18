:- [functions].
:- [abstract_types].

dfs(Start, Goal, Type) :-
    select(Type, [
        sp : consult(puzzle),
        vw : consult(vampire)]),
      
	empty_stack(Empty_been_list),
	stack(Start, Empty_been_list, Been_list),
	dfs_path(Start, Goal, Been_list).
	
	% dfs_path implements a depth first search in PROLOG
	
	% Current state = goal, print out been list
dfs_path(Goal, Goal, Been_list) :-
    write('Solution dfs_path is: '), nl,
	print_stack(Been_list).
	
dfs_path(State, Goal, Been_list) :-
	move(State, Next),
	% not(unsafe(Next)),
	not(member_stack(Next, Been_list)),
	stack(Next, Been_list, New_been_list),
	dfs_path(Next, Goal, New_been_list), !.
	
print_stack(S) :-
	empty_stack(S).
print_stack(S) :-
	stack(E, Rest, S),
	print_stack(Rest),
	write(E), nl.
