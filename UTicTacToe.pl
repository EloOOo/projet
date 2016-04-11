:- set_prolog_flag(toplevel_print_options,[max_depth(0)]).

% l = libre
%plateau([[d,[l,l,l,l,l,l,l,l,l]], [d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]]]).

sousPlateau([l,l,l,l,l,l,l,l,l]).
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

move([[l,B,C,D,E,F,G,H,I],_], S, J,[[S,B,C,D,E,F,G,H,I],Cout]):-
        evalSousPlateau([S,B,C,D,E,F,G,H,I],S,J,Cout).
move([[A,l,C,D,E,F,G,H,I],_], S, J,[[A,S,C,D,E,F,G,H,I],Cout]):-
        evalSousPlateau([A,S,C,D,E,F,G,H,I],S,J,Cout).
move([[A,B,l,D,E,F,G,H,I],_], S, J,[[A,B,S,D,E,F,G,H,I],Cout]):-
        evalSousPlateau([A,B,S,D,E,F,G,H,I],S,J,Cout).
move([[A,B,C,l,E,F,G,H,I],_], S, J,[[A,B,C,S,E,F,G,H,I],Cout]):-
        evalSousPlateau([A,B,C,S,E,F,G,H,I],S,J,Cout).
move([[A,B,C,D,l,F,G,H,I],_], S, J,[[A,B,C,D,S,F,G,H,I],Cout]):-
        evalSousPlateau([A,B,C,D,S,F,G,H,I],S,J,Cout).
move([[A,B,C,D,E,l,G,H,I],_], S, J,[[A,B,C,D,E,S,G,H,I],Cout]):-
        evalSousPlateau([A,B,C,D,E,S,G,H,I],S,J,Cout).
move([[A,B,C,D,E,F,l,H,I],_], S, J,[[A,B,C,D,E,F,S,H,I],Cout]):-
        evalSousPlateau([A,B,C,D,E,F,S,H,I],S,J,Cout).
move([[A,B,C,D,E,F,G,l,I],_], S, J,[[A,B,C,D,E,F,G,S,I],Cout]):-
        evalSousPlateau([A,B,C,D,E,F,G,S,I],S,J,Cout).
move([[A,B,C,D,E,F,G,H,l],_], S, J,[[A,B,C,D,E,F,G,H,S],Cout]):-
        evalSousPlateau([A,B,C,D,E,F,G,H,S],S,J,Cout).

adversaire(x,o).
adversaire(o,x).

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
        
evalSousPlateau(Sp,SNous,J,Cout):-
        symbole(SNous),
        adversaire(SNous,SJ2),
        comptLignePG(Sp,SNous,Cout1),
        comptLignePG(Sp,SJ2,Cout2),
        formuleEval(Cout1,Cout2,J,Cout).

formuleEval(Cout1,Cout2,0,Cout):-
        Cout is Cout1 - Cout2.
formuleEval(Cout1,Cout2,1,Cout):-
        Cout is Cout2 - Cout1.

concatene([],L,L).
concatene([X|L1],L2,R):-
        concatene(L1,[X|L2],R).

etageSuivant([],_,_,Acc,Acc).
etageSuivant([Sp|P],S,J,Acc,LLR) :-
        placer(Sp,S,J,R),
        append(R,Acc,NAcc),
        etageSuivant(P,S,J,NAcc,LLR).

placer([Sp|Cout],S,J,R):- % possibilité nonmember plus tard 
        findall([L,Sp|Cout],move(Sp,S,J,L),R).

        
etatFinal([[[Sp,Cout]|LSp]|_],S,[[Sp,Cout]|LSp]) :-
        winSousPlateau(Sp,S).
etatFinal([_|LL],S,R) :-
        etatFinal(LL,S,R).

largeur([],_, _,_) :-
        !,fail.
largeur(LL,S,_, LR) :-
        etatFinal(LL,S,LR).                  
largeur(Sp,S,J,LR) :-
        etageSuivant(Sp,S,J,[],LL2),
        J1 is 1-J,
        adversaire(S,A),
        largeur(LL2,A,J1,LR). 
pl(S,L) :-
        sousPlateau(Sp),
        evalSousPlateau(Sp,S,0,Cout),
        largeur([[[Sp,Cout]]],S,0, Los),
        inverse(Los,L).

algo(P,SNous) :-
        write(SNous),
        write(P).

          