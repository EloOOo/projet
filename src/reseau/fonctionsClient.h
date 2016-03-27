#ifndef _fonctionsClient_h
#define _fonctionsClient_h

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "common.h"
#include "protocoleTicTacToe.h"

char* demandeNom();
TypCase demandeCaseUser();
TypCase demandeCaseIA();                                                                                
TypPartieReq remplieRequetePartie(char nom[MAX_CH]);
TypCoupReq remplieRequeteCoup(TypSymbol  symb,TypCase tc);
int envoieRequetePartie(TypPartieReq typR, int sock);
TypPartieRep recoitReponsePartie(int sock);
void afficheInfoPartie(TypPartieRep typPartRep);
int envoieRequeteCoup(TypCoupReq typC, int sock);
TypCoupRep recoitReponseCoup(int sock);
void afficheReponseCoup(int sock,TypCoupRep typCoupRep);
void afficheTypValCoup(TypValCoup tvc);
void afficheTypCoup(TypCoup tc);
void closeExitSocketClient(int sock);




#endif
