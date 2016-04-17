#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <pthread.h>

#include "common.h"
#include "fonctionsSocket.h"
#include "fonctionsClient.h"
#include "protocoleTicTacToe.h"

 
int main(int argc, char **argv){
    system("javac -classpath \"../../include/jasper.jar\" -d \"../../bin/\" ../ia/*.java");
    int sock, sockJava, symbole ,partieFinie = 0;             
    TypPartieReq requetePartie;
    TypPartieRep reponsePartie;
    TypCoupReq requeteCoup;
    TypCoupRep reponseCoup;
    TypCoupRep validCoupAdverse;
    char* nomJ;
    pthread_t thrJava;

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
    // on conserve le symbole dans un int
    if (reponsePartie.symb == CROIX) symbole = 1; else symbole = 2;
    
    afficheInfoPartie(reponsePartie);
  
    // Lance le serveur Java automatiquement  + se connceter via la sokcet sockJava
/*    int* arg = malloc(sizeof(*arg));
    if ( arg == NULL ) {
        fprintf(stderr, "Couldn't allocate memory for thread arg.\n");
        exit(EXIT_FAILURE);
    }
    *arg = symbole;
	pthread_create(&thrJava, NULL, (void *)startServeurJava, arg);
	sleep(2);
	
	sockJava = connectJava(symbole);
 */	
 	while (partieFinie == 0) 
    {
        memset(&requeteCoup, 0, sizeof(requeteCoup));
        //1er joueur
        if (reponsePartie.symb == CROIX)  
        {
            //demander case, enregistrer la requete, l'envoyer au serveur
            TypCase tc = demandeCaseUser();
            // TypCase tc = demandeCaseIA(sockJava, validCoupAdverse.pos);
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
            validCoupAdverse = recoitEtValidCoup(sock);
             //Affiche si le coup est valide et l'état de la partie
            afficheReponseCoup(sock,validCoupAdverse);
            //continue ou arrete la partie en fonction de la validation
            traiteReponseCoup(sock,validCoupAdverse);
        }

        // 2eme joueur
        if (reponsePartie.symb == ROND) 
        {  
            //reception du coup adverse et de sa validation(oui/non)
            validCoupAdverse = recoitEtValidCoup(sock);
             //Affiche si le coup est valide et l'état de la partie
            afficheReponseCoup(sock,validCoupAdverse);
            //continue ou arrete la partie en fonction de la validation
            traiteReponseCoup(sock,validCoupAdverse);
           
            //demander case, enregistrer la requete, l'envoyer au serveur
            TypCase tc = demandeCaseUser();
            // TypCase tc = demandeCaseIA(sockJava, validCoupAdverse.pos);
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
