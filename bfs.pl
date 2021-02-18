:- [functions].
:- [abstract_types].

state_record(State, Parent, [State, Parent]).

bfs(Start, Goal, Type) :- 
    select(Type, [
        sp : consult(puzzle),
        vw : consult(vampire)]),
        
    empty_queue(Empty_open),
    state_record(Start, nil, State),
    add_to_queue(State, Empty_open, Open),
    empty_set(Closed),
    bfs_path(Open, Closed, Goal).

bfs_path(Open,_,_) :- empty_queue(Open),
                  write('Graph searched, no solution found'), nl.
    
bfs_path(Open, Closed, Goal) :- 
    remove_from_queue(Next_record, Open, _),
    state_record(State, _, Next_record),
    State = Goal,
    write('Solution bfs_path is: '), nl,
    bfs_print(Next_record, Closed).
    
bfs_path(Open, Closed, Goal) :- 
    remove_from_queue(Next_record, Open, Rest_of_open),
    (bagof(Child, moves(Next_record, Open, Closed, Child), Children);Children = []),
    add_list_to_queue(Children, Rest_of_open, New_open), 
    add_to_set(Next_record, Closed, New_closed),
    bfs_path(New_open, New_closed, Goal),!.

moves(State_record, Open, Closed, Child_record) :-
    state_record(State, _, State_record),
    move(State, Next),
    % not (unsafe(Next)),
    state_record(Next, _, Test),
    not(member_queue(Test, Open)),
    not(member_set(Test, Closed)),
    state_record(Next, State, Child_record).

bfs_print(State_record, _):- 
    state_record(State,nil, State_record),
    write(State), nl.

bfs_print(State_record, Closed) :-
    state_record(State, Parent, State_record),
    state_record(Parent, _, Parent_record),
    member(Parent_record, Closed),
    bfs_print(Parent_record, Closed),
    write(State), nl.
        
add_list_to_queue([], Queue, Queue).
add_list_to_queue([H|T], Queue, New_queue) :-
    add_to_queue(H, Queue, Temp_queue),
    add_list_to_queue(T, Temp_queue, New_queue).
