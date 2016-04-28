package ia;

import java.util.HashMap;

import se.sics.jasper.SICStus;
import se.sics.jasper.SPQuery;


public class JSicstus {
	public static void hello(){
		System.out.println("Bonjour monde");
	}
	
	public static HashMap executeCmd(String cmd) {
		SICStus sp = null;
		HashMap results = new HashMap();
		try {
			sp = new SICStus();
			// Chargement d'un fichier prolog .pl
			sp.load("UTicTacToe.pl");
			SPQuery qu = sp.openQuery("adversaire(x,A).",results);
			
			//fermeture de la requète
			qu.close();

		}
		catch (Exception e) {
			System.err.println("Exception SICStus Prolog : " + e);
			e.printStackTrace();
			System.exit(-2);
		}
		
		return results;
	}
}