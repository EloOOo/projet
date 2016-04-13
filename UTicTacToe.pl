:- set_prolog_flag(toplevel_print_options,[max_depth(0)]).

% l = libre
%plateau([[d,[l,l,l,l,l,l,l,l,l]], [d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]]]).

symbole(x).
symbole(o).
libre(l).

winSousPlateau([S,S,S,_,_,_,_,_,_],S).
winSousPlateau([_,_,_,S,S,S,_,_,_],S).
winSousPlateau([_,_,_,_,_,_,S,S,S],S).
winSousPlateau([S,_,_,S,_,_,S,_,_],S).
winSousPlateau([_,S,_,_,S,_,_,S,_],S).
winSousPlateau([_,_,S,_,_,S,_,_,S],S).
winSousPlateau([S,_,_,_,S,_,_,_,S],S).
winSousPlateau([_,_,S,_,S,_,S,_,_],S).

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

inverse(L,S):-
        inverse(L,[],S).

inverse([],Acc,Acc).
inverse([X|L],Acc,S):-
        inverse(L,[X|Acc],S).

remplace([],_,Acc,Acc).
remplace([l|T],S,Acc,L):-
        symbole(S),
        remplace(T,S,[S|Acc],L).
remplace([o|T],S,Acc,L):-
        remplace(T,S,[o|Acc],L).
remplace([x|T],S,Acc,L):-
        remplace(T,S,[x|Acc],L).     

comptLignePG(Sp,S,Cout) :- % compte ligne possiblement/probablement/potentiellement gagnable
        symbole(S),
        remplace(Sp,S,[],Li),
        inverse(Li,[],L),
        findall(Cout, winSousPlateau(L,S), R),
        length(R,Cout).
        
evalSousPlateauMoi(Sp,SJ1,SJ2,Cout):-
        symbole(SJ1),
        symbole(SJ2),
        comptLignePG(Sp,SJ1,Cout1),
        comptLignePG(Sp,SJ2,Cout2),
        Cout is Cout1 - Cout2.

evalSousPlateauLui(Sp,SJ1,SJ2,Cout):-
        symbole(SJ1),
        symbole(SJ2),
        comptLignePG(Sp,SJ1,Cout1),
        comptLignePG(Sp,SJ2,Cout2),
        Cout is Cout2 - Cout1.
