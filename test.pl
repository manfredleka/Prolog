%test

:- use_module(library(clpfd)).

truc(12, _).

test():-
	truc(12, A),
	var(A).