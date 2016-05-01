:- set_prolog_flag(toplevel_print_options,[max_depth(0)]).

% l = libre
%plateau([[d,[l,l,l,l,l,l,l,l,l]], [d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]]]).

sousPlateau([l,l,l,l,l,l,l,l,l]).
symbole(x).
symbole(o).
libre(l).

%verifie si SP gagnant
winSousPlateau([S,S,S,_,_,_,_,_,_],S).
winSousPlateau([_,_,_,S,S,S,_,_,_],S).
winSousPlateau([_,_,_,_,_,_,S,S,S],S).
winSousPlateau([S,_,_,S,_,_,S,_,_],S).
winSousPlateau([_,S,_,_,S,_,_,S,_],S).
winSousPlateau([_,_,S,_,_,S,_,_,S],S).
winSousPlateau([S,_,_,_,S,_,_,_,S],S).
winSousPlateau([_,_,S,_,S,_,S,_,_],S).

%verifie si P gagnant
winPlateau([[S,_], [S,_],[S,_],[_,_],[_,_],[_,_],[_,_],[_,_],[_,_]]):-!.
winPlateau([[_,_], [_,_],[_,_],[S,_],[S,_],[S,_],[_,_],[_,_],[_,_]]):-!.
winPlateau([[_,_], [_,_],[_,_],[_,_],[_,_],[_,_],[S,_],[S,_],[S,_]]):-!.
winPlateau([[S,_], [_,_],[_,_],[S,_],[_,_],[_,_],[S,_],[_,_],[_,_]]):-!.
winPlateau([[_,_], [S,_],[_,_],[_,_],[S,_],[_,_],[_,_],[S,_],[_,_]]):-!.
winPlateau([[_,_], [_,_],[S,_],[_,_],[_,_],[S,_],[_,_],[_,_],[S,_]]):-!.
winPlateau([[S,_], [_,_],[_,_],[_,_],[S,_],[_,_],[_,_],[_,_],[S,_]]):-!.
winPlateau([[_,_], [_,_],[S,_],[_,_],[S,_],[_,_],[S,_],[_,_],[_,_]]):-!.

%Placements possibles d'un symbole dans SP
moveP([[l,B,C,D,E,F,G,H,I],_], S, J,[[S,B,C,D,E,F,G,H,I],Cout]):-
        evalSousPlateau([S,B,C,D,E,F,G,H,I],S,J,Cout).
moveP([[A,l,C,D,E,F,G,H,I],_], S, J,[[A,S,C,D,E,F,G,H,I],Cout]):-
        evalSousPlateau([A,S,C,D,E,F,G,H,I],S,J,Cout).
moveP([[A,B,l,D,E,F,G,H,I],_], S, J,[[A,B,S,D,E,F,G,H,I],Cout]):-
        evalSousPlateau([A,B,S,D,E,F,G,H,I],S,J,Cout).
moveP([[A,B,C,l,E,F,G,H,I],_], S, J,[[A,B,C,S,E,F,G,H,I],Cout]):-
        evalSousPlateau([A,B,C,S,E,F,G,H,I],S,J,Cout).
moveP([[A,B,C,D,l,F,G,H,I],_], S, J,[[A,B,C,D,S,F,G,H,I],Cout]):-
        evalSousPlateau([A,B,C,D,S,F,G,H,I],S,J,Cout).
moveP([[A,B,C,D,E,l,G,H,I],_], S, J,[[A,B,C,D,E,S,G,H,I],Cout]):-
        evalSousPlateau([A,B,C,D,E,S,G,H,I],S,J,Cout).
moveP([[A,B,C,D,E,F,l,H,I],_], S, J,[[A,B,C,D,E,F,S,H,I],Cout]):-
        evalSousPlateau([A,B,C,D,E,F,S,H,I],S,J,Cout).
moveP([[A,B,C,D,E,F,G,l,I],_], S, J,[[A,B,C,D,E,F,G,S,I],Cout]):-
        evalSousPlateau([A,B,C,D,E,F,G,S,I],S,J,Cout).
moveP([[A,B,C,D,E,F,G,H,l],_], S, J,[[A,B,C,D,E,F,G,H,S],Cout]):-
        evalSousPlateau([A,B,C,D,E,F,G,H,S],S,J,Cout).


move([l,B,C,D,E,F,G,H,I], S,[S,B,C,D,E,F,G,H,I]).
move([A,l,C,D,E,F,G,H,I], S,[A,S,C,D,E,F,G,H,I]).
move([A,B,l,D,E,F,G,H,I], S,[A,B,S,D,E,F,G,H,I]).
move([A,B,C,l,E,F,G,H,I], S,[A,B,C,S,E,F,G,H,I]).
move([A,B,C,D,l,F,G,H,I], S,[A,B,C,D,S,F,G,H,I]).
move([A,B,C,D,E,l,G,H,I], S,[A,B,C,D,E,S,G,H,I]).
move([A,B,C,D,E,F,l,H,I], S,[A,B,C,D,E,F,S,H,I]).
move([A,B,C,D,E,F,G,l,I], S,[A,B,C,D,E,F,G,S,I]).
move([A,B,C,D,E,F,G,H,l], S,[A,B,C,D,E,F,G,H,S]).

%Changement de joueur
adversaire(x,o).
adversaire(o,x).

%test si le plateau est gagne
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

%inverse une liste
inverse(L,S):-
        inverse(L,[],S).
inverse([],Acc,Acc).
inverse([X|L],Acc,S):-
        inverse(L,[X|Acc],S).

%remplace toute les cases libres d'un SP par un symbole
remplace([],_,Acc,Acc).
remplace([l|T],S,Acc,L):-
        symbole(S),
        remplace(T,S,[S|Acc],L).
remplace([o|T],S,Acc,L):-
        remplace(T,S,[o|Acc],L).
remplace([x|T],S,Acc,L):-
        remplace(T,S,[x|Acc],L).     

% compte ligne potentiellement gagnable
comptLignePG(Sp,S,Cout) :- 
        symbole(S),
        remplace(Sp,S,[],Li),
        inverse(Li,[],L),
        findall(Cout, winSousPlateau(L,S), R),length(R,Cout).

%Evalue un SP pour un symbole        
evalSousPlateau(Sp,SNous,J,Cout):-
        symbole(SNous),
        adversaire(SNous,SJ2),
        comptLignePG(Sp,SNous,Cout1),
        comptLignePG(Sp,SJ2,Cout2),
        formuleEval(Cout1,Cout2,J,Cout).

%Calcul de l'evaluation d'un SP
formuleEval(Cout1,Cout2,0,Cout):-
        Cout is Cout1 - Cout2.
formuleEval(Cout1,Cout2,1,Cout):-
        Cout is Cout2 - Cout1.

concatene([],L,L).
concatene([X|L1],L2,R):-
        concatene(L1,[X|L2],R).

%Test si dans un liste de coup l'un d'eux est gagnant    
etatFinal([[[Sp,Cout]|LSp]|_],S,[[Sp,Cout]|LSp]) :-
        winSousPlateau(Sp,S).
etatFinal([_|LL],S,R) :-
        etatFinal(LL,S,R).

profondeur(SP,S,_,_,_,LR) :-
         etatFinal(SP,S,LR),!.

profondeur([[SP|P]],S,J,Max,Sol) :-
        /*Max> 0,*/
        Max1 is Max- 1,
        moveP(SP,S,J,R),
        nonmember(R,P),
        verifSPGagnantP([[R|[SP|P]]],S,J,Max1,Sol).

parcoursProfondeur(S,L,Max) :-
        sousPlateau(Sp),
        evalSousPlateau(Sp,S,0,Cout),
        profondeur([[[Sp,Cout]]],S,0,Max,Los),
        inverse(Los,L).
 
verifSPGagnantP(LL,S,_,_,LR):-
         etatFinal(LL,S,LR).
verifSPGagnantP(LL,S,J,Max,LR):-
        J1 is 1-J,
        adversaire(S,A),
        profondeur(LL,A,J1,Max,LR).  

%tentative a completer
decrProfondeur(P1,P2) :- P2 is P1-1.

testProfondeur(P,_,_) :- 
        P == 0 ; 
        etatFinal(P,_,_).

% alphabeta(6,[x,l,o,l,l,x,l,o,l],x,-10000,10000,Move,_).

% l'adversaire gagne on s'arrete
alphaBeta(_,Sp,S,_,_,0,-1000):-
        adversaire(S,A),
        winSousPlateau(Sp,A).
% lors de l'appel Alpha = Tres Grand nb et Beta tres petit (100 et -100)
alphaBeta(Prof,Sp,S, Alpha,Beta,Move,Cout):- 
        Prof > 0,
        bestMoves(Sp,S,LMove),
        LMove = [_|_], !, % on v�rifie si la liste contient 1 seul �l�ment ou +
        Prof1 is Prof- 1,
        Alpha1 is -Beta,
        Beta1 is -Alpha,
        meilleurChoix(LMove, Sp, S,Prof1, Alpha1, Beta1, 0, Move, Cout).
alphaBeta(_, Sp, S, _, _, 0, Cout):-
        value(Sp, S,Cout).
                
meilleurChoix([H|T], Sp, S, Prof, Alpha, Beta, Move0, Move1, Cout1):-
        move(Sp, S, NewSp), !,
        adversaire(S,A),
        alphaBeta(Prof, NewSp, A, Alpha, Beta, _, CoutMin),
        Cout is -CoutMin,
        cutoff(H, Cout, Prof, Alpha, Beta, T, Sp, S, Move0, Move1, Cout1).
meilleurChoix([], _, _, _, Alpha, _, Move, Move, Alpha).

cutoff(_, Cout, Prof, Alpha, Beta, LstMove, Sp, S, Move0, Move1, Value1):-
        Cout =< Alpha, !,
        meilleurChoix(LstMove, Sp, S, Prof, Alpha, Beta, Move0, Move1, Value1).
cutoff(Move, Cout, Prof, _, Beta, LstMove, Sp, S, _, Move1, Value1):-
        Cout < Beta, !,
        meilleurChoix(LstMove, Sp, S, Prof, Cout, Beta, Move, Move1, Value1).
cutoff(Move, Cout, _, _, _, _, _, _, _, Move, Cout).

premiereDiff([_|T], [_|T], 0):- !.
premiereDiff([H|T], [H|T2], Index):-
        premiereDiff(T, T2, Index1),
        !,
        Index is Index1+1.

remplaceOcc([_|T], 0, X, [X|T]).
remplaceOcc([H|T], I, X, [H|R]):- 
        I > -1, 
        NI is I-1, 
        remplaceOcc(T, NI, X, R), !.
remplaceOcc(L, _, _, L).

% D�placement gagnant
bestMoves(Sp,S,[Move]):-
        move(Sp,S,Move),
        winSousPlateau(Move,S), !.
% Si l'adversaire peut gagner avec ce move on l'empeche
bestMoves(Sp,S,[Move]):-
        adversaire(S,A),
        move(Sp, A,Move2),
        winSousPlateau(Move2,A),
        premiereDiff(Sp,Move2,I),
        remplaceOcc(Sp,I,S,Move),!.
bestMoves(Sp,S,LstMove):-
        findall(Move, move(Sp,S,Move), LstMove).

value(Sp, S,-1000):-
        adversaire(S,A),    
        winSousPlateau(Sp,A), !.
value(Sp, S,Cout):-
        adversaire(S,A),
        evalSousPlateau(Sp,S,0,CoutJ),
        evalSousPlateau(Sp,A,1,CoutA),
        Cout is 2 * CoutJ  - CoutA.
