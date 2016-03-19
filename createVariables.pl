% Create variables with respect to chosen data structure for floor and rooms
createVariables(0, _, []).

createVariables(N, FloorSpaceVar, SpaceVarList):-
	N > 0,
	N1 is N - 1,
	createVariables(N1, FloorSpaceVar, SpaceVarList1),
	createSpaceVar(N, FloorSpaceVar, Z),
	SpaceVarList = [Z | SpaceVarList1].

% Initializes variables H V h v Ratio Surf plus the coordinates
createSpaceVar(0, _, Z):-
	space(0, _, Name, MinH, MaxH, Minh, Maxh, MinV, MaxV, Minv, Maxv, _, _, _, _),
	VarH in MinH..MaxH,
	Varh in Minh..Maxh,
	VarV in MinV..MaxV,
	Varv in Minv..Maxv,
	X in 0..0,
	Y in 0..0,
	Z = spaceVar(0, VarH, Varh, VarV, Varv, _, [[X,VarH,Y,VarV],[]], Name).

% Create the position variables and take care of position constraints and adjacency of the two parts of L shaped rooms
createSpaceVar(Id, FloorSpaceVar, Z):-
	space(Id, _, Name, MinH, MaxH, Minh, Maxh, MinV, MaxV, Minv, Maxv, _, _, MinSurf, MaxSurf),
	getCoordinates(FloorSpaceVar, [[_, FloorH, _, FloorV],[]]),
	RX1 in 0..FloorH,
	RY1 in 0..FloorV,
	RH in MinH..MaxH,
	RV in MinV..MaxV,
	Rv in Minv..Maxv,
	Rh in Minh..Maxh,
	Surf in MinSurf..MaxSurf,
	(Maxv =:= 0 ->
		% if room is rectangular
		RX1 + RH #=< FloorH,
		RY1 + RV #=< FloorV,
		W = [[RX1, RH, RY1, RV],[]],
		RH * RV #=< MaxSurf,
		RH * RV #>= MinSurf;

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
		((RX2 #= RX1) #\/ (RX2 #= RX1 + h)) #/\ ((RY2 #= RY1 - Rv) #\/ (RY2 #= RY1 + RV - Rv)),
		RH2 in 0..FloorH,
		RH2 #= RH - Rh,
		RX2 + RH2 #=< FloorH,
		RY2 + Rv #=< FloorV,
		RH * RV1 + RH2 * Rv #=< MaxSurf,
		RH * RV1 + RH2 * RV #>= MinSurf,
		W = [[RX1, RH, RY1, RV1], [RX2, RH2, RY2, Rv]]
	),
	Z = spaceVar(Id, RH, Rh, RV, Rv, _, W, Name).