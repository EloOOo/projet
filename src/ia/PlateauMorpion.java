package ia;

public class PlateauMorpion {
	private EContenuCase[][] grille; 
	private EEtatGrille estGagne;
	
	public PlateauMorpion() {
		grille = new EContenuCase[3][3];
		estGagne = EEtatGrille.Libre;
		for(int i=0;i<3;i++){
			for(int j=0;j<3;j++){
				grille[i][j] = EContenuCase.vide;
			}
		}
		
	}

	public EContenuCase[][] getGrille() {
		return grille;
	}

	public void setGrille(EContenuCase[][] grille) {
		this.grille = grille;
	}

	public EEtatGrille getEstGagne() {
		return estGagne;
	}

	public void setEstGagne(EEtatGrille estGagne) {
		this.estGagne = estGagne;
	}
	
	
	public void actualiserPlateau(int numCase, EContenuCase s, int gagne) {
		for (int i=0; i<3;i++){
			for (int j=0; j<3;j++){
				if((i+1)*(j+1)== numCase)
					grille[i][j] = s;
			}
		}
		if (gagne == 1)
			estGagne = EEtatGrille.Croix;
		else if (gagne == 2)
			estGagne = EEtatGrille.Rond;
		//else if (gagne == 3)
		//	estGagne = EEtatGrille.Egalite;
	}
	
	public String strEstGagne() {
		String str = "[";	
		int c = 1;
		for (int i=0; i<3;i++){
			for (int j=0; j<3;j++){
				str += estGagne.toString() ;
				if(c != 9) str += ",";
				c++;
			}
		}
		return str + "]";
	}
	
	// [1,2,3,4,5,6,7,8,9]
	public String toString() {
		String str = "[";
		int c = 1;
		for (int i=0; i<3;i++){
			for (int j=0; j<3;j++){
				str += grille[i][j].toString();
				
				if(c != 9) str += ",";
				c++;
			}
		}
		return str + "]";
	}
}
