#########
#
# fonctionsTCP
#
#########

# For Solaris
#LD_FLAGS = -lsocket -lnsl

# For Linux
LD_FLAGS = -std=c99 -Wall -Wextra

all: client serveur 

fonctionsSocket.o: fonctionsSocket.c
	gcc -c -o fonctionsSocket.o fonctionsSocket.c

common.o: common.c
	gcc -c -o common.o common.c

fonctionsClient.o: fonctionsClient.c
	gcc -c -o fonctionsClient.o fonctionsClient.c -lpthread 

fonctionsServeur.o: fonctionsServeur.c
	gcc -c -o fonctionsServeur.o fonctionsServeur.c

client: client.c common.o fonctionsSocket.o fonctionsClient.o
	gcc client.c -o client common.o fonctionsSocket.o fonctionsClient.o $(LD_FLAGS) -lpthread 

serveur: serveur.c common.o fonctionsSocket.o fonctionsServeur.o
	gcc serveur.c -o serveur common.o fonctionsSocket.o fonctionsServeur.o $(LD_FLAGS)

clean:
	rm *~ ; rm -i \#* ; rm *.o; \
        rm client ; rm serveur ; 
