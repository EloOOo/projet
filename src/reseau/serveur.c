#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>


#include "protocoleTicTacToe.h"
#include "common.h"
#include "fonctionsSocket.h"
#include "fonctionsServeur.h"




int main(int argc, char** argv) {
    int sockConx, 
        sockTransJ1,    
        sockTransJ2,      
        partieFinie = 0,
        nbCoup = 0;	       
    TypPartieReq requetePartieJ1;
    TypPartieReq requetePartieJ2; 
    TypPartieRep validationPartieJ1;
    TypPartieRep validationPartieJ2;
    time_t tDebut,tFin;
    double tExec=0.;

    if (argc != 2) {
        printf ("usage : serveurTCP no_port\n");
        return -1;
    }
  
    int port  = atoi(argv[1]);
    sockConx = socketServeur(port);

    //Attente du 1er joueur
    sockTransJ1 = attendRequeteClient(sockConx);

    //reception d'une demande de partie du joueur1 
    requetePartieJ1 = recoitRequetePartieClient(sockConx,sockTransJ1);

    //Attente du 2eme joueur
    sockTransJ2 = attendRequeteClient(sockConx);

    //reception d'une demande de partie du joueur 2 
    requetePartieJ2 = recoitRequetePartieClient(sockConx,sockTransJ2);

    //remplie les réponses de parties pour les clients
    validationPartieJ1 = remplieRepPartieClient(1,requetePartieJ1,requetePartieJ2);
    validationPartieJ2 = remplieRepPartieClient(2,requetePartieJ2,requetePartieJ1);
    
    //envoie reponse partie au joueur 1 et 2
    envoieReponsePartieClient(sockConx,sockTransJ1,validationPartieJ1);
    envoieReponsePartieClient(sockConx,sockTransJ2,validationPartieJ2);

    while(partieFinie == 0) {
        tDebut=time(NULL);
        TypCoupReq coup;
        TypCoupRep repCoup;

        //reception d'un coup du J1
        if (nbCoup%2 == 0){
            printf("J'attend un coup de J1\n");
            //reception d'un coup du J1
            tFin=time(NULL);
            tExec=difftime(tDebut,tFin);    
            printf("Temps : %f \n",tExec);
            coup = recoitRequeteCoup(sockConx,sockTransJ1);  
            

            //envoie le coup au J2
            envoieRequeteCoupServeur(coup,sockConx,sockTransJ2);

            //remplie la validation du coup
            repCoup = remplieRepCoutClient(1,coup);
           
            
            //envoie la validation au J1 et J2
            envoieReponseCoup(sockConx,sockTransJ1,repCoup);
            envoieReponseCoup(sockConx,sockTransJ2,repCoup);

            printf("Coup de J1\n");
            afficheCase(coup.pos);
        } 
            
        else {
            printf("J'attend un coup de J2\n");
             //reception d'un coup du J2
            coup = recoitRequeteCoup(sockConx,sockTransJ2); 

            //envoie le coup au J1
            envoieRequeteCoupServeur(coup,sockConx,sockTransJ1);

            repCoup = remplieRepCoutClient(2,coup);

            //envoie la validation au J2 et J1
            envoieReponseCoup(sockConx,sockTransJ2,repCoup);
            envoieReponseCoup(sockConx,sockTransJ1,repCoup);

            printf("Coup de J2\n");
            afficheCase(coup.pos);
        }

        nbCoup++;
    }

    shutdown(sockTransJ1, 2);  
    close(sockTransJ1);
    shutdown(sockTransJ2, 2);  
    close(sockTransJ2);
    close(sockConx);
    return 0;
}
