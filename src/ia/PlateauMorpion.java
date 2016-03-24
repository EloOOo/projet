package ia;

public class PlateauMorpion {
	private ContenuCase[][] grille; 
	private EtatGrille estGagne;
	
	public PlateauMorpion() {
		grille = new ContenuCase[3][3];
		estGagne = EtatGrille.Dispo;
	}

	public ContenuCase[][] getGrille() {
		return grille;
	}

	public void setGrille(ContenuCase[][] grille) {
		this.grille = grille;
	}

	public EtatGrille getEstGagne() {
		return estGagne;
	}

	public void setEstGagne(EtatGrille estGagne) {
		this.estGagne = estGagne;
	}
	
	// [d,[1,2,3,4,5,6,7,8,9]]
	public String toString() {
		String str = "[";
		str += estGagne.toString() + ",[";
		int c = 1;
		for (int i=0; i<3;i++){
			for (int j=0; j<3;j++){
				if (grille[i][j] == ContenuCase.vide) {
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
