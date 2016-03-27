#include <stdio.h>
#include <string.h>
#include <stdlib.h>

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

//remplie la réponse au client via le cout donné en controllant sa validité
TypPartieRep remplieRepPartieClient(int j,TypPartieReq typPReqJ1,TypPartieReq typPReqJ2){
    TypPartieRep repPartJ;
    if(j == 1){
        repPartJ.symb = CROIX;
        strcpy(repPartJ.nomAdvers,typPReqJ2.nomJoueur);
        repPartJ.err = ERR_OK;
    }
    else {
        repPartJ.symb = ROND;
        strcpy(repPartJ.nomAdvers,typPReqJ2.nomJoueur);
        repPartJ.err = ERR_OK;
    }
    return repPartJ;
}

int envoieReponsePartieClient(int sockConx,int sockTrans,TypPartieRep repPartJ ){
	int err = send(sockTrans, &repPartJ, sizeof(repPartJ), 0);
    if (err <= 0) {
        return ERR_PARTIE;
        perror("serveur : erreur sur le send");
    }
    return ERR_OK;
}

TypCoupRep remplieRepCoutClient(int j,TypCoupReq coup){
    //TypCoup* propCoup;
    //bool rep = validationCoup(j,coup,propCoup);
    TypCoupRep repCoupJ;
    repCoupJ.err = ERR_OK;
    repCoupJ.validCoup = VALID;
    repCoupJ.propCoup = CONT;
    return repCoupJ;
}


int envoieReponseCoup(int sockConx,int sockTrans,TypCoupRep repCoupJ ){
    int err = send(sockTrans, &repCoupJ, sizeof(repCoupJ), 0);
    if (err <= 0) {
        perror("serveur : erreur sur le send");
        return ERR_COUP;   
    }
    return ERR_OK;
}

void closeExitSocketServeur(int sockConx,int sockTrans){
    printf("Fin du jeu\n");
    shutdown(sockTrans, 2); 
    close(sockTrans);
    close(sockConx);
}