package ia;

import java.net.* ;
import java.io.* ;

public class Main 
{
	public static void main(String[] args) 
	{
		// TODO: initialiser un plateau vide

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
//		    InputStream is = s.getInputStream();
//		    
//		    try 
//		    {
//		    	int varTest;
//		    	System.out.println("Attente d'un int");
//				varTest =  is.read();
//				
//				System.out.println("J'ai recu: " + varTest);
//		    } 
//		    catch (Exception e)
//		    {
//		    	System.err.println(e);
//		    	e.printStackTrace();
//		    }

	    	System.out.println("Envoie d'une case -- A recupérer via Prolog");
	    	os.write(c.getNumPlat().getN());
	    	//oos.writeObject(c.getNumSousPlat().toString());
	    	s.close() ;
		    
		    System.out.println("fin");
		    System.exit(0);
		} 
		catch(IOException e) 
		{
			System.err.println("Exception Serveur Java : " + e);
			e.printStackTrace();
		}	
		
		/*	
		PlateauUltimate pu = new PlateauUltimate();
		ContenuCase[][] cg = new ContenuCase[3][3];
		PlateauMorpion[][] plat = new PlateauMorpion[3][3];
		cg[0][0] = ContenuCase.vide;
		cg[0][1] = ContenuCase.rond;
		cg[0][2] = ContenuCase.croix;
		cg[1][0] = ContenuCase.rond;
		cg[1][1] = ContenuCase.rond;
		cg[1][2] = ContenuCase.croix;
		cg[2][0] = ContenuCase.croix;
		cg[2][1] = ContenuCase.croix;
		cg[2][2] = ContenuCase.vide;
		
		for(int i=0;i<3;i++){
			for(int j=0;j<3;j++){
				plat[i][j] = new PlateauMorpion();
				plat[i][j].setEstGagne(EtatGrille.Dispo);
				plat[i][j].setGrille(cg);
			}
		}
		plat[0][0].setEstGagne(EtatGrille.Croix);
		plat[0][1].setEstGagne(EtatGrille.Rond);
		plat[0][2].setEstGagne(EtatGrille.Egalite);
		pu.setPlateau(plat);
		System.out.println(pu);
		*/
	}
}
