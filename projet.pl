% ----------------------- PROJET PROLOG
% - Floor planning problem

use_module(library(clpfd)).


% - définition contraintes
% space(kind, name, min_H, max_H, min_h, max_h, min_V, max_V,  min_v, max_v, min_ratio, max_ratio,
% min_surf, max_surf).
space(0, floor , home , 12, 12, 0, 0, 10, 10, 0, 0, _, _, 120, 120).
space(1, room , living , 4, _, 0, 0, 4, _, 0, 0, _, _, 33, 42).
space(2, room , room1 , 3, _, 0, 0, 3, _, 0, 0, _, _, 11, 15).
space(3, room , room2 , 3, _, 0, 0, 3, _, 0, 0, _, _, 11, 15).
space(4, room , room3 , 3, _, 0, 0, 3, _, 0, 0, _, _, 11, 15).
space(5, room , room4 , 3, _, 0, 0, 3, _, 0, 0, _, _, 15, 20).
space(6, room , kitchen , 3, _, 0, 0, 3, _, 0, 0, _, _,9, 15).
space(7, room , shower , 2, _, 0, 0, 2, _, 0, 0, _, _,6,9).
space(8, room , toilet, 1, _, 0, 0, 1, _, 0, 0, _, _,1,_).
space(9, corridor, corridor1, 1, _, 0, 0, 1, _, 0, 0, _, _,1, 12).
space(10, corridor, corridor2, 1, _, 0, 0, 1, _, 0, 0, _, _,1, 12).

% contour(room or corridor, list of directions: n, s, o, e, no, so, ne, se).
contour(living , [so]).
contour(kitchen, [s,n]).
contour(room1 , [s,n]).
contour(room2 , [s,n]).
contour(room3 , [s,n]).
contour(room4 , [s]).

% adj(room or corridor, list of rooms or corridors).
adj(living , [corridor1,corridor2]).
adj(shower , [corridor1,corridor2]).
adj(toilet, [corridor1,corridor2]).
adj(room1 , [corridor1,corridor2]).
adj(room2 , [corridor1,corridor2]).
adj(room3 , [corridor1,corridor2]).
adj(room4 , [corridor1,corridor2]).
adj(kitchen , [living]).
adj(kitchen , [shower]).
adj(toilet, [kitchen,shower]).
adj(corridor1, [corridor2]).


% - structure
% spaceVar(
%	id,
%	H,
%	h,
%	V,
%	v,
%	ratio,
%	surf,
%	[Xi, Hi, Yi, Vi] || [[Xi,H,Yi,V-v],[Xi,H-h,Yi,v]],
%	orientation
%	)

% home = [room1, room2, ...., roomN]

% ------------------------------------------------------------------------VARIABLES
% Initializes variables H V h v Ratio Surf plus the coordinates
createFloorVars(Z):-
	space(0, _, _, MinH, MaxH, Minh, Maxh, MinV, MaxV, Minv, Maxv, MinRatio, MaxRatio, MinSurf, MaxSurf),
	VarH in MinH..MaxH,
	Varh in Minh..Maxh,
	VarV in MinV..MaxV,
	Varv in Minv..Maxv,
	VarRatio in MinRatio..MaxRatio,
	VarSurf in MinSurf..MaxSurf,
	X in 0..0,
	Y in 0..0,
	H #= VarH,
	V #= VarV,
	Z = spaceVar(Id, VarH, Varh, VarV, Varv, VarRatio, VarSurf, [X,H,Y,V], []).

% Create the position variables and take care of position constraints and adjacency of the two parts of L shaped rooms
createSpaceVars(Id, Z):-
	space(Id, _, _, MinH, MaxH, Minh, Maxh, MinV, MaxV, Minv, Maxv, MinRatio, MaxRatio, MinSurf, MaxSurf),
	getCoordinates(Floor, [FloorX, FloorH, FloorY, FloorV]),
	RX1 in 0..FloorH,
	RY1 in 0..FloorV,
	RH in MinH..MaxH;
	RV in MinV..MaxV,
	Rv in Minv..Maxv,
	Rh in Minh..Maxh,
	Ratio in MinRatio..MaxRatio,
	Surf in MinSurf..MaxSurf,
	(Maxv =:= 0 ->
		% if room is rectangular
		RX1 + RH #=< FloorH,
		RY1 + RV #=< FloorV,
		W = [RX1, RH, RY1, RV];

		% else room is L shaped, consider the two rectangular subrooms
		% first main one of H*(V-v)
		RX1 + RH #=< FloorH,
		RV1 in 0..FloorV,
		RV1 #= RV - Rv,
		RY1 + RV1 #=< FloorV,
		% second one 
		RX2 in 0..FloorH,
		RY2 in 0..FloorV,
		% adjacency of the second part to the first one
		((RX2 #= RX1) #\ (RX2 #= RX1 + h)) #/\ ((RY2 #= RY1 - Rv) #\ (RY2 #= RY1 + RV - Rv)),
		RH2 in 0..FloorH,
		RH2 #= RH - Rh,
		RX2 + RH2 #=< FloorH,
		RY2 + Rv #=< FloorV,
		W = [[RX1, RH, RY1, RV1], [RX2, RH2, RY2, Rv]]
	)
	Z = spaceVar(Id, RH, Rh, RV, Rv, Ratio, Surf, W, []).

% Orientation constraints for rectangular rooms
orientationConstraints([X,H,Y,V], [n|Xs]):-
	getCoordinates()
	X + V #= 

% Adjacency constraints
	% /!\ different types of L shaped rooms
	% Update a graph object on which circuit will be ran later
adjacencyConstraint(SpaceVar, []).
adjacencyConstraint(SpaceVar, [SpaceVarAdj|Xs]):-


% Non overlapping constraints

% Accessibility constraint

%-------------------------------------------------------------------------GETTERS
getSpaceVar([SpaceVar1 | SpaceVars], Id, SpaceVar):-
	getId(SpaceVar1, Id1),
	(Id1 =:= Id -> 
		SpaceVar = SpaceVar1;
		getSpaceVar(SpaceVars),Id,SpaceVar
	).
	
getId(SpaceVar, Id):-
	arg(SpaceVar(1, SpaceVar, Id).

getH(SpaceVar, VarH):-
	arg(SpaceVar,2,VarH).

geth(SpaceVar, Varh):-
	arg(SpaceVar, 3, Varh).

getV(SpaceVar, V):-
	arg(SpaceVar, 4, V).

getv(SpaceVar, Varv):-
	arg(SpaceVar, 5, Varv).

getRatio(SpaceVar, Ratio):-
	arg(SpaceVar, 6, Ratio).

getSurf(SpaceVar, Surf):-
	arg(SpaceVar, 7, Surf).

getCoordinates(SpaceVar, X):-
	arg(SpaceVar, 8, [LLX, LLY, ULX, ULY, URX, URY, LRX, LRY]).
