% for more information on modelisation and hypothesis, check the readme

% load constraint programming of finite domains library
:- use_module(library(clpfd)).

% make space definition dynamic to enable cleaning facts 
:- dynamic space/15.
:- dynamic e/2.
:- dynamic node/1.
:- dynamic adj/2.

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

% svg writer
%:- consult(svgwriter).

% optimal visit path
:- consult(visit).

printSolution([]).

printSolution([SpaceVar | SpaceVarList]):-
	printSolution(SpaceVarList),
	writeln(SpaceVar).
% compute lost space
getSum([], 0).

getSum([SpaceVar | SpaceVarList], Sum):-
	getSum(SpaceVarList, Sum1),
	getSurf(SpaceVar, Surf),
	Sum #= Sum1 + Surf.

% main algorithms
main(Solution, LostSpace2):-
	writeln('beginning main'),

	IdMax = 10,

	writeln('initating facts cleaning'),
	cleanDB(IdMax),
	writeln('facts cleaned'), nl,

	writeln('initiating variables creation'),
	createSpaceVar(0,_,FloorSpaceVar),
	writeln('floor variables created'),
	createVariables(IdMax, FloorSpaceVar, SpaceVarList),
	writeln('rooms variables created'), nl,

	writeln('initiating orientation constraints posting'),
	findall(RoomName, contour(RoomName,_), OrientationRoomNames),
	postOrientationConstraints(OrientationRoomNames, SpaceVarList, FloorSpaceVar),
	writeln('orientation constraints posted'),	nl,

	writeln('iniating adjacency constraints posting'),
	findall(X, adj(X, _), ListAdjNames),
	postAdjacencyConstraints(ListAdjNames, SpaceVarList), nl,
	writeln('adjacency constraints posted'),


	writeln('initiating non overlapping constraints posting'),
	postNonOverlappingConstraints(SpaceVarList),
	writeln('non overlapping constraints posted'), nl,					

	writeln('initiating surface constraints posting'),
	postSurfaceConstraints(SpaceVarList),
	writeln('surface constraints posted'), nl,

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
	once(labeling([ffc, up, min(LostSpace)], Variables)),
	LostSpace2 = LostSpace,
	Solution = SpaceVarList,
	printSolution(SpaceVarList).

	%write corresponding svg file
	%writeln('initiating svg file creation'),
	%writeSvg(SpaceVarList, FloorSpaceVar).