package ia;

import java.util.HashMap;

import se.sics.jasper.SICStus;
import se.sics.jasper.SPTerm;

public class JSicstus {
	
	public static Coup findMove(String cmd, String plateau, String SpSimple, int numSp,char symbole) {
		SICStus sp = null;
		HashMap varMap = new HashMap();
		Coup c = null;
		try {
			sp = new SICStus();
			
			// Chargement d'un fichier prolog .pl
			sp.load("../prolog/UTicTacToe.pl");
			String str = cmd + "(" + plateau+ "," + SpSimple + "," + numSp +"," + symbole + ",SousPlateau,Case,NbSpWin)."; 
			System.out.println(str);
			if(sp.query(str, varMap)) 
			{
				int sousPlat = Integer.parseInt(((SPTerm)varMap.get("SousPlateau")).toString());
				int ncase = Integer.parseInt(((SPTerm)varMap.get("Case")).toString());
				int spWin = Integer.parseInt(((SPTerm)varMap.get("NbSpWin")).toString());
				c = new Coup(sousPlat,ncase,spWin);
			}		
		}
		catch (Exception e) {
			System.err.println("Exception SICStus Prolog : " + e);
			e.printStackTrace();
			System.exit(-2);
		}
		
		return c;
	}
}