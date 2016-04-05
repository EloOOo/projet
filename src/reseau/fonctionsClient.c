#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#include "common.h"
#include "fonctionsClient.h"

char* demandeNom(){
    char* nom; 
    int ok =0;
    while(ok == 0){
        printf("Donner votre nom :\n");
        scanf("%s", nom);
        if(strlen(nom) <= MAX_CH){
            ok=1;
        }
    }
    
    return nom; 
}

TypCase demandeCaseUser(){
    TypSousPlat tsp;
    TypPlat tp;
    TypCase tc;
    char c;
    char* str = (char *)malloc (6*sizeof(char));
    printf("Dans quel plateau voulez-vous jouer ? (A, B, C, D, E, F, G, H, I) \n");
    scanf("%s", &c);
    tp = formatPlateau(c);
    purger();
    printf("Dans quel sous plateau voulez-vous jouer ? (UN, DEUX, TROIS, QUATRE, CINQ, SIX, SEPT, HUIT, NEUF) \n");
    scanf("%s", str);
    tsp = formatSousPlateau(str);
    tc.numPlat = tp;
    tc.numSousPlat = tsp;
    return tc;
}

TypCase demandeCaseIA(){
    TypCase tc;
    return tc;
}
                                                                                    

TypPartieReq remplieRequetePartie(char nom[MAX_CH]){
    TypPartieReq typR;
    printf("Cration la requete (PARTIE)\n");
    typR.idRequest = PARTIE;
    strcpy(typR.nomJoueur,nom);
    return typR;
}

TypCoupReq remplieRequeteCoup(TypSymbol symb,TypCase tc){
    TypCoupReq typC; 
    printf("Remplie le type de requete (COUP)\n");
    typC.idRequest = COUP;
    typC.symbolJ = symb;                          
    typC.pos = tc;
    /*TODO: changer le nbSousPlatG */
    typC.nbSousPlatG =0;
    return typC;
}

void envoieRequetePartie(TypPartieReq typR, int sock){
    int err;
    err = send(sock, &typR, sizeof(typR), 0);
    if (err <0) {
        closeExitSocketClient(sock);
    }
}



TypPartieRep recoitReponsePartie(int sock){
    TypPartieRep typPartRep;
    int err;
    printf("Attente de l'adversaire\n");
    err = recv(sock, &typPartRep, sizeof(typPartRep), 0);
    if (err < 0) {
       closeExitSocketClient(sock);
    }
    return typPartRep;
}   

void afficheInfoPartie(TypPartieRep typPartRep){
    if(typPartRep.symb == ROND){
         printf("Vous avez le symbole ROND \n");
    }
    else if(typPartRep.symb == CROIX){
        printf("Vous avez le symbole CROIX \n");
    }
   
    printf("Votre adversaire est %s \n",typPartRep.nomAdvers);
}

TypCoupRep recoitValidationCoup(int sock){
    TypCoupRep typCoupRep;
    int err;
    printf("Attente d'un message du serveur\n");
    err = recv(sock, &typCoupRep, sizeof(typCoupRep), 0);
    if (err < 0) {
        closeExitSocketClient(sock);
    }
    return typCoupRep;
}   

TypCoupReq recoitCoup(int sock){
    TypCoupReq typCoupReq;
    int err;
    printf("Attente d'un message du serveur\n");
    err = recv(sock, &typCoupReq, sizeof(typCoupReq), 0);
    if (err < 0) {
        closeExitSocketClient(sock);
    }
    return typCoupReq;
}  

void afficheReponseCoup(int sock,TypCoupRep typCoupRep){
    afficheTypValCoup(typCoupRep.validCoup);
    afficheTypCoup(typCoupRep.propCoup);
}   

void afficheTypValCoup(TypValCoup tvc){
    switch(tvc) {
        case VALID: printf("Le coup est valide\n"); break;
        case TIMEOUT: printf("Réponse trop longue, fin du jeu\n"); break;
        case TRICHE: printf("Vous avez trichez, fin du jeu\n"); break;
    }
}

void afficheTypCoup(TypCoup tc){
    switch(tc) {
        case CONT: printf("La partie continue\n"); break;
        case GAGNANT: printf("Vous avez gagné\n"); break;
        case NULLE: printf("Partie nulle\n"); break;
        case PERDU: printf("Vous avez perdu\n"); break;
        default: printf("La partie continue\n"); break;
    }
}



TypCoupReq recoitEtValidCoup(int sock){
    TypCoupReq tCoupRecu;
    TypCoupRep validAdv;
    printf("Veuillez patientez, le joueur adverse joue\n");
    printf("Attente du coup de l'adversaire\n");
    tCoupRecu = recoitCoup(sock);
    printf("Votre adversaire à jouer\n");
    afficheCase(tCoupRecu.pos);
    printf("Attente de la validation du coup de l'adversaire\n");
    validAdv = recoitValidationCoup(sock);
    printf("Le coup est validé\n");
    return tCoupRecu;
}
