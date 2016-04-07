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
		System.out.println("Main");
		ThrServeurJava thr =  new ThrServeurJava(Integer.parseInt(args[0]));	
		thr.start();
		
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
