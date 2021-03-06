#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

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

TypCoupReq demandeCaseUser(TypSymbol symb){
    TypCoupReq typC; 
    TypSousPlat tsp;
    TypPlat tp;
    TypCase tc;
    char c;
    int nbSpwin;
    char* str = (char *)malloc (6*sizeof(char));
    printf("Dans quel plateau voulez-vous jouer ? (A, B, C, D, E, F, G, H, I) \n");
    scanf("%s", &c);
    tp = formatPlateau(c);
    purger();
    printf("Dans quel sous plateau voulez-vous jouer ? (UN, DEUX, TROIS, QUATRE, CINQ, SIX, SEPT, HUIT, NEUF) \n");
    scanf("%s", str);
    tsp = formatSousPlateau(str);
    free(str);
    printf("Nb sous plateau gagné ? \n");
    scanf("%d", &nbSpwin);
    tc.numPlat = tp;
    tc.numSousPlat = tsp;
    typC.idRequest = COUP;
    typC.symbolJ = symb;                          
    typC.nbSousPlatG =nbSpwin;
    typC.pos = tc;
    return typC;
}

int connectJava(int port) {
    int sock, err;

    //Creation de la socket client
    sock =  socketClient("127.0.0.1", port);
    if (sock < 0) { 
        printf("client : erreur socketClient\n");
        exit(2);
    }
    return sock;
}

TypCoupReq demandeCaseIA(int sockJava, TypCase coupPrec,TypSymbol symb){
    TypCoupReq typC; 
    TypCase tc;
    int err, spPrec,spPrecNet;
    char p, platPrec, spPrecCh;
    int32_t sp, nbSpwin;
	memset(&platPrec, 0, sizeof(platPrec));
    memset(&sp, 0, sizeof(sp));
    memset(&nbSpwin, 0, sizeof(nbSpwin));
    
    platPrec = getPlatChar(coupPrec.numPlat); 
    err = send(sockJava, &platPrec, sizeof(platPrec), 0);
    if (err < 0) {
        closeExitSocketClient(sockJava);
    }
  
    spPrec = getSPlatInt(coupPrec.numSousPlat);
    spPrecNet = htonl(spPrec);
    err = send(sockJava, &spPrecNet, sizeof(spPrecNet), 0);
    if (err < 0) {
        closeExitSocketClient(sockJava);
    }
    
    err = recv(sockJava, &nbSpwin, sizeof(nbSpwin), 0);
    if (err < 0) {
       	closeExitSocketClient(sockJava);
    }

    err = send(sockJava, &nbSpwin, sizeof(nbSpwin), 0);
    if (err < 0) {
         closeExitSocketClient(sockJava);
    }
    err = recv(sockJava, &p, sizeof(p), 0);
    if (err < 0) {
       closeExitSocketClient(sockJava);
    }
    err = send(sockJava, &p, sizeof(nbSpwin), 0);
    if (err < 0) {
         closeExitSocketClient(sockJava);
    }
   
    err = recv(sockJava, &sp, sizeof(sp), 0);
    if (err < 0) {
       closeExitSocketClient(sockJava);
    }
    err = send(sockJava, &sp, sizeof(nbSpwin), 0);
    if (err < 0) {
             closeExitSocketClient(sockJava);
    }

    tc.numPlat = formatPlateau(p);
    tc.numSousPlat = intToTypSP(sp);
    typC.idRequest = COUP;
    typC.symbolJ = symb;                          
    typC.nbSousPlatG =nbSpwin;
    typC.pos = tc;
    return typC;
}
                                                                                    

TypPartieReq remplieRequetePartie(char nom[MAX_CH]){
    TypPartieReq typR;
    typR.idRequest = PARTIE;
    strcpy(typR.nomJoueur,nom);
    return typR;
}

TypCoupReq remplieRequeteCoup(TypSymbol symb,TypCase tc){
    TypCoupReq typC; 
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
    err = recv(sock, &typCoupRep, sizeof(typCoupRep), 0);
    if (err < 0) {
        closeExitSocketClient(sock);
    }
    return typCoupRep;
}  



TypCoupReq recoitCoup(int sock){
    TypCoupReq typCoupReq;
    memset(&typCoupReq, 0, sizeof(typCoupReq));
    int err;
    err = recv(sock, &typCoupReq, sizeof(typCoupReq), 0);
    printf("Votre adversaire à jouer\n");
    afficheCase(typCoupReq.pos);
    return typCoupReq;
}  

void afficheReponseCoup(int sock,TypCoupRep typCoupRep){
    afficheTypValCoup(typCoupRep.validCoup);
    afficheTypCoup(typCoupRep.propCoup);
}   

void afficheTypValCoup(TypValCoup tvc){
    switch(tvc) {
        case VALID: printf("Le coup est valide\n"); break;
        case TIMEOUT: printf("Un timeout a eu lieu\n"); break;
        case TRICHE: printf("Tricherie\n"); break;
    }
}

void afficheTypCoup(TypCoup tc){
    switch(tc) {
        case CONT: printf("La partie continue \n"); break;
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
    
    printf("Attente de la validation du coup de l'adversaire\n");
    validAdv = recoitValidationCoup(sock);

    //Affiche si le coup est valide et l'état de la partie
    afficheReponseCoup(sock,validAdv);
    //continue ou arrete la partie en fonction de la validation
    traiteReponseCoup(sock,validAdv);

    return tCoupRecu;
}

//Envoie d'un coup depuis le client
void envoieRequeteCoupClient(TypCoupReq typC, int sock){
    int err;
    err = send(sock, &typC, sizeof(typC), 0);
    if (err <0) {
        closeExitSocketClient(sock);
    }
}

void closeExitSocketClient(int sock){
    printf("Fin du jeu\n");
    shutdown(sock, 2); 
    close(sock);
    exit(3);
}

void traiteReponseCoup(int sock,TypCoupRep typCoupRep){
    if(typCoupRep.validCoup == TIMEOUT || typCoupRep.validCoup == TRICHE){
        closeExitSocketClient(sock);
    }
    if(typCoupRep.propCoup != CONT && typCoupRep.propCoup != PERDU){
        closeExitSocketClient(sock);
    }
}  

void *startServeurJava(void *arg)
{
    char String[255];
    struct arg_struct *args = arg;
    if (args->cond == 0) 
    {
	    sprintf(String, "java -classpath \"%s/sicstus-4.3.2/bin/jasper.jar:../../bin/\" ia.Main %d %d 0",
	    		args->path, args->portJava, args->symb-1);
	    system(String);
    }
    else
    {
	    sprintf(String, "java -classpath \"%s/sicstus-4.3.2/bin/jasper.jar:bin/\" ia.Main %d %d 1",
	    		args->path, args->portJava, args->symb-1);
	    system(String);	
    }
    free(arg);
    pthread_exit(NULL);
}
