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
    int sock, sockJava, symbole ,partieFinie = 0;             
    TypPartieReq requetePartie;
    TypPartieRep reponsePartie;
    TypCoupReq requeteCoup, coupAdverse;
    TypCoupRep reponseCoup;
    char* nomJ;
    char* path;
    char exportPath[255], compileJava[255];
    pthread_t thrJava;

    if (argc != 6) {
        printf("usage : client nom_machine no_port nom_joueur port_java path_prolog\n");
        exit(1);
    }

    char* nomMachine = argv[1];
    int nbPort = atoi(argv[2]);
    nomJ = argv[3];
    path = argv[5];
	
    sprintf(exportPath, "export LD_LIBRARY_PATH=%s", path);
	system(exportPath);
    sprintf(compileJava, "javac -classpath \"%s/sicstus-4.3.2/bin/jasper.jar\" -d \"../../bin/\" ../ia/*.java", path);
	system(compileJava);
    
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
    struct arg_struct args;
    args.symb = symbole;
    args.portJava = atoi(argv[4]);
	pthread_create(&thrJava, NULL, (void *)startServeurJava, (void *)&args);
	sleep(1);
	
	sockJava = connectJava(args.portJava);

	while (partieFinie == 0) 
    {
        memset(&requeteCoup, 0, sizeof(requeteCoup));
        //1er joueur
        if (reponsePartie.symb == CROIX)  
        {
            //demander case, enregistrer la requete, l'envoyer au serveur
            //TypCase tc = demandeCaseUser();
            requeteCoup = demandeCaseIA(sockJava, coupAdverse.pos,reponsePartie.symb );
            //requeteCoup = remplieRequeteCoup(reponsePartie.symb, tc);
            envoieRequeteCoupClient(requeteCoup,sock);
            
            //Attente de la validation du coup par le serveur
            reponseCoup = recoitValidationCoup(sock);

            //Affiche si le coup est valide et l'état de la partie 
            //afficheReponseCoup(sock,reponseCoup);
            
            //continue ou arrete la partie en fonction de la validation
		    traiteReponseCoup(sock,reponseCoup);


            // Affichage de la case envoyée
            printf("Coup joué  \n");
            afficheCase(requeteCoup.pos);
            //reception du coup adverse et de sa validation(oui/non)
            coupAdverse = recoitEtValidCoup(sock);
	        if(reponseCoup.propCoup == PERDU){
	            requeteCoup = demandeCaseIA(sockJava, coupAdverse.pos,reponsePartie.symb);
        		closeExitSocketClient(sock);
			}
        }

        // 2eme joueur
        if (reponsePartie.symb == ROND) 
        {  
            //reception du coup adverse et de sa validation(oui/non)
            coupAdverse = recoitEtValidCoup(sock);
         	if(reponseCoup.propCoup == PERDU){
	            requeteCoup = demandeCaseIA(sockJava, coupAdverse.pos,reponsePartie.symb);
        		closeExitSocketClient(sock);
			}  
            //demander case, enregistrer la requete, l'envoyer au serveur
            //requeteCoup = demandeCaseUser(reponsePartie.symb);
            requeteCoup = demandeCaseIA(sockJava, coupAdverse.pos,reponsePartie.symb);
            //requeteCoup = remplieRequeteCoup(reponsePartie.symb, tc);
            envoieRequeteCoupClient(requeteCoup,sock);

            //Attente de la validation du coup par le serveur
            reponseCoup = recoitValidationCoup(sock);
	      
            //Affiche si le coup est valide et l'état de la partie
            //afficheReponseCoup(sock,reponseCoup);
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
