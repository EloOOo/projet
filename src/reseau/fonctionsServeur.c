#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <sys/time.h>
#include <sys/socket.h>

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

//timeout sert à gerer si le temps est dépassé pour le coup
TypCoupReq recoitRequeteCoup(int sockConx,int sockTrans, int *timeout){
    struct timeval tv;
    tv.tv_sec = 6;  
    tv.tv_usec = 0;  
    setsockopt(sockTrans, SOL_SOCKET, SO_RCVTIMEO, (char *)&tv,sizeof(struct timeval));
    
    TypCoupReq cout;
    int err;
    int i = 1;
    err = recv(sockTrans, &cout, sizeof(cout), 0);
    if (err < 0) {
        (*timeout) = 1;
        printf("La reception du coup à durée plus de 6 secondes, fin de partie\n");
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
TypCoupRep remplieRepCoutClient(int j,TypCoupReq coup,int* timeout){
    TypCoup* propCoup;
    TypCoupRep repCoupJ;
    
    /*bool rep = validationCoup(j,coup,propCoup);
    if(rep == false){
        repCoupJ.validCoup = TRICHE;
        repCoupJ.propCoup = PERDU;
    }*/
   
    repCoupJ.validCoup = VALID;
    //repCoupJ.propCoup = CONT;
    if((*timeout) == 1){
        repCoupJ.validCoup = TIMEOUT;
       
    }
    repCoupJ.err = ERR_OK;
   
    
    return repCoupJ;
}


void envoieReponseCoup(int sockConx,int sockTrans,TypCoupRep repCoupJ ){
    printf("Envoie d'une validation\n");
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
    shutdown(sockTrans, 2); 
    close(sockTrans);
    close(sockConx);
}