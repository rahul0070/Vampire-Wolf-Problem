%%%%%%%%%%%%%%%% The File Contains all the assisting functions used by the main program %%%%%%%%%%%%%%%%

indexOf(X, [X|_], N, Res) :- Res is N.
indexOf(X, [_|L], N, Res) :- N1 is N + 1, indexOf(X, L, N1, Res).


abs2(X,Y) :- (X < 0 -> Y is -X ; Y = X).

cal(A, B, Res) :- R1 is A - B,
                  Res is R1 * R1.

select(X, [Value:Goal|Cases]) :-
( X = Value -> call(Goal);
               select(X, Cases)).