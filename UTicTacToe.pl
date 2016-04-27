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
        findall(Cout, winSousPlateau(L,S), R),length(R,Cout).
        
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

placer([Sp|Cout],S,J,R):- % possibilite nonmember plus tard 
        findall([L,Sp|Cout],move(Sp,S,J,L),R).

        
etatFinal([[[Sp,Cout]|LSp]|_],S,[[Sp,Cout]|LSp]) :-
        winSousPlateau(Sp,S).
etatFinal([_|LL],S,R) :-
        etatFinal(LL,S,R).

largeur([],_, _,_) :-
        !,fail.

largeur(Sp,S,J,LR) :-
        etageSuivant(Sp,S,J,[],LL2),
        verifSPGagnant(LL2,S,J, LR).


/*profondeur([F|L], [F|L]) :-
        final(F),!.*/

/*profondeur([C|L],Sol) :-
        deplacement(C,Nt),
        nonmember(Nt,L),
        profondeur([Nt|[C|L]],Sol).*/

profondeur(SP,S,_,LR) :-
         etatFinal(SP,S,LR),!.

profondeur([[SP|P]],S,J,Sol) :-
        move(SP,S,J,R),
        nonmember(R,P),
        verifSPGagnantP([[R|[SP|P]]],S,J,Sol).
        /*J1 is 1-J,
        adversaire(S,A),
        profondeur([[R|[SP|P]]],A,J1,Sol).*/

parcoursProfondeur(S,L) :-
        sousPlateau(Sp),
        evalSousPlateau(Sp,S,0,Cout),
        profondeur([[[Sp,Cout]]],S,0,Los),
        inverse(Los,L).
 
pl(S,L) :-
        sousPlateau(Sp),
        evalSousPlateau(Sp,S,0,Cout),
        largeur([[[Sp,Cout]]],S,0, Los),
        inverse(Los,L).
            
verifSPGagnant(LL,S,_,LR):-
         etatFinal(LL,S,LR).
verifSPGagnant(LL,S,J, LR):-
        J1 is 1-J,
        adversaire(S,A),
        largeur(LL,A,J1,LR).         

verifSPGagnantP(LL,S,_,LR):-
         etatFinal(LL,S,LR).
verifSPGagnantP(LL,S,J, LR):-
        J1 is 1-J,
        adversaire(S,A),
        profondeur(LL,A,J1,LR).  

verifSPGagnantH(LL,S,_,LR):-
         etatFinal(LL,S,LR).
verifSPGagnantH(LL,S,J, LR):-
        J1 is 1-J,
        adversaire(S,A),
        largeur(LL,A,J1,LR).     
        


 

heuristiqueL([],_, _,_):- 
        fail,!.

heuristiqueL(Sp,S,_,LR):- 
        etatFinal(Sp,S,LR).
                     
heuristiqueL([Sp|P],S,J,Sol):- 
        write(P),
        placer(Sp,S,J,Lch2),
        write(Lch2),
        insere(P,Lch2,NL),
        %tri2(Lch2,NL),
        write(NL),
        J1 is 1-J,
        adversaire(S,A),
        heuristiqueL(NL,A,J1,Sol).
                               
parcoursHeuristique(S,Sol):-
         sousPlateau(Sp),
         evalSousPlateau(Sp,S,0,C),
         /*heuristique(D,C),*/
         heuristiqueL([[[Sp,C]]],S,0,Los),
         inverse(Los,Sol).


insere(L,[],L).
insere(L, [Ch|Q],S):- 
        insereC(Ch, L,R),
        insere(R,Q,S).

insereC(Ch,[],[Ch]):-!.

insereC([[Ch,Cout]],[[[Ch2,Cout2]|Q]],[[[Ch2,Cout2],[Ch,Cout]|Q]]):-
        Cout < Cout2,!.

insereC(A,[X|L],[X|Q]):-
        insereC(A,L,Q). 

tri([],[]).
tri([X|L],LT):-
        tri(L,L1),
        insere(X,L1,LT).


algo(P,SNous) :-
        write(SNous),
        write(P).

/*trouveAlpha([[[l,l,l,l,l,l,l,l,l],0],[[x,l,l,l,l,l,l,l,l],3],[[x,x,l,l,l,l,l,l,o],1]],0,Cout).*/
trouveAlpha([],Acc,Acc).
trouveAlpha([[_,Cout]|RSp],Cout2,Alpha):-
        Cout2 =<  Cout,
        trouveAlpha(RSp,Cout,Alpha).
 
trouveAlpha([[_,Cout]|RSp],Cout2,Alpha):-
        Cout2 > Cout,
        trouveAlpha(RSp,Cout2,Alpha).

/*trouveBeta([[[l,l,l,l,l,l,l,l,l],2],[[x,l,l,l,l,l,l,l,l],-1],[[x,x,l,l,l,l,l,l,o],3]],0,Cout).*/
trouveBeta([],Acc,Acc).
trouveBeta([[_,Cout]|RSp],Cout2,Alpha):-
        Cout2 =<  Cout,
        trouveBeta(RSp,Cout2,Alpha).

trouveBeta([[_,Cout]|RSp],Cout2,Alpha):-
        Cout2 > Cout,
        trouveBeta(RSp,Cout,Alpha).


% permet de récupérer tout les éléments a comparer d'un étage
recupPremElem([],Acc,Acc).
recupPremElem([[X|_]|L],Acc,R):-
        recupPremElem(L,[X|Acc],R).
     
% a trouver meilleur nom je suis pas inspirer...   
test(Sp,S,R):-
        comptLignePG(Sp,S,Cout),
        etageSuivant([[[Sp,Cout]]],S,0,[],L),
        recupPremElem(L,[],LL),
        trouveAlpha(LL,0,R). 

test2(Sp,S,R):-
        comptLignePG(Sp,S,Cout),
        etageSuivant([[[Sp,Cout]]],S,0,[],L),
        recupPremElem(L,[],LL),
        trouveBeta(LL,0,R). 





%[[[[x,l,l,l,l,l,l,l,l],3],[[l,l,l,l,l,l,l,l,l],0]],[[[l,x,l,l,l,l,l,l,l],2],[[l,l,l,l,l,l,l,l,l],0]],[[[l,l,l,l,x,l,l,l,l],4],[[l,l,l,l,l,l,l,l,l],0]],[[[l,l,l,l,l,l,l,l,x],3],[[l,l,l,l,l,l,l,l,l],0]]]
tri2([],[]).
tri2([X|L],LT):-
        tri2(L,L1),
        write(L1),
        insertion(X,L1,LT).

insertion(X,[],[X]). 
%1ere insertion C1>=C2
insertion([[L1,C1]|L],[[[L2,C2]|M]],[[[L1,C1]|L],[[L2,C2]|M]]):- 
        C1>=C2,
       /* write(C1),*/
        write(C2).

%Autre insertion C1>=C2
insertion([[L1,C1]|L],[[[X,C2],Y]|L2],[[[L1,C1]|L],[[X,C2],Y]|L2]):- 
        C1>=C2,
        write(C1),
        write(L),
        write(C2),
        write(L2),
        write(Y),
        write(X),!.      
 
%1ere insertion C1<C2
insertion([[L1,C1]|L],[[[L2,C2]|M]],[[[L2,C2]|M]|M2]):- 
        C1<C2,
        write(C1),
        /*write(C2),
        write(M),
        write(M2),*/
        insertion([[L1,C1]|L],[],M2),!.

%Autre insertion C1<C2
insertion([[L1,C1]|L],[[[X,C2],Y]|L2],[[[X,C2]|[Y]]|M2]):- 
        C1<C2,
        write(C1),
        write(C2),
        write(L2),
        write(Y),
        write(X),
        insertion([[L1,C1]|L],L2,M2),!.        



%tri2([[[[x,l,l,l,l,l,l,l,l],3],[[l,l,l,l,l,l,l,l,l],0]],[[[l,x,l,l,l,l,l,l,l],4],[[l,l,l,l,l,l,l,l,l],0]],[[[l,l,l,l,x,l,l,l,l],2],[[l,l,l,l,l,l,l,l,l],0]],[[[l,l,l,l,l,l,l,l,x],3],[[l,l,l,l,l,l,l,l,l],0]]],L).
%tri2([[[[x,l,l,l,l,l,l,l,l],4],[[l,l,l,l,l,l,l,l,l],0]],[[[l,x,l,l,l,l,l,l,l],3],[[l,l,l,l,l,l,l,l,l],0]],[[[l,l,l,l,x,l,l,l,l],2],[[l,l,l,l,l,l,l,l,l],0]],[[[l,l,l,l,l,l,l,l,x],1],[[l,l,l,l,l,l,l,l,l],0]]],L).
 
tri_insertion([],[]). 
tri_insertion([X|L],LT):-  
        tri_insertion(L,L1), 
        insertionn(X,L1,LT). 

insertionn(X,[],[X]). 
insertionn(X,[Y|L],[X,Y|L]):- 
        X>Y,
        write(L). 
insertionn(X,[Y|L],[Y|L1]):- 
        X=<Y,  
        write(L),  
        write(L1),  
        insertionn(X,L,L1). 

%tri_insertion([3,4,2,3],L).
