#ifndef _fonctionsServeur_h
#define _fonctionsServeur_h

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h> 

#include "common.h"
#include "protocoleTicTacToe.h"
#include "validation.h"


int attendRequeteClient(int sockConx);
TypPartieReq recoitRequetePartieClient(int sockConx,int sockTrans);
TypCoupReq recoitRequeteCoup(int sockConx,int sockTrans);
void envoieReponsePartieClient(int sockConx,int sockTrans,TypPartieRep repPartJ);
TypPartieRep remplieRepPartieClient(int j,TypPartieReq typPReqJ1,TypPartieReq typPReqJ2);
TypCoupRep remplieRepCoutClient(int j,TypCoupReq coup);
void envoieReponseCoup(int sockConx,int sockTrans,TypCoupRep repCoupJ);
void closeExitSocketServeur(int sockConx,int sockTrans);
void envoieRequeteCoupServeur(TypCoupReq typC, int sock, int sockTrans);
#endif 