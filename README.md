# Prolog
PROJET PROLOG

 Floor planning problem

 hypothesis :
	only one floor
	door of 1 meter width
	accessibility constraints not handled, adjacency constraints trusted to handle accessibility

 spaceVar structure :
 	spaceVar( id,	H, h, V, v, ratio, surf, [[Xi,H,Yi,V-v],[Xi,H-h,Yi,v]],	orientation)
 
 home structure :
 	home = [room1, room2, ...., roomN]