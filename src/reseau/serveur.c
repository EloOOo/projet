//faire un gestionnaire d'erreur bien avec la struct erreur
#include <string.h>
#include <stdlib.h>

#include "protocoleTicTacToe.h"
#include "common.h"
#include "fonctionsSocket.h"
#include "fonctionsServeur.h"


main(int argc, char** argv) {
    int sockConx, 
        sockTransJ1,    
        sockTransJ2,      
        err,
        partieFinie = 0,
        nbCoup = 0;	       
    TypIdRequest typR = PARTIE;
    TypPartieReq reqPartieJ1;
    TypPartieReq reqPartieJ2;
    char nomJ1[MAX_CH];
    char nomJ2[MAX_CH];
    TypSymbol  symb;     
    TypPartieRep repPartJ1;
    TypPartieRep repPartJ2;

    if (argc != 2) {
        printf ("usage : serveurTCP no_port\n");
        return -1;
    }
  
    int port  = atoi(argv[1]);
    sockConx = socketServeur(port);

    //Attende du 1er joueur
    sockTransJ1 = attendRequeteClient(sockConx);

    //reception d'une demande de partie
    reqPartieJ1 = recoitRequetePartieClient(sockConx,sockTransJ1);
    //fin du traitement de la demande de partie sur le 1er joueur

    //Attende du 2eme joueur
    sockTransJ2 = attendRequeteClient(sockConx);

    //reception d'une demande de partie
    reqPartieJ2 = recoitRequetePartieClient(sockConx,sockTransJ2);

    //remplie les réponses clients
    repPartJ1 =remplieRepPartieClient(1,reqPartieJ1,reqPartieJ2);
    repPartJ2 =remplieRepPartieClient(0,reqPartieJ2,reqPartieJ1);
    
    //envoie reponse partie au joueur 1 et 2
    err = envoieReponsePartieClient(sockConx,sockTransJ1,repPartJ1);
    if(err == 1){
       closeExitSocketServeur(sockConx,sockTransJ1);
    }

    err = envoieReponsePartieClient(sockConx,sockTransJ2,repPartJ2);
    if(err == 1){
       closeExitSocketServeur(sockConx,sockTransJ2);
    }

    while(partieFinie == 0) {
        TypCoupReq coup;
        TypCoupRep repCoup;

        /************************** RECEPTOIN D'UN COUP ***********************/
        if (nbCoup%2 == 0){
            printf("J'attend un coup de J1\n");
            coup = recoitRequeteCoup(sockConx,sockTransJ1);  
            repCoup = remplieRepCoutClient(1,coup);
            err = testErreur(repCoup.err);
            if(err == 1){
                closeExitSocketServeur(sockConx,sockTransJ2);
            }
            err = envoieReponseCoup(sockConx,sockTransJ1,repCoup);
            int err2 = testErreur(err);
            if(err2 == 1){
                closeExitSocketServeur(sockConx,sockTransJ2);
            }

        } 
            
        else {
            printf("J'attend un coup de J2\n");
            coup = recoitRequeteCoup(sockConx,sockTransJ2); 
            repCoup = remplieRepCoutClient(1,coup);
            err = envoieReponseCoup(sockConx,sockTransJ2,repCoup);
            int err2 = testErreur(err);
             if(err2 == 1){
                closeExitSocketServeur(sockConx,sockTransJ2);
            }
        }
           
        
        /************************** AFFICHAGE COUP RECU ***********************/
        afficheCase(coup.pos);

        /************************** BLOCAGE DU JOUEUR NE JOUANT PAS ***********************/

        if(coup.symbolJ == ROND){
            printf("Coup venant de j2 : ROND \n");
            err = send(sockTransJ1, "O", 2, 0);
            if(err<0){
                closeExitSocketServeur(sockConx,sockTransJ1);
            }
        }
        if(coup.symbolJ == CROIX){
            printf("Coup venant de j1 : CROIX \n");
            err = send(sockTransJ2, "O", 2, 0);
             if(err<0){
                closeExitSocketServeur(sockConx,sockTransJ2);
            }
        } 
       

        nbCoup++;
    }

    shutdown(sockTransJ1, 2);  
    close(sockTransJ1);
    shutdown(sockTransJ2, 2);  
    close(sockTransJ2);
    close(sockConx);
}
