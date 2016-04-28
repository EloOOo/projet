package ia;

import java.util.HashMap;

import se.sics.jasper.SICStus;
import se.sics.jasper.Query;


public class JSicstus {
	
	public static HashMap executeCmd(String cmd) {
		SICStus sp = null;
		HashMap results = new HashMap();
		try {
			sp = new SICStus();
			// Chargement d'un fichier prolog .pl
			sp.load("../prolog/UTicTacToe.pl");
			Query qu = sp.openQuery(cmd, results);

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