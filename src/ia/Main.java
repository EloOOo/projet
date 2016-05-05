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
		   	    
		    char prevPlat = 'Z';
	    	int prevSP =0;
	    	int prevPlatInt =0;
	    	Socket s = null;
	    	s = srv.accept();	
	    	OutputStream os =  s.getOutputStream();	
			InputStream is = s.getInputStream();	
			while(pu.getPartieFinie() == false) {
				
				System.out.println("boucle");
				System.out.println("bit : "+is.available());
				while(is.available() >0){
					prevPlatInt =  is.read();
					prevSP = is.read();
				}
				
				prevPlat = (char)prevPlatInt;
				prevPlatInt = Tools.charToIntSP(prevPlat);
				pu.actualiserUPlateau(prevPlatInt, prevSP, ccA);
				
				// Consulter prolog
				Coup play = JSicstus.findMove("testJava", pu.toString(), pu.getSpSimple(), prevSP, symb);
				//Coup play = JSicstus.findMove("testJava", "[[l,l,l,x,l,x,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,o,l,o,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l]]", "[l,l,l,l,l,l,l,l,l]", 1, 'x');
				System.out.println("SP :" +play.getSousPlateau() + "case :" + play.getNumCase() + "nb : " +play.getNbSpGagne() );
				// Actualiser le plateau avec la case de prolog  
				pu.actualiserUPlateau(play.getSousPlateau(),play.getNumCase(), ccJ);
			

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