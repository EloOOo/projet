package ia;

public class PlateauMorpion {
	private EContenuCase[][] grille; 
	private EEtatGrille estGagne;
	
	public PlateauMorpion() {
		grille = new EContenuCase[3][3];
		estGagne = EEtatGrille.Dispo;
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
	
	// [d,[1,2,3,4,5,6,7,8,9]]
	public String toString() {
		String str = "[";
		str += estGagne.toString() + ",[";
		int c = 1;
		for (int i=0; i<3;i++){
			for (int j=0; j<3;j++){
				if (grille[i][j] == EContenuCase.vide) {
					str += c;
				} else {
					str += grille[i][j].toString();
				}
				if(c != 9) str += ",";
				c++;
			}
		}
		return str + "]]";
	}
}
