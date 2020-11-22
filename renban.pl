:- use_module(library(clpfd)).
:- [problems].

% check if list is made of consecutive numbers
is_consecutive([]) :- !.
is_consecutive([_]) :- !.
is_consecutive([X, Y|Xs]) :-
	X + 1 #= Y,
	is_consecutive([Y|Xs]).

% check if list are made of different numbers
% and inside the permitted range
sequence_valid(BoardSize, Sequence) :-
	all_different(Sequence),
	Sequence ins 1..BoardSize.

% this only works, if the cells are labelled
% because when sorting variables(not labelled terms),
% they are ALWAYS put in front of the list, and the
% algorithm fails.
area_valid(Area) :-
	sort(Area, Sorted),
	is_consecutive(Sorted).

solve_renban(Rows, Areas) :-
	length(Rows, Size),
	transpose(Rows, Cols),
	% check is rows, cols and areas
	% sequences are all valid
	maplist(sequence_valid(Size), Rows),
	maplist(sequence_valid(Size), Cols),
	maplist(sequence_valid(Size), Areas),
	% label all solutions
	maplist(label, Rows),
	% after labelling check if the areas are still valid
	maplist(area_valid, Areas).

% given a Renban problem, print its solution
renban(N) :-
	board(N, Rows, Areas),
	write('Board:\n'),
	maplist(portray_clause, Rows),
	solve_renban(Rows, Areas),	
	write('Solved Board:\n'),
	maplist(portray_clause, Rows).
