#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#include "common.h"
#include "fonctionsServeur.h"



int attendRequeteClient(int sockConx){
    int sockTrans = accept(sockConx, NULL, NULL);
    if (sockTrans < 0) {
        perror("serveur :  erreur sur accept");
        close(sockConx);
        exit(3);
    }
    return sockTrans;
}

TypPartieReq recoitRequetePartieClient(int sockConx,int sockTrans){
    TypPartieReq typP;
    int err;
    err = recv(sockTrans, &typP, sizeof(typP), 0);
    if (err < 0) {
        perror("serveur : erreur dans la reception");
        shutdown(sockTrans, 2); 
        close(sockTrans);
        close(sockConx);
        exit(4);
    }
    return typP;
}


TypCoupReq recoitRequeteCoup(int sockConx,int sockTrans){
    TypCoupReq cout;
    int err;
    err = recv(sockTrans, &cout, sizeof(cout), 0);
    if (err < 0) {
        perror("serveur : erreur dans la reception (cout)");
        shutdown(sockTrans, 2); 
        close(sockTrans);
        close(sockConx);
        exit(4);
    }
    return cout;
}

//remplie la réponse au client pour la demande de partie
TypPartieRep remplieRepPartieClient(int j,TypPartieReq typPReqJ1,TypPartieReq typPReqJ2){
    TypPartieRep repPartJ;
    if(j == 1){
        repPartJ.symb = CROIX;
        strcpy(repPartJ.nomAdvers,typPReqJ2.nomJoueur);
        repPartJ.err = ERR_OK;
    }
    if(j == 2){
        repPartJ.symb = ROND;
        strcpy(repPartJ.nomAdvers,typPReqJ2.nomJoueur);
        repPartJ.err = ERR_OK;
    }
    return repPartJ;
}

void envoieReponsePartieClient(int sockConx,int sockTrans,TypPartieRep repPartJ ){
	int err = send(sockTrans, &repPartJ, sizeof(repPartJ), 0);
    if (err <= 0) {
       closeExitSocketServeur(sockConx,sockTrans);
    }
    
}

//A MODIFIER
TypCoupRep remplieRepCoutClient(int j,TypCoupReq coup){
    TypCoup* propCoup;
    TypCoupRep repCoupJ;
    /*
    bool rep = validationCoup(j,coup,propCoup);
    if(rep == false){
        repCoupJ.validCoup = TRICHE;
    }
   */
    repCoupJ.err = ERR_OK;
    repCoupJ.validCoup = VALID;
    repCoupJ.propCoup = CONT;
    return repCoupJ;
}


void envoieReponseCoup(int sockConx,int sockTrans,TypCoupRep repCoupJ ){
    int err = send(sockTrans, &repCoupJ, sizeof(repCoupJ), 0);
    if (err <= 0) {
        closeExitSocketServeur(sockConx,sockTrans);   
    }
    
}

//Envoie d'un coup depuis le serveur
void envoieRequeteCoupServeur(TypCoupReq typC, int sockConx, int sockTrans){
    int err;
    err = send(sockTrans, &typC, sizeof(typC), 0);
    if (err <0) {
            closeExitSocketServeur(sockConx,sockTrans);   
    }
}

void closeExitSocketServeur(int sockConx,int sockTrans){
    printf("Fin du jeu\n");
    shutdown(sockTrans, 2); 
    close(sockTrans);
    close(sockConx);
}