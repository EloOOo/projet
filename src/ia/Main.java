package ia;

import java.net.* ;
import java.io.* ;

public class Main 
{
	public static void main(String[] args) 
	{
		PlateauUltimate pu = new PlateauUltimate();
		
		if (args.length!=1){
		    System.out.println("argument - port");
		    System.exit(1);
		}
		System.out.println("Start Serveur");
		
		ServerSocket srv;
		int port = Integer.parseInt(args[0]);
		Case c =  new Case(EPlateau.D,ESousPlateau.HUIT);
		
		try 
		{
		    srv = new ServerSocket(port) ;
		    Socket s = srv.accept() ;
		    System.out.println("Acceptation");
		    OutputStream os =  s.getOutputStream();		    
///		    ObjectOutputStream oos = new ObjectOutputStream(os);
		    InputStream is = s.getInputStream();		    
		    
			while(pu.getPartieFinie() == false) {
				char prevPlat;
		    	int prevSP;
				try 
			    {
			    	prevPlat =  (char) is.read();
			    	prevSP = is.read();
					System.out.println("J'ai recu: " + prevPlat + " " + prevSP);
			    } 
			    catch (Exception e)
			    {
			    	System.err.println(e);
			    	e.printStackTrace();
			    }

			    System.out.println("Envoie d'une case -- A recupérer via Prolog");
		    	os.write(c.getNumPlat().getN());
		    	//oos.writeObject(c.getNumSousPlat().toString());
		    
			}
			
			s.close() ;	    
		    System.out.println("fin");
		    System.exit(0);
		} 
		catch(IOException e) 
		{
			System.err.println("Exception Serveur Java : " + e);
			e.printStackTrace();
		}	
	}
}
