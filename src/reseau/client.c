#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "common.h"
#include "fonctionsSocket.h"
#include "fonctionsClient.h"
#include "protocoleTicTacToe.h"

 
main(int argc, char **argv){

    int sock,err, i,partieFinie = 0,nbCoup=0;             
    TypPartieReq typPartReq;
    TypPartieRep typPartRep;
    TypCoupReq tCoupReq;
    TypCoupRep tCoupRep;
    char* nomJ;
    char msgServeur;
    TypSymbol  symb;  

    if (argc != 4) {
        printf("usage : client nom_machine no_port nom_joueur\n");
        exit(1);
    }
  
    char* nomMachine = argv[1];
    int nbPort = atoi(argv[2]);
    nomJ = argv[3];

    //Creation de la socket client
    sock =  socketClient(nomMachine, nbPort);
    if (sock < 0) { 
        printf("client : erreur socketClient\n");
        exit(2);
    }


    printf("Début du jeu, envoi d'une demande de partie au serveur : \n");
    
    //remplissage de la requete partie
    typPartReq = remplieRequetePartie(nomJ);
    
    //envoie de la requete de partie au serveur
    err = envoieRequetePartie(typPartReq,sock);
    err = testErreur(err);
    if(err == 1){
       closeExitSocketClient(sock);
    }
    
    //reception d'une réponse du serveur
    typPartRep = recoitReponsePartie(sock);
    err = testErreur(typPartRep.err);
    if(err == 1){
       closeExitSocketClient(sock);
    }
    
    afficheInfoPartie(typPartRep);

    while (partieFinie == 0) 
    {
        //défini si le joueur peut jouer ou non, N = non
        msgServeur = 'N';

        // si joueur 2 ==> reception coup AVANT l'envoi
        if (typPartRep.symb == ROND) 
        {
            printf("Veuillez patientez, le joueur adverse joue\n");
            while(msgServeur != 'O'){
                err = recv(sock, &msgServeur, sizeof(msgServeur), 0);
                if(err < 0){
                    closeExitSocketClient(sock);
                }

            }
            TypCase tc = demandeCaseUser();
            tCoupReq = remplieRequeteCoup(typPartRep.symb, tc);
            err = envoieRequeteCoup(tCoupReq,sock);
            if(err == 1){
                closeExitSocketClient(sock);
            }
            //Reponse = validité(oui/non) du coup par le serveur
            tCoupRep = recoitReponseCoup(sock);
            err = testErreur(tCoupRep.err);
            if(err == 1){
                closeExitSocketClient(sock);
            }
            afficheReponseCoup(sock,tCoupRep);
            // Affichage de la case envoyée
            afficheCase(tCoupReq.pos);
        }


        // Si joueur 1 ==> reception APRES envoie
        if (typPartRep.symb == CROIX)  
        {
            TypCase tc = demandeCaseUser();
            tCoupReq = remplieRequeteCoup(typPartRep.symb, tc);
            err = envoieRequeteCoup(tCoupReq,sock);
            if(err == 1){
                closeExitSocketClient(sock);
            }
            //Reponse validité coup par le serveur
            tCoupRep = recoitReponseCoup(sock);
            err = testErreur(tCoupRep.err);
            if(err == 1){
                closeExitSocketClient(sock);
            }
            afficheReponseCoup(sock,tCoupRep);
            // Affichage de la case envoyée
            afficheCase(tCoupReq.pos);
            printf("Veuillez patientez, le joueur adverse joue\n");
            while(msgServeur != 'O'){
                err = recv(sock, &msgServeur, sizeof(msgServeur), 0);
                if(err < 0){
                    closeExitSocketClient(sock);
                }
            }
        
        }

        
        



        
        //partieFinie = 1;
    }

    shutdown(sock, 2);
    close(sock);
}
 

