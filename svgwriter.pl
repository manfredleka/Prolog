% SVG WRITER

writeSvg(SpaceVarList, FloorSpaceVar):-
	open('solution.svg', write, Stream),
	initSvg(Stream),
	getCoordinates(FloorSpaceVar, [_, FloorH, _ , FloorV]),
	ColorList = [red, blue, green, yellow, grey, brown, orange, purple],
	printSpaceVar(SpaceVarList, Stream, [FloorH, FloorV], ColorList),
	closeSvg(Stream).

initSvg(Stream):-
	write(Stream, '<?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"><svg width="800" height="600" version="1.1" xmlns="http://www.w3.org/2000/svg"><title>Solution to Floor Planning Problem</title>'),
	nl(Stream).

closeSvg(Stream):-
	nl(Stream),
	write(Stream, '</svg>'),
	close(Stream).

printSpaceVar([], _, _, _).

printSpaceVar([SpaceVar | SpaceVarList], Stream, FloorHV, ColorList):-
	printSpaceVar(SpaceVarList, Stream, FloorHV, ColorList),
	random_member(Color, ColorList),
	getCoordinates(SpaceVar, [Room1Coord, Room2Coord]),
	draw_rectangle(Room1Coord, Color, Stream, FloorHV),
	draw_rectangle(Room2Coord, Color, Stream, FloorHV).

draw_rectangle([], _, _, _).

draw_rectangle([X, H, Y, V], Color, Stream, [FloorH, FloorV]):-
	Xsvg is (div(800, FloorH) * X),
	Ysvg is (div(600, FloorV) * Y),
	WidthSvg is (H * div(FloorH, 800)),
	HeightSvg is (V * div(FloorV, 600)),
	write(Stream, format('<rect x="~d" y="~d" width="~d" height="~d" rx="0" style="fill:~d"/>', [Xsvg, Ysvg, WidthSvg, HeightSvg, Color])).





