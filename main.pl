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

% surface constraints
:- consult(surfaceConstraints).

% non overlapping constraints
:- consult(nonOverlappingConstraints).

% getters
:- consult(getters).

% main algorithms
main():-
	writeln('beginning main'),
	% writeln('retrieving space facts'),
	% bagof((N, A, B, C, D, E, F, G, H, I, J, K, L, M, O), space(N,A,B,C,D,E,F,G,H,I,J,K,L,M,O), SpaceFactList),
	IdMax = 10,
	writeln('initating facts cleaning')
	cleanDB(IdMax),
	writeln('facts cleaned'),
	writeln('initiating variables creation'),
	createSpaceVar(0,_,FloorSpaceVar),
	writeln('floor variables created'),
	createVariables(IdMax, FloorSpaceVar, SpaceVarList),
	writeln('rooms variables created'),
	postSurfaceConstraints(FloorSpaceVar, SpaceVarList, Sum),
	writeln('')				% implemented
	postOrientationConstraints(IdMax, FloorSpaceVar, SpaceVarList),
	postAdjacencyConstraints(IdMax, FloorSpaceVar, SpaceVarList),
	postNonOverlappingConstraints(IdMax, FloorSpaceVar, SpaceVarList),




