package ia;

public class PlateauMorpion {
	private EContenuCase[][] grille; 
	private EEtatGrille estGagne;
	
	public PlateauMorpion() {
		grille = new EContenuCase[3][3];
		estGagne = EEtatGrille.Libre;
		for(int i=0;i<3;i++){
			for(int j=0;j<3;j++){
				grille[i][j] = EContenuCase.libre;
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
	
	public void actualiseWin() {
		if(grille[0][0] == grille[0][1] && grille[0][1] == grille[0][2])
		{
			if(grille[0][0] == EContenuCase.croix) estGagne = EEtatGrille.Croix;
			if(grille[0][0] == EContenuCase.rond) estGagne = EEtatGrille.Rond;
		}
		else if(grille[1][0] == grille[1][1] && grille[1][1] == grille[1][2])
		{
			if(grille[1][0] == EContenuCase.croix) estGagne = EEtatGrille.Croix;
			if(grille[1][0] == EContenuCase.rond) estGagne = EEtatGrille.Rond;
		}
		else if(grille[2][0] == grille[2][1] && grille[2][1] == grille[2][2])
		{
			if(grille[2][0] == EContenuCase.croix) estGagne = EEtatGrille.Croix;
			if(grille[2][0] == EContenuCase.rond) estGagne = EEtatGrille.Rond;
		}
		else if(grille[0][0] == grille[1][0] && grille[1][0] == grille[2][0])
		{
			if(grille[0][0] == EContenuCase.croix) estGagne = EEtatGrille.Croix;
			if(grille[0][0] == EContenuCase.rond) estGagne = EEtatGrille.Rond;
		}
		else if(grille[0][1] == grille[1][1] && grille[1][1] == grille[2][1])
		{
			if(grille[0][1] == EContenuCase.croix) estGagne = EEtatGrille.Croix;
			if(grille[0][1] == EContenuCase.rond) estGagne = EEtatGrille.Rond;
		}
		else if(grille[0][2] == grille[1][2] && grille[1][2] == grille[2][2])
		{
			if(grille[0][2] == EContenuCase.croix) estGagne = EEtatGrille.Croix;
			if(grille[0][2] == EContenuCase.rond) estGagne = EEtatGrille.Rond;
		}
		else if(grille[0][0] == grille[1][1] && grille[1][1] == grille[2][2])
		{
			if(grille[0][0] == EContenuCase.croix) estGagne = EEtatGrille.Croix;
			if(grille[0][0] == EContenuCase.rond) estGagne = EEtatGrille.Rond;
		}
		else if(grille[0][2] == grille[1][1] && grille[1][1] == grille[2][0])
		{
			if(grille[0][1] == EContenuCase.croix) estGagne = EEtatGrille.Croix;
			if(grille[0][1] == EContenuCase.rond) estGagne = EEtatGrille.Rond;
		}	
	}
	
	
	public void actualiserPlateau(int numCase, EContenuCase s) {
		int c = 0;
		for (int i=0; i<3;i++){
			for (int j=0; j<3;j++){
				if(c== numCase) 
				{
					grille[i][j] = s;
					actualiseWin();
				}
				c++;
			}
		}
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
