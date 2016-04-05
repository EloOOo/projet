#ifndef _fonctionsClient_h
#define _fonctionsClient_h

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>


#include "common.h"
#include "protocoleTicTacToe.h"

char* demandeNom();
TypCase demandeCaseUser();
TypCase demandeCaseIA();                                                                                
TypPartieReq remplieRequetePartie(char nom[MAX_CH]);
TypCoupReq remplieRequeteCoup(TypSymbol  symb,TypCase tc);
void envoieRequetePartie(TypPartieReq typR, int sock);
TypPartieRep recoitReponsePartie(int sock);
void afficheInfoPartie(TypPartieRep typPartRep);
TypCoupRep recoitValidationCoup(int sock);
void afficheReponseCoup(int sock,TypCoupRep typCoupRep);
void afficheTypValCoup(TypValCoup tvc);
void afficheTypCoup(TypCoup tc);

TypCoupReq recoitEtValidCoup(int sock);



#endif
