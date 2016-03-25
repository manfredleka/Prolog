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

% non overlapping constraints
:- consult(nonOverlappingConstraints).

% general surface constraint
:- consult(generalSurfConstraint).

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
%getSum([], 0).

%getSum([SpaceVar | SpaceVarList], Sum):-
%	getSum(SpaceVarList, Sum1),
%	getf(SpaceVar, Surf),
%	Sum #= Sum1 + Surf.

% main algorithms
main(Solution):-
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

%	writeln('iniating adjacency constraints posting'),
%	findall(X, adj(X, _), ListAdjNames),
%	postAdjacencyConstraints(ListAdjNames, SpaceVarList), 
%	writeln('adjacency constraints posted'), nl,

	writeln('initiating non overlapping constraints posting'),
	postNonOverlappingConstraints(SpaceVarList),
	writeln('non overlapping constraints posted'), nl,	

	writeln('initiating orientation constraints posting'),
	findall(RoomName, contour(RoomName,_), OrientationRoomNames),
	postOrientationConstraints(OrientationRoomNames, SpaceVarList, FloorSpaceVar),
	writeln('orientation constraints posted'),	nl,		

	writeln('initiating surface constraints posting'),
	postGalSurfConstraint(SpaceVarList, FloorSpaceVar),
	writeln('surface constraints posted'), nl,

%	compute lost space
%	space(0, floor , _ , _, _, _, _, _, _, _, _, _, _, _, MaxSurf),
%	LostSpace in 0..MaxSurf,
%	getCoordinates(FloorSpaceVar, [[_, H, _, V], []]),
%	sumSurfaces(SpaceVarList, Sum),
%	LostSpace #= H * V - Sum, 

	% collect the list of variables 
	getAllCoordinates(FloorSpaceVar, SpaceVarList, AllVariables),
	% orders the minimizing of lost space as solving strategy
	flatten(AllVariables, Variables),
	writeln('initiating labeling'),

	labeling([ffc, up, bisect], Variables),
	%LostSpace2 = LostSpace,
	Solution = SpaceVarList,
	printSolution(SpaceVarList).

	%write corresponding svg file
	%writeln('initiating svg file creation'),
	%writeSvg(SpaceVarList, FloorSpaceVar).

testSolution(Floor, Sol):-
	createVariables(Sol, SpaceVarList),
	createFloor(Floor, FloorSpaceVar),

	findall(X, adj(X, _), AdjListNames),
	writeln('adjacency'), nl,
	postAdjacencyConstraints(AdjListNames, SpaceVarList),
	writeln('adjacency done'), nl, 

	writeln('orientation'), nl,
	findall(RoomName, contour(RoomName,_), OrientationRoomNames),
	postOrientationConstraints(OrientationRoomNames, SpaceVarList, FloorSpaceVar),
	writeln('orientation done'), nl,

	writeln('non overlapping'), nl,
	postNonOverlappingConstraints(SpaceVarList),
	writeln('non overlapping done'), nl,

	writeln('gal surf'), nl,
	postGalSurfConstraint(SpaceVarList, FloorSpaceVar),
	writeln('gal surf done'), nl.


createVariables([], []).

createVariables([spaceVar(Id, [[X, H, Y, V], []], Name) | SpaceVars], YYY):-
	createVariables(SpaceVars, Z),
	VX in X..X,
	VH in H..H,
	VY in Y..Y,
	VV in V..V,
	YY = [spaceVar(Id, [[VX, VH, VY, VV],[]], Name), Z],
	flatten(YY, YYY).


createFloor(spaceVar(0, [[X,H,Y,V],[]], floor), FloorSpaceVar):-
	VX in X..X,
	VH in H..H,
	VY in Y..Y,
	VV in V..V,
	FloorSpaceVar = spacevar(0, [[VX, VH, VY, VV], []], floor).