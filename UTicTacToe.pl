:- set_prolog_flag(toplevel_print_options,[max_depth(0)]).

%plateau([[d,[1,2,3,4,5,6,7,8,9]], [d,[1,2,3,4,5,6,7,8,9]],[d,[1,2,3,4,5,6,7,8,9]],[d,[1,2,3,4,5,6,7,8,9]],[d,[1,2,3,4,5,6,7,8,9]],[d,[1,2,3,4,5,6,7,8,9]],[d,[1,2,3,4,5,6,7,8,9]],[d,[1,2,3,4,5,6,7,8,9]],[d,[1,2,3,4,5,6,7,8,9]]]).

symbole(x).
symbole(o).

winSousPlateau([S,S,S,_,_,_,_,_,_],S):-!.
winSousPlateau([_,_,_,S,S,S,_,_,_],S):-!.
winSousPlateau([_,_,_,_,_,_,S,S,S],S):-!.
winSousPlateau([S,_,_,S,_,_,S,_,_],S):-!.
winSousPlateau([_,S,_,_,S,_,_,S,_],S):-!.
winSousPlateau([_,_,S,_,_,S,_,_,S],S):-!.
winSousPlateau([S,_,_,_,S,_,_,_,S],S):-!.
winSousPlateau([_,_,S,_,S,_,S,_,_],S):-!.

winPlateau([[S,_], [S,_],[S,_],[_,_],[_,_],[_,_],[_,_],[_,_],[_,_]]):-!.
winPlateau([[_,_], [_,_],[_,_],[S,_],[S,_],[S,_],[_,_],[_,_],[_,_]]):-!.
winPlateau([[_,_], [_,_],[_,_],[_,_],[_,_],[_,_],[S,_],[S,_],[S,_]]):-!.
winPlateau([[S,_], [_,_],[_,_],[S,_],[_,_],[_,_],[S,_],[_,_],[_,_]]):-!.
winPlateau([[_,_], [S,_],[_,_],[_,_],[S,_],[_,_],[_,_],[S,_],[_,_]]):-!.
winPlateau([[_,_], [_,_],[S,_],[_,_],[_,_],[S,_],[_,_],[_,_],[S,_]]):-!.
winPlateau([[S,_], [_,_],[_,_],[_,_],[S,_],[_,_],[_,_],[_,_],[S,_]]):-!.
winPlateau([[_,_], [_,_],[S,_],[_,_],[S,_],[_,_],[S,_],[_,_],[_,_]]):-!.

win(S,Plateau):-
        symbole(S),
        winPlateau(Plateau).

aGagnant(P,x):-
        win(x,P).
aGagnant(P,o):-
        win(o,P).

spPlein([]).
spPlein([H|T]):-
        symbole(H),
        spPlein(T). 

algo(P) :-
        write(P).
