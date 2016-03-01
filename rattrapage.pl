% Chargement de la librairie constraint logic programming on finite 
% domains
use_module(library(clpfd)).







% PROBLEM INSTANCE

% DECLARATION OF THE DIFFERENT SPACE WITH THEIR RESPECTIVE DIMENSIONAL CONSTRAINTS
% Robert Maculet PhD thesis


% space(kind, name, min_H, max_H, min_V, max_V, min_h, max_h, min_v, max_v, min_ratio, max_ratio,
% min_surf, max_surf).

space(floor , home , 12, 12, 0, 0, 10, 10, 0, 0, _, _, 120, 120).
space(room , living , 4, _, 0, 0, 4, _, 0, 0, _, _, 33, 42).
space(room , room1 , 3, _, 0, 0, 3, _, 0, 0, _, _, 11, 15).
space(room , room2 , 3, _, 0, 0, 3, _, 0, 0, _, _, 11, 15).
space(room , room3 , 3, _, 0, 0, 3, _, 0, 0, _, _, 11, 15).
space(room , room4 , 3, _, 0, 0, 3, _, 0, 0, _, _, 15, 20).
space(room , kitchen , 3, _, 0, 0, 3, _, 0, 0, _, _,9, 15).
space(room , shower , 2, _, 0, 0, 2, _, 0, 0, _, _,6,9).
space(room , toilet, 1, _, 0, 0, 1, _, 0, 0, _, _,1,_).
space(corridor, corridor1, 1, _, 0, 0, 1, _, 0, 0, _, _,1, 12).
space(corridor, corridor2, 1, _, 0, 0, 1, _, 0, 0, _, _,1, 12).

% DECLARATION OF THE ORIENTATIONS CONSTRAINTS
% contour(room or corridor, list of directions: n, s, o, e, no, so, ne, se).
contour(living , [so]).
contour(kitchen, [s,n]).
contour(room1 , [s,n]).
contour(room2 , [s,n]).
contour(room3 , [s,n]).
contour(room4 , [s]).

% DECLARATION OF THE ADJACENCY CONSTRAINTS
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


%---------------------------------------------Solver

% POST dimensional constraint for each room
dimensionalConstraints(Space):-
	H #=> space(Space,_,X,_,_,_,_,_,_,_,_,_,_,_),
	H #=< space(Space,_,_,X,_,_,_,_,_,_,_,_,_,_),

	V #=> space(Space,_,_,_,X,_,_,_,_,_,_,_,_,_),
	V #=< space(Space,_,_,_,_,X,_,_,_,_,_,_,_,_),

	h #=> space(Space,_,_,_,_,_,X,_,_,_,_,_,_,_),
	h #=< space(Space,_,_,_,_,_,_,X,_,_,_,_,_,_),

	v #=> space(Space,_,_,_,_,_,_,_,X,_,_,_,_,_),
	v #=< space(Space,_,_,_,_,_,_,_,_,X,_,_,_,_),

	



