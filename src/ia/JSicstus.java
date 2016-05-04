package ia;

import se.sics.jasper.SICStus;
import se.sics.jasper.SPPredicate;
import se.sics.jasper.SPQuery;
import se.sics.jasper.SPTerm;

public class JSicstus {
	
	public static SPTerm findMove(String cmd, String plateau, String SpSimple, int numSp,char symbole) {
		SICStus sp = null;
		SPQuery q = null;
		SPPredicate pred;
		SPTerm p,sps, nSP,s, res = null;
		
		try {
			sp = new SICStus();
			pred = new SPPredicate(sp, cmd, 5, "");
			p = new SPTerm(sp, plateau);
		    sps = new SPTerm(sp, SpSimple);
		    nSP = new SPTerm(sp, numSp);
		    s = new SPTerm(sp, symbole);
		  
		    res = new SPTerm(sp).putVariable();
		    
			// Chargement d'un fichier prolog .pl
			sp.load("../prolog/UTicTacToe.pl");
			q = sp.openQuery(pred, new SPTerm[] {p,sps,nSP,s,res});
			System.out.println("Test " + res);
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