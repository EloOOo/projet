package ia;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;

public class Main 
{
	public static void main(String[] args) 
	{
		PlateauUltimate pu = new PlateauUltimate();
		
		if (args.length!=2){
		    System.out.println("Java -- argument - port - symbole");
		    System.exit(1);
		}
		System.out.println("Java -- Start Serveur");
		
		ServerSocket srv;
		int port = Integer.parseInt(args[0]);
		int symbole = Integer.parseInt(args[1]); // 0 ->croix 1-> rond
		EContenuCase ccJ , ccA;
		
		if(symbole == 0) {
			ccJ = EContenuCase.croix;
			ccA = EContenuCase.rond;
		}
		else {
			ccA = EContenuCase.croix;
			ccJ = EContenuCase.rond;
		}
		
		Case c =  new Case(EPlateau.D,ESousPlateau.HUIT);
		
		try 
		{
		    srv = new ServerSocket(port) ;
		    Socket s = srv.accept() ;
		    OutputStream os =  s.getOutputStream();	
		    InputStream is = s.getInputStream();		    
		    char prevPlat;
	    	int prevSP, isGagne=0, nbSpGagne = 0, nbSpGagneBis = 0;  
		    HashMap res;
		    
			while(pu.getPartieFinie() == false) {
				isGagne=0;
		    	prevPlat =  (char) is.read();
		    	prevSP = is.read();
		    	nbSpGagneBis = is.read();
				System.out.println("Java -- J'ai recu: " + prevPlat + " " + prevSP);
		    
				// Actualiser le plateau avec la case adverse 
				if (nbSpGagneBis > nbSpGagne && ccA == EContenuCase.croix)
					isGagne = 1;
				else if (nbSpGagneBis > nbSpGagne && ccA == EContenuCase.rond)
					isGagne = 2;
				pu.actualiserUPlateau(prevPlat, prevSP, isGagne, ccA);
				nbSpGagne = nbSpGagneBis;
				
				// Consulter prolog
				JSicstus.hello();
				res = JSicstus.executeCmd("algo([[d,[l,l,l,l,l,l,l,l,l]], [d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]],[d,[l,l,l,l,l,l,l,l,l]]],x).");


				System.out.println("Java -- Resultat ==>  " + res);
				// Actualiser le plateau avec la case de prolog  
				// pu.actualiserUPlateau(prologPlat, prologSP, prologGagne, ccJ);
				// actualiser nbSpGagne
				
			    //System.out.println("Java -- Envoie d'une case");
				os.write(c.getNumPlat().getN());
				os.flush();
		    	os.write(c.getNumSousPlat().getVal());
		    	os.flush();
		    	os.write(nbSpGagne);
		    	os.flush();
			}
			
			s.close() ;	    
		    System.out.println("Java -- fin");
		    System.exit(0);
		} 
		catch(Exception e) 	
		{
			//System.err.println("Exception Serveur Java : " + e);
			//e.printStackTrace();
		}	
	}
}
