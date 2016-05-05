package ia;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;

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
		
		try 
		{
		    srv = new ServerSocket(port) ;
		   	    
		    char prevPlat = 0;
	    	int prevSP =0;
	    	Socket s = null;
	    	s = srv.accept();	
	    	OutputStream os =  s.getOutputStream();
			InputStream is = s.getInputStream();	
			DataInputStream dis = new DataInputStream(is);
			System.out.println("Java : début ");
			while(pu.getPartieFinie() == false) {
				prevPlat = 0;
				prevSP = 0;	
				if(is.available() > 0 ){
					while(prevPlat == 0){
						prevPlat = (char) is.read();
					}
					while(prevSP== 0){
						prevSP = dis.readInt();	
					}
					
					System.out.println("Java : J'ai recu " +Tools.charToIntSP(prevPlat) + " et " + prevSP);
					pu.actualiserUPlateau(Tools.charToIntSP(prevPlat), prevSP, ccA);
					
					// Consulter prolog
					Coup play = JSicstus.findMove("testJava", pu.toString(), pu.getSpSimple(), prevSP, symb);
					//Coup play = JSicstus.findMove("testJava", "[[l,l,l,x,l,x,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,o,l,o,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l],[l,l,l,l,l,l,l,l,l]]", "[l,l,l,l,l,l,l,l,l]", 1, 'x');
					System.out.println("SP :" +play.getSousPlateau() + " case :" + play.getNumCase() + " nb : " +play.getNbSpGagne() );
					// Actualiser le plateau avec la case de prolog  
					pu.actualiserUPlateau(play.getSousPlateau(),play.getNumCase(), ccJ);
					
					try{
						os.write(play.getNbSpGagne());
						os.flush();
						prevSP = dis.readInt();
						os.write(Tools.intToCharSp(play.getSousPlateau()));
						os.flush();
						prevSP = dis.readInt();
						os.write(play.getNumCase());
						os.flush();
						prevSP = dis.readInt();
					}catch(IOException e){
						System.out.println(e);
					}
				}
		
			}
			
			s.close() ;	    
		    System.out.println("Java -- fin");
		    System.exit(0);
		} 
		catch(Exception e) 	
		{
			System.err.println("Exception Serveur Java : " + e);
			e.printStackTrace();
		}
	}
}