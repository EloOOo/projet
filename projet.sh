#make -f src/reseau/Makefile2
if  [ $# != 5 ] 
then
	echo "usage : client nom_machine no_port nom_joueur port_java path_prolog\n";
else 
	./src/reseau/client $1 $2 $3 $4 $5 1;
fi