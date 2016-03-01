% SIMPLIFIED FLOOR PLANNING PROBLEM SOLVER

% problem description
% floor planning problem 
% limited to rectangular and L shaped rooms of type 1 
% currently on 1 single floor
% currently w/o contour constraints

use_module(library(clpfd)).

% model for rectangular rooms : V to 0 and v to 0
% model for L shaped rooms (only type 1 allowed) : V and v to non zero values

% space(kind, name, min_H, max_H, min_V, max_V, min_h, max_h, min_v, max_v, min_ratio, max_ratio,
% min_surf, max_surf).
space(floor, home, 12, 12, 0, 0, 10, 10, 0, 0, _, _, 120, 120).
space(room , living , 4, _, 0, 0, 4, _, 0, 0, _, _, 33, 42).
space(room , room1 , 3, _, 0, 0, 3, _, 0, 0, _, _, 11, 15).
space(room , room2 , 3, _, 0, 0, 3, _, 0, 0, _, _, 11, 15).

% contour(room or corridor, list of directions: n, s, o, e, no, so, ne, se).
contour(living , [so]).
contour(room1 , [s,n]).
contour(room2 , [s,n]).


% ---------------------------------------------CREATE VARIABLES

% createVar deals with dimensional constraint including L or not shape (with h and v)
% if L shaped, room splitted in two parts ie room2LLx & room2LLy instantiated to second part of room
% plus adjancency constraint posted for the two parts to be glued at all times
createVar(space, room, floorH, floorV, roomH, roomV, roomv, roomh, roomRatio, roomSurf, room1LLx, room1LLy):-
	% general room properties
	space(space, room, roomMinH, roomMaxH, roomMinV, roomMaxV, roomMinh, roomMaxh, roomMinv, roomMaxv, roomMinRatio, roomMaxRatio, roomMinSurf, roomMaxsurf),
	roomH in roomMinH..roomMaxH,
	roomV in roomMinV..roomMaxV,
	roomh in roomMinh..roomMaxh,
	roomv in roomMinv..roomMaxv,,
	roomRatio in roomMinRatio..roomMaxRatio,
	roomSurf in roomMinSurf..roomMaxSurf,
	(roomH*(roomV - roomv) + (roomH - roomh)*roomv) #= roomSurf,
	% constraints on lower left corner of the room which must fit in the floor...
	room1LLx in 0..(floorMaxH - roomH),
	room1LLy in 0..(floorMaxV - roomV).

% ---------------------------------------------CONSTRAIN VARIABLES

%posteContour with only one parameter means room MUST 
%posteContour(room, [X]):-
	

solve():-
%CREATING VARIABLES
		% floor properties
	(floor, home, floorMinH, floorMaxH, _, _, floorMinV, floorMaxV,_, _, _, _, floorMinSurf, floorMaxSurf), 
	floorH in floorMinH..floorMaxH,
	floorV in floorMinV..floorMaxV
	floorSurf in floorMinSurf..floorMaxSurf,
		% rooms properties
	createVar(room, living, floorH, floorV, livingH, livingV, livingv, livingh, livingRatio, livingSurf, livingLLx, livingLLy),
	createVar(room, room1, floorH, floorV, room1H, room1V, room1v, room1h, room1Ratio, room1Surf, room1LLx, room1LLy),
	createVar(room, room2, floorH, floorV, room2H, room2V, room2v, room2h, room2Ratio, room2Surf, room2LLx, room2LLy),
		% non overlapping constraints

		% adjacency constraints
		% TODO

		% accessibility constraint
		%TODO

		% minimize waste space
		%labeling fonction de cout + variables

