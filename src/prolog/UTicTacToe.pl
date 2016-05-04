:- set_prolog_flag(toplevel_print_options,[max_depth(0)]).
:- use_module(library(lists)).
% l = libre
%plateau([[d,[l,l,l,l,l,l,l,l,l]], [d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]]]).
%plateau([[d,[l,l,l,x,l,x,l,l,l]], [d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]]]).
plateauSimple([l,l,l,o,l,o,l,l,l]).
plateau([[l,l,l,x,l,x,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,o,l,o,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l]]).
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

movePos([l,B,C,D,E,F,G,H,I], S,[S,B,C,D,E,F,G,H,I],1).
movePos([A,l,C,D,E,F,G,H,I], S,[A,S,C,D,E,F,G,H,I],2).
movePos([A,B,l,D,E,F,G,H,I], S,[A,B,S,D,E,F,G,H,I],3).
movePos([A,B,C,l,E,F,G,H,I], S,[A,B,C,S,E,F,G,H,I],4).
movePos([A,B,C,D,l,F,G,H,I], S,[A,B,C,D,S,F,G,H,I],5).
movePos([A,B,C,D,E,l,G,H,I], S,[A,B,C,D,E,S,G,H,I],6).
movePos([A,B,C,D,E,F,l,H,I], S,[A,B,C,D,E,F,S,H,I],7).
movePos([A,B,C,D,E,F,G,l,I], S,[A,B,C,D,E,F,G,S,I],8).
movePos([A,B,C,D,E,F,G,H,l], S,[A,B,C,D,E,F,G,H,S],9).

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

% alphaBeta(6,[x,l,o,l,l,x,l,o,l],x,-10000,10000,Move,_).
% alphaBeta(6,[l,l,o,x,l,x,l,o,l],x,-10000,10000,Move,Cout,PosS).

% l'adversaire gagne on s'arrete
alphaBeta(_,Sp,S,_,_,0,_,-1000,posS):-
        adversaire(S,A),
        winSousPlateau(Sp,A).
% lors de l'appel Alpha = Tres Grand nb et Beta tres petit (100 et -100)
alphaBeta(Prof,Sp,S, Alpha,Beta,Move,LMove,Cout,PosS):- 
        Prof > 0,
        bestMoves(Sp,S,LMove,PosS),
        LMove = [_|_], !, % on vï¿½rifie si la liste contient 1 seul ï¿½lï¿½ment ou +
        Prof1 is Prof- 1,
        Alpha1 is -Beta,
        Beta1 is -Alpha,
        meilleurChoix(LMove, Sp, S,Prof1, Alpha1, Beta1, 0, Move, Cout,PosS).
alphaBeta(_, Sp, S, _, _, 0,_, Cout,posS):-
        value(Sp, S,Cout).

%Verifier si un coup ne fais pas gagner l'adversaire au TicTacToe
%identifier le SP ou l'adversaire va jouer -> OK
%Faire jouer l'adversaire dans ce SP
%Si coup adverse provoque victoire adverse -> nouveau coup de nous
%Sinon on garde notre coup
%testCoup(Plateau,PlateauSimple,6,[l,l,o,x,l,x,l,o,l],x,-10000,10000,Move,LMove,Cout,PosS).
/*testCoup(Plateau,PlateauSimple,Prof,Sp,S, Alpha,Beta,Move,LMove,Cout,PosS,Nb):-
       Nb > 0,
       findall(Move, movePos(Sp,S,Move,PosS), LstMove),
       meilleurChoix(LstMove, Sp, S, Prof, Alpha, Beta, Move0, Move1, Value1,_),
       alphaBeta(Prof,Sp,S, Alpha,Beta,Move0,LMove,Cout,PosS),
*/

%testSPDispo([l,l,l,o,l,o,l,l,l],5,Res).
%test si le SP ou on doit joué est déjà gagné
testSPDispo(Sps,PosSP,0):-
         nth1(PosSP, Sps, S),
         S = l.
          
% 1 = SP Gagné         
testSPDispo(Sps,PosSP,1):-
         nth1(PosSP, Sps, S),
         S \= l.
       

                    
               
       
       
       
        
        

testCoup(Plateau,PlateauSimple,Prof,Sp,S, Alpha,Beta,Move,LMove,Cout,PosS,0):-
        alphaBeta(Prof,Sp,S, Alpha,Beta,Move,LMove,Cout,PosS),
        %recup P , puis le SP posS
        plateau(Plateau),
        plateauSimple(PlateauSimple),
        recupSPdansP(PosS,Plateau,SpAdv),
        adversaire(S,A),
        alphaBeta(Prof,SpAdv,A, Alpha,Beta,Move2,_,_,_),
        %move2 gagnant mettre à jour le PlateauSimple, tester si c'est gagnant pour adv
        winSousPlateau(Move2,A),
        movePos(PlateauSimple, A,NPS,PosS),
        write(NPS),
        winSousPlateau(NPS,A),
        testCoup(Plateau,PlateauSimple,Prof,Sp,S, Alpha,Beta,Move,LMove,Cout,PosS,1).
        
recupSPdansP(PosS,P,SP):-
        nth1(PosS, P, SP).   
   
/*majPlateauSimple(_,0,S,Acc,NP).         
majPlateauSimple([H|Rs],PosS,S,Acc,NP):-
        Pos1 is PosS-1,
        majPlateauSimple(Rs,Pos1,S,[H|Acc],NP).*/
        
        
        

                
meilleurChoix([H|T], Sp, S, Prof, Alpha, Beta, Move0, Move1, Cout1,PosS):-
        %move(Sp, S, NewSp), !,
        movePos(Sp, S, NewSp,PosS), !,
        adversaire(S,A),
        alphaBeta(Prof, NewSp, A, Alpha, Beta, _,_, CoutMin,posS),
        Cout is -CoutMin,
        cutoff(H, Cout, Prof, Alpha, Beta, T, Sp, S, Move0, Move1, Cout1).
meilleurChoix([], _, _, _, Alpha, _, Move, Move, Alpha,_).

cutoff(_, Cout, Prof, Alpha, Beta, LstMove, Sp, S, Move0, Move1, Value1):-
        Cout =< Alpha, !,
        meilleurChoix(LstMove, Sp, S, Prof, Alpha, Beta, Move0, Move1, Value1,_).
cutoff(Move, Cout, Prof, _, Beta, LstMove, Sp, S, _, Move1, Value1):-
        Cout < Beta, !,
        meilleurChoix(LstMove, Sp, S, Prof, Cout, Beta, Move, Move1, Value1,_).
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

% Dï¿½placement gagnant
bestMoves(Sp,S,[Move],PosS):-
        %move(Sp,S,Move),
        movePos(Sp,S,Move,PosS),
        winSousPlateau(Move,S), !.
% Si l'adversaire peut gagner avec ce move on l'empeche
bestMoves(Sp,S,[Move],PosS):-
        adversaire(S,A),
        movePos(Sp, A,Move2,PosS),
        winSousPlateau(Move2,A),
        premiereDiff(Sp,Move2,I),
        remplaceOcc(Sp,I,S,Move),!.
bestMoves(Sp,S,LstMove,PosS):-
        findall(Move, movePos(Sp,S,Move,PosS), LstMove).

value(Sp, S,-1000):-
        adversaire(S,A),    
        winSousPlateau(Sp,A), !.
value(Sp, S,Cout):-
        adversaire(S,A),
        evalSousPlateau(Sp,S,0,CoutJ),
        evalSousPlateau(Sp,A,1,CoutA),
        Cout is 2 * CoutJ  - CoutA.

testJavaMove(5).
testJavaCase(6).
%Si num = 0 -->jouer partout -->1er coup croix
%PlatU ->plateau complet
%Sps ->plateau simple
%num ->num du SP ou joué
%SpPlay ->num du SP ou prolog à joué
%CasePlay ->num de la case joué dans le SP

%testJava([[l,l,l,x,l,x,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,o,l,o,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l]],[l,x,l,l,l,l,l,l,l],1,x,SpPlay,CasePlay,L).
%testJava([[x,x,x,x,x,x,x,x],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,o,l,o,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l]],[x,l,x,x,x,x,x,x,x],1,x,SpPlay,CasePlay,L).
/*testJava(PlatU,Sps,0,S,SpPlay,CasePlay,NbSPG) :-
        %gestion du parcours des SP libre
        write(PlatU),nl,write(Sps),nl,write(S),nl,write(0),
        testJavaMove(SpPlay),testJavaCase(CasePlay).*/

%le SP donné est libre
testJava(PlatU,Sps,Num,S,SpPlay,CasePlay,NbSPG) :-
        testSPDispo(Sps,Num,Libre),
        Libre is 0,
        SpPlay is Num,
        nth1(Num, PlatU, Sp),
        alphaBeta(6,Sp,S, -10000,10000,Move,_,_,CasePlay),
        winSousPlateau(Move,S),
        movePos(Sps,S,Nps,SpPlay),
        compteSPG(Nps,S,NbSPG);
        testSPDispo(Sps,Num,Libre),
        Libre is 0,
        SpPlay is Num,
        nth1(Num, PlatU, Sp),
        alphaBeta(6,Sp,S, -10000,10000,_,_,_,CasePlay),
        compteSPG(Sps,S,NbSPG).

%le SP donné est gagné ou nulle -> il faut jouer dans un autre SP (libre)
testJava(PlatU,Sps,Num,S,SpPlay,CasePlay,NbSPG) :-
        testSPDispo(Sps,Num,Libre),
        Libre is 1,
        trouveSPLibre(Sps,SpPlay),
        nth1(SpPlay, PlatU, Sp),
        alphaBeta(6,Sp,S, -10000,10000,Move,_,_,CasePlay),
        winSousPlateau(Move,S),
        movePos(Sps,S,Nps,SpPlay),
        compteSPG(Nps,S,NbSPG);
        testSPDispo(Sps,Num,Libre),
        Libre is 1,
        trouveSPLibre(Sps,SpPlay),
        nth1(SpPlay, PlatU, Sp),
        alphaBeta(6,Sp,S, -10000,10000,_,_,_,CasePlay),
        compteSPG(Sps,S,NbSPG).
        

%trouveSPLibre([l,x,o,l,l,l,l,l,l],PosSp).
trouveSPLibre([],1).
trouveSPLibre([Symbole|_],PosSp):-
        Symbole = l,
        trouveSPLibre([],PosSp),!.
trouveSPLibre([_|R],PosSp1):-
        trouveSPLibre(R,PosSp),
        PosSp1 is PosSp+1.
 
%compteSPG([x,x,x,l,l,l,l,l,l],_,NbSPG).
compteSPG([],_,0).
compteSPG([Symbole|R],S,PosSp1):-
        Symbole = S,
        compteSPG(R,S,PosSp),
        PosSp1 is PosSp+1.
compteSPG([_|R],S,PosSp):-
        compteSPG(R,S,PosSp).       
                    
/*compte([],0):-!.
compte([S|X],S,Y):-
    compte(X,S,D),
    Y is D+1.
compte([c|X],S,Y):-
    compte(X,Y).*/   
