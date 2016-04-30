:- set_prolog_flag(toplevel_print_options,[max_depth(0)]).

% l = libre
%plateau([[d,[l,l,l,l,l,l,l,l,l]], [d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]]]).

sousPlateau([l,l,l,l,l,l,l,l,l]).
symbole(x).
symbole(o).
libre(l).

%vérifie si SP gagnant
winSousPlateau([S,S,S,_,_,_,_,_,_],S).
winSousPlateau([_,_,_,S,S,S,_,_,_],S).
winSousPlateau([_,_,_,_,_,_,S,S,S],S).
winSousPlateau([S,_,_,S,_,_,S,_,_],S).
winSousPlateau([_,S,_,_,S,_,_,S,_],S).
winSousPlateau([_,_,S,_,_,S,_,_,S],S).
winSousPlateau([S,_,_,_,S,_,_,_,S],S).
winSousPlateau([_,_,S,_,S,_,S,_,_],S).

%vérifie si P gagnant
winPlateau([[S,_], [S,_],[S,_],[_,_],[_,_],[_,_],[_,_],[_,_],[_,_]]):-!.
winPlateau([[_,_], [_,_],[_,_],[S,_],[S,_],[S,_],[_,_],[_,_],[_,_]]):-!.
winPlateau([[_,_], [_,_],[_,_],[_,_],[_,_],[_,_],[S,_],[S,_],[S,_]]):-!.
winPlateau([[S,_], [_,_],[_,_],[S,_],[_,_],[_,_],[S,_],[_,_],[_,_]]):-!.
winPlateau([[_,_], [S,_],[_,_],[_,_],[S,_],[_,_],[_,_],[S,_],[_,_]]):-!.
winPlateau([[_,_], [_,_],[S,_],[_,_],[_,_],[S,_],[_,_],[_,_],[S,_]]):-!.
winPlateau([[S,_], [_,_],[_,_],[_,_],[S,_],[_,_],[_,_],[_,_],[S,_]]):-!.
winPlateau([[_,_], [_,_],[S,_],[_,_],[S,_],[_,_],[S,_],[_,_],[_,_]]):-!.

%Placements possibles d'un symbole dans SP
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

%Changement de joueur
adversaire(x,o).
adversaire(o,x).

%test si le plateau est gagné
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

%Calcul de l'évaluation d'un SP
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
        move(SP,S,J,R),
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

%tentative à completer
decrProfondeur(P1,P2) :- P2 is P1-1.

testProfondeur(P,_,_) :- 
        P == 0 ; 
        etatFinal(P,_,_).
/*

alphabeta([],_,_,_,_,_,_,_).

alphabeta([E|L],1,P,A,B,Meilleur,V,IA) :-
        testProfondeur(P,E,1), % Feuille atteinte ou fin de partie
        heur(E,1,ValE,IA), % Evaluation de la position dans ValE
        ((A=<ValE, % Evaluation meilleure
          alphabeta(L,1,P,A,B,MeilleurL,ValL,IA),
          recordMin(ValE,ValL,E,MeilleurL,Meilleur,V))
         ;
         copie(E,ValE,Meilleur,V)). % Memorisation du meilleu*/