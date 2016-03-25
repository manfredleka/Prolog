% PROBLEM DEFINITION

% space(kind, name, min_H, max_H, min_h, max_h, min_V, max_V,  min_v, max_v, min_ratio, max_ratio,
% min_surf, max_surf).

space(0, floor , home , 5, 5, 0, 0, 5, 5, 0, 0, _, _, 25, 25).
space(1, room , living , 1, _, 0, 0, 1, _, 0, 0, _, _, 4, 10).
space(2, room , room1 , 3, _, 0, 0, 3, _, 0, 0, _, _, 4, 10).
space(3, room, room2, 1, _, 0, 0, 1, _, 0, 0, _, _, 3, 10).
space(4, room, room3, 1, _, 0, 0, 1, _, 0, 0, _, _, 3, 10).
space(5, room, room4, 1, _, 0, 0, 1, _, 0, 0, _, _, 3, 10).



% contour(room or corridor, list of directions: n, s, o, e, no, so, ne, se).
contour(living , [n]).

% adj(room or corridor, list of rooms or corridors).
adj(room1 , [room2]).

