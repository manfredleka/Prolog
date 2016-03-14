% SVG WRITER



initSvg(Stream):-
	write(Stream, '<?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"><svg width="800" height="600" version="1.1" xmlns="http://www.w3.org/2000/svg"><title>Solution to Floor Planning Problem</title>'),
	nl(Stream).

closeSvg(Stream):-
	nl(Stream),
	write(Stream, '</svg>'),
	close(Stream).

printSpaceVar([], _).

printSpaceVar([SpaceVar | SpaceVarList], Stream):-
	printSpaceVar(SpaceVarList, Stream),
	ColorList = [red, blue, green, yellow, grey, brown, orange, purple],
	random_member(Color, ColorList),
	getCoordinates(SpaceVar, [Room1Coord, Room2Coord]),
	draw_rectangle(Room1Coord, Color, Stream),
	(Room2 =\= [] -> draw_rectangle(Room2Coord, Color, Stream)).



