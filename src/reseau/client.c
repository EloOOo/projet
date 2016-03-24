#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "common.h"
#include "fonctionsSocket.h"
#include "fonctionsClient.h"
#include "protocoleTicTacToe.h"

 
main(int argc, char **argv){

    int sock,err, i,partieFinie = 0;             
    TypPartieReq typPartReq;
    TypPartieRep typPartRep;
    TypCoupReq tCoupReq;
    char* nomJ;
    TypSymbol  symb;  

    if (argc != 4) {
        printf("usage : client nom_machine no_port nom_joueur\n");
        exit(1);
    }
  
    char* nomMachine = argv[1];
    int nbPort = atoi(argv[2]);

    sock =  socketClient(nomMachine, nbPort);


    printf("Début du jeu, envoi d'une demande de partie au serveur : \n");
    nomJ = argv[3];
    typPartReq = remplieRequetePartie(nomJ);
    envoieRequetePartie(typPartReq,sock);
    typPartRep = recoitReponsePartie(sock);
    afficheInfoPartie(typPartRep);

    while (partieFinie == 0) 
    {
        // si joueur 2 ==> reception coup AVANT l'envoi
        if (typPartRep.symb == ROND) 
        {

        }

        // envoie de coup
        TypCase tc = demandeCaseUser();
        tCoupReq = remplieRequeteCoup(typPartRep.symb, tc);
        envoieRequeteCoup(tCoupReq,sock);
        
        // Affichage de la case envoyée
        afficheCase(tCoupReq.pos);

        // Si joueur 1 ==> reception APRES envoie
        if (typPartRep.symb == CROIX)  
        {

        }
        //partieFinie = 1;
    }

    shutdown(sock, 2);
    close(sock);
}
 

