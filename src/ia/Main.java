package ia;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;

import se.sics.jasper.SPTerm;

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
		char symb;
		
		if(symbole == 0) {
			ccJ = EContenuCase.croix;
			ccA = EContenuCase.rond;
			symb ='x';
		}
		else {
			ccA = EContenuCase.croix;
			ccJ = EContenuCase.rond;
			symb ='o';
		}
		
		Case c =  new Case(EPlateau.D,ESousPlateau.HUIT);
		
		try 
		{
		    srv = new ServerSocket(port) ;
		    Socket s = srv.accept();
		    OutputStream os =  s.getOutputStream();	
		    InputStream is = s.getInputStream();		    
		    char prevPlat = 'Z';
	    	int prevSP =0;
	    	
			while(pu.getPartieFinie() == false) {
				System.out.println("boucle");
				while(prevSP == 0){
					prevPlat =  (char) is.read();
			    	prevSP = is.read();
			    	
				}
				System.out.println("prevPlat  "+ prevPlat+ "et " +prevSP);
		    	
		    	// on recoit le coup fictif [Z,0] si on est le premier coup
		    				
				pu.actualiserUPlateau(prevPlat, prevSP, ccA);
				
				// Consulter prolog
				Coup play = JSicstus.findMove("testJava", pu.toString(), pu.getSpSimple(), prevSP, symb);
				//Coup play = JSicstus.findMove("testJava", "[[l,l,l,x,l,x,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,o,l,o,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l]]", "[l,l,l,l,l,l,l,l,l]", 1, 'x');
				System.out.println(play);
				
				// Actualiser le plateau avec la case de prolog  
				pu.actualiserUPlateau(play.getNumCase(), play.getSousPlateau(), ccJ);
				
			    //System.out.println("Java -- Envoie d'une case");
				os.write(play.getNbSpGagne());
		    	os.write(Tools.intToCharSp(play.getSousPlateau()));
				os.write(play.getNumCase());
		    	
		    	prevPlat ='Z';
		    	prevSP = 0;
		    	System.out.println("FINboucle");
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