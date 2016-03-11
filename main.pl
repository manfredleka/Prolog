% for more information on modelisation and hypothesis, check the readme

% load constraint programming of finite domains library
:- use_module(library(clpfd)).

% make space definition dynamic to enable cleaning facts 
:- dynamic space/15.

% load problem definition 			NP
:- consult(problem).


% load cleaning rules for space facts 				TEST OK
:- consult(cleanRules).

% create variables for rooms and floor
:- consult(createVariables).

% surface constraints
:- consult(surfaceConstraints).

% non overlapping constraints
:- consult(nonOverlappingConstraints).

% adjacency constraints
:- consult(adjacencyConstraints).

% orientation constraints
:- consult(orientationConstraints).

% getters
:- consult(getters).

% compute lost space
getSum([], 0).

getSum([SpaceVar | SpaceVarList], Sum):-
	getSum(SpaceVarList, Sum1),
	getSurf(SpaceVar, Surf),
	Sum #= Sum1 + Surf.

% main algorithms
main(Solution):-
	writeln('beginning main'),

	IdMax = 10,

	writeln('initating facts cleaning'),
	cleanDB(IdMax),
	writeln('facts cleaned'),

	writeln('initiating variables creation'),
	createSpaceVar(0,_,FloorSpaceVar),
	writeln('floor variables created'),
	createVariables(IdMax, FloorSpaceVar, SpaceVarList),
	writeln('rooms variables created'),

	writeln('initiating surface constraints posting'),
	postSurfaceConstraints(SpaceVarList),
	writeln('surface constraints posted'),				% checked

	writeln('initiating orientation constraints posting'),
	findall(RoomName, contour(RoomName,_), OrientationRoomNames),
	postOrientationConstraints(OrientationRoomNames, SpaceVarList, FloorSpaceVar),
	writeln('orientation constraints posted'),			% checked

	writeln('iniating adjacency constraints posting'),
	findall(RoomName, adj(RoomName, _), AdjRoomNames),
	postAdjacencyConstraints(AdjRoomNames, SpaceVarList),				% checked
	writeln('adjacency constraints posted'),

	writeln('initiating non overlapping constraints posting'),
	postNonOverlappingConstraints(SpaceVarList),
	writeln('non overlapping constraints posted'),		% checked

	writeln('initiating labeling'),
	% compute lost space
	space(0, floor , _ , _, _, _, _, _, _, _, _, _, _, _, MaxSurf),
	LostSpace in 0..MaxSurf,
	getSurf(FloorSpaceVar, FloorSurf),
	getSum(SpaceVarList, Sum),
	LostSpace #= FloorSurf - Sum,

	% collect the list of variables 
	getAllCoordinates(FloorSpaceVar, SpaceVarList, AllVariables),
	% orders the minimizing of lost space as solving strategy
	flatten(AllVariables, Variables),
	labeling([min(LostSpace)], Variables),
	Solution = SpaceVarList.