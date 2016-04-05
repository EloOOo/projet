#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#include "common.h"
#include "fonctionsSocket.h"
#include "fonctionsClient.h"
#include "protocoleTicTacToe.h"

 
int main(int argc, char **argv){

    int sock, partieFinie = 0;             
    TypPartieReq requetePartie;
    TypPartieRep reponsePartie;
    TypCoupReq requeteCoup;
    TypCoupRep reponseCoup;
    TypCoupReq coupAdverse;
    char* nomJ;

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
    requetePartie = remplieRequetePartie(nomJ);
    
    //envoie de la requete de partie au serveur
    envoieRequetePartie(requetePartie,sock);
   
    //reception d'une réponse du serveur
    reponsePartie = recoitReponsePartie(sock);
    
    afficheInfoPartie(reponsePartie);

    while (partieFinie == 0) 
    {
        //1er joueur
        if (reponsePartie.symb == CROIX)  
        {
            //demander case, enregistrer la requete, l'envoyer au serveur
            TypCase tc = demandeCaseUser();
            requeteCoup = remplieRequeteCoup(reponsePartie.symb, tc);
            envoieRequeteCoupClient(requeteCoup,sock);
            
            //Attente de la validation du coup par le serveur
            reponseCoup = recoitValidationCoup(sock);

            //Affiche si le coup est valide et l'état de la partie 
            afficheReponseCoup(sock,reponseCoup);
            
            //continue ou arrete la partie en fonction de la validation
            traiteReponseCoup(sock,reponseCoup);

            // Affichage de la case envoyée
            printf("Coup joué  \n");
            afficheCase(requeteCoup.pos);

            //reception du coup adverse et de sa validation(oui/non)
            coupAdverse = recoitEtValidCoup(sock);
           

        }

        if (reponsePartie.symb == ROND) 
        {  
            //reception du coup adverse et de sa validation(oui/non)
            coupAdverse = recoitEtValidCoup(sock);
           
            //demander case, enregistrer la requete, l'envoyer au serveur
            TypCase tc = demandeCaseUser();
            requeteCoup = remplieRequeteCoup(reponsePartie.symb, tc);
            envoieRequeteCoupClient(requeteCoup,sock);

            //Attente de la validation du coup par le serveur
            reponseCoup = recoitValidationCoup(sock);

            //Affiche si le coup est valide et l'état de la partie
            afficheReponseCoup(sock,reponseCoup);
            //continue ou arrete la partie en fonction de la validation
            traiteReponseCoup(sock,reponseCoup);


            // Affichage de la case envoyée
            printf("Coup joué \n");
            afficheCase(requeteCoup.pos);
        }
    }

    shutdown(sock, 2);
    close(sock);
    return 0;
}
 

