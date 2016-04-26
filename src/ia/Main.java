package ia;

import java.net.* ;
import java.io.* ;

public class Main 
{
	public static void main(String[] args) 
	{
		PlateauUltimate pu = new PlateauUltimate();
		
		if (args.length!=1){
		    System.out.println("Java -- argument - port");
		    System.exit(1);
		}
		System.out.println("Java -- Start Serveur");
		
		ServerSocket srv;
		int port = Integer.parseInt(args[0]);
		Case c =  new Case(EPlateau.D,ESousPlateau.HUIT);
		
		try 
		{
		    srv = new ServerSocket(port) ;
		    Socket s = srv.accept() ;
		    OutputStream os =  s.getOutputStream();	
		    InputStream is = s.getInputStream();		    
		    char prevPlat;
	    	int prevSP;
		    
			while(pu.getPartieFinie() == false) {
				
		    	prevPlat =  (char) is.read();
		    	prevSP = is.read();
				System.out.println("Java -- J'ai recu: " + prevPlat + " " + prevSP);
		    
			    //System.out.println("Java -- Envoie d'une case");
				os.write(c.getNumPlat().getN());
				os.flush();
		    	os.write(c.getNumSousPlat().getVal());
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
