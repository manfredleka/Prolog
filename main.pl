% for more information on modelisation and hypothesis, check the readme

% load constraint programming of finite domains library
:- use_module(library(clpfd)).

% load problem definition 			NP
:- consult(problem).

% make space definition dynamic to enable cleaning facts 
:- dynamic space/15.

% load cleaning rules for space facts 				TEST OK
:- consult(cleanRules).

% create variables for rooms and floor
:- consult(createVariables).

% non overlapping constraints
:- consult(nonOverlappingConstraints).

% getters
:- consult(getters).

% main algorithm
main():-
	write('start').