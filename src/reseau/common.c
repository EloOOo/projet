#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#include "common.h"

void purger(){
    char c;
    while((c=getchar()) != '\n' && c != EOF){}
}

void afficheCase(TypCase tc){
    printf("Plateau : ");
    affichePlateau(tc.numPlat);
    printf("Sous plateau : ");
    afficheSousPlateau(tc.numSousPlat);
}

void affichePlateau(TypPlat tp){
    switch(tp) {
        case A: printf(" A\n"); break;
        case B: printf(" B\n"); break;
        case C: printf(" C\n"); break;
        case D: printf(" D\n"); break;
        case E: printf(" E\n"); break;
        case F: printf(" F\n"); break;
        case G: printf(" G\n"); break;
        case H: printf(" H\n"); break;
        case I: printf(" I\n"); break;
    }
}

char getPlatChar(TypPlat tp){
    switch(tp) {
        case A: return 'A';
        case B: return 'B';
        case C: return 'C';
        case D: return 'D';
        case E: return 'E';
        case F: return 'F';
        case G: return 'G';
        case H: return 'H';
        case I: return 'I';
        default: return 'Z';
    }
}

void afficheSousPlateau(TypSousPlat tsp){
    switch(tsp) {
        case UN: printf(" UN\n"); break;
        case DEUX: printf(" DEUX\n"); break;
        case TROIS: printf(" TROIS\n"); break;
        case QUATRE: printf(" QUATRE\n"); break;
        case CINQ: printf(" CINQ\n"); break;
        case SIX: printf(" SIX\n"); break;
        case SEPT: printf(" SEPT\n"); break;
        case HUIT: printf(" HUIT\n"); break;
        case NEUF: printf(" NEUF\n"); break;
    }
}


int getSPlatInt(TypSousPlat tsp){
    switch(tsp) {
        case UN: return 1;
        case DEUX: return 2;
        case TROIS: return 3;
        case QUATRE: return 4;
        case CINQ: return 5;
        case SIX: return 6;
        case SEPT: return 7;
        case HUIT: return 8;
        case NEUF: return 9;
        default: return 0;
    }
}

TypPlat formatPlateau(char c){
    TypPlat tp;
    if(c == 'A') tp = A;
    else if(c == 'B') tp = B;
    else if(c == 'C') tp = C;
    else if(c == 'D') tp = D;
    else if(c == 'E') tp = E;
    else if(c == 'F') tp = F;
    else if(c == 'G') tp = G;
    else if(c == 'H') tp = H;
    else if(c == 'I') tp = I;
    return tp;
}

TypSousPlat formatSousPlateau(char*  str){
    TypSousPlat tsp;
    if(strcmp(str, "UN") == 0) tsp = UN;
    else if(strcmp(str, "DEUX") == 0) tsp = DEUX;
    else if(strcmp(str, "TROIS") == 0) tsp = TROIS;
    else if(strcmp(str, "QUATRE") == 0) tsp = QUATRE;
    else if(strcmp(str, "CINQ") == 0) tsp = CINQ;
    else if(strcmp(str, "SIX") == 0) tsp = SIX;
    else if(strcmp(str, "SEPT") == 0) tsp = SEPT;
    else if(strcmp(str, "HUIT") == 0) tsp = HUIT;
    else if(strcmp(str, "NEUF") == 0) tsp = NEUF;
    return tsp;
}

TypSousPlat intToTypSP(int val){
    TypSousPlat tsp;
    if(val == 1) tsp = UN;
    else if(val == 2) tsp = DEUX;
    else if(val == 3) tsp = TROIS;
    else if(val == 4) tsp = QUATRE;
    else if(val == 5) tsp = CINQ;
    else if(val == 6) tsp = SIX;
    else if(val == 7) tsp = SEPT;
    else if(val == 8) tsp = HUIT;
    else if(val == 9) tsp = NEUF;
    return tsp;
}

int testErreur(TypErreur err){
    switch(err) {
        case ERR_OK: 
            printf("Pas d'erreur\n");
            return 0;
        case ERR_PARTIE: 
            printf("La requete de partie a échoué\n");
            return 1; 
        case ERR_COUP: 
            printf("La requete de coup a échoué\n"); 
            return 1; 
        case ERR_TYP: printf("Erreur de type de requetes\n"); 
            return 1; 
        default: printf("erreur non traité\n"); 
            return 0; 
    }
    return 2;
}








