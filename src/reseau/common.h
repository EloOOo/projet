#ifndef _common_h
#define _common_h

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "protocoleTicTacToe.h"

void afficheCase(TypCase tc);
void affichePlateau(TypPlat tp);
void afficheSousPlateau(TypSousPlat tsp);
TypPlat formatPlateau(char c);
TypSousPlat formatSousPlateau(char* str);
int testErreur(TypErreur err);

#endif