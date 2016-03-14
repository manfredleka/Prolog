% SVG WRITER
:- use_module(library(writef)).

writeSvg(SpaceVarList, FloorSpaceVar):-
	open('solution.svg', write, Stream),
	initSvg(Stream),
	getCoordinates(FloorSpaceVar, [[_, FloorH, _ , FloorV],[]]),
	printSpaceVar(SpaceVarList, Stream, [FloorH, FloorV]),
	closeSvg(Stream).

initSvg(Stream):-
	write(Stream, '<?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"><svg width="800" height="600" version="1.1" xmlns="http://www.w3.org/2000/svg"><title>Solution to Floor Planning Problem</title>'),
	nl(Stream).

closeSvg(Stream):-
	nl(Stream),
	write(Stream, '</svg>'),
	close(Stream).

printSpaceVar([], _, _).

printSpaceVar([SpaceVar | SpaceVarList], Stream, FloorHV):-
	printSpaceVar(SpaceVarList, Stream, FloorHV),
	getCoordinates(SpaceVar, [Room1Coord, Room2Coord]),
	draw_rectangle(Room1Coord, Stream, FloorHV),
	draw_rectangle(Room2Coord, Stream, FloorHV).

draw_rectangle([], _, _).

draw_rectangle([X, H, Y, V], Stream, [FloorH, FloorV]):-
	Xsvg is (div(800, FloorH) * X),
	Ysvg is (div(600, FloorV) * Y),
	WidthSvg is (H * div(FloorH, 800)),
	HeightSvg is (V * div(FloorV, 600)),
	swritef(A, '<rect x="%t" y="%t" width="%t" height="%t" rx="0" style="fill:grey; border: 1px solid black"/>', [Xsvg, Ysvg, WidthSvg, HeightSvg]),
	write(Stream, A),
	nl(Stream).





