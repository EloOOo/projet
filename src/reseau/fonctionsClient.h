#ifndef _fonctionsClient_h
#define _fonctionsClient_h

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include <pthread.h>


#include "common.h"
#include "protocoleTicTacToe.h"

char* demandeNom();
TypCase demandeCaseUser();
int connectJava(int s);
TypCase demandeCaseIA(int sockJava, TypCase coupPrec);
TypPartieReq remplieRequetePartie(char nom[MAX_CH]);
TypCoupReq remplieRequeteCoup(TypSymbol  symb,TypCase tc);
void envoieRequetePartie(TypPartieReq typR, int sock);
TypPartieRep recoitReponsePartie(int sock);
void afficheInfoPartie(TypPartieRep typPartRep);
TypCoupRep recoitValidationCoup(int sock);
void afficheReponseCoup(int sock,TypCoupRep typCoupRep);
void afficheTypValCoup(TypValCoup tvc);
void afficheTypCoup(TypCoup tc);
void envoieRequeteCoupClient(TypCoupReq typC, int sock);
TypCoupRep recoitEtValidCoup(int sock);
void closeExitSocketClient(int sock);
void traiteReponseCoup(int sock,TypCoupRep typCoupRep);
void *startServeurJava(void *arg);



#endif
