package ia;

import se.sics.jasper.SICStus;
import se.sics.jasper.SPPredicate;
import se.sics.jasper.SPQuery;
import se.sics.jasper.SPTerm;

public class JSicstus {
	
	public static SPTerm executeCmd(String cmd, String plateau, char symbole) {
		SICStus sp = null;
		SPQuery q = null;
		SPPredicate pred;
		SPTerm spl, numc, res = null;
		
		try {
			sp = new SICStus();
			pred = new SPPredicate(sp, cmd, 3, "");
			spl = new SPTerm(sp, plateau);
		    numc = new SPTerm(sp, symbole);
		  
		    res = new SPTerm(sp).putVariable();
		    
			// Chargement d'un fichier prolog .pl
			sp.load("../prolog/UTicTacToe.pl");
			q = sp.openQuery(pred, new SPTerm[] {spl, numc, res});
			
			//fermeture de la requète
			q.close();

		}
		catch (Exception e) {
			System.err.println("Exception SICStus Prolog : " + e);
			e.printStackTrace();
			System.exit(-2);
		}
		
		return res;
	}
}