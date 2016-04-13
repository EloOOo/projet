#ifndef _common_h
#define _common_h

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#include "protocoleTicTacToe.h"
#include "validation.h"

void afficheCase(TypCase tc);
void affichePlateau(TypPlat tp);
char getPlatChar(TypPlat tp);
void afficheSousPlateau(TypSousPlat tsp);
int getSPlatInt(TypSousPlat tsp);
TypPlat formatPlateau(char c);
TypSousPlat formatSousPlateau(char* str);
int testErreur(TypErreur err);


#endif