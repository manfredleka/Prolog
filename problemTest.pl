% PROBLEM DEFINITION

% space(kind, name, min_H, max_H, min_h, max_h, min_V, max_V,  min_v, max_v, min_ratio, max_ratio,
% min_surf, max_surf).
space(0, floor , home , 12, 12, 0, 0, 10, 10, 0, 0, _, _, 120, 120).
space(1, room , living , 4, _, 0, 0, 4, _, 0, 0, _, _, 10, 60).
space(2, room , room1 , 3, _, 0, 0, 3, _, 0, 0, _, _, 10, 60).



% contour(room or corridor, list of directions: n, s, o, e, no, so, ne, se).
contour(living , [n,s,e,o]).

% adj(room or corridor, list of rooms or corridors).
adj(living , room1).
