package ia;

public class PlateauUltimate {
	private PlateauMorpion[][] plateau;
	private boolean partieFinie;

	public PlateauUltimate() {
		plateau = new PlateauMorpion[3][3];
		partieFinie = false;
		for(int i=0;i<3;i++){
			for(int j=0;j<3;j++){
				plateau[i][j] = new PlateauMorpion();
				plateau[i][j].setEstGagne(EEtatGrille.Libre);
			}
		}
		
	}
	
	public PlateauMorpion[][] getPlateau() {
		return plateau;
	}

	public void setPlateau(PlateauMorpion[][] plateau) {
		this.plateau = plateau;
	}
	
	public boolean getPartieFinie() {
		return partieFinie;
	}

	public void setPartieFinie(boolean pf) {
		partieFinie = pf;
	}
	
	public int compteSPGagnant() {
		int c = 0;
		for (int i=0; i<3;i++){
			for (int j=0; j<3;j++){
				if (plateau[i][j].getEstGagne() == EEtatGrille.Rond || 
					plateau[i][j].getEstGagne() == EEtatGrille.Croix)
					c++;
			}
		}
		return c;
	}

	public void actualiserUPlateau(int numPlateau, int numCase, int gagne, EContenuCase s) {
		for (int i=0; i<3;i++){
			for (int j=0; j<3;j++){
				if((i+1)*(j+1)== numPlateau)
					plateau[i][j].actualiserPlateau(numCase, s, gagne);
			}
		}
	}
	
	// représentation du plateau ultimate sous forme d'un sous plateau simple
	public String getSpSimple() {
		String str = "[";
		int c = 1;
		for (int i=0; i<3;i++){
			for (int j=0; j<3;j++){
				str += plateau[i][j].strEstGagne();
				if (c!=9) str += ",";
				c++;
			}
		}
		return str +"]";	
	}
	
	// [[1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],[1,2,3,4,5,6,7,8,9],[1,2,3,4,5,6,7,8,9],[1,2,3,4,5,6,7,8,9],[1,2,3,4,5,6,7,8,9],[1,2,3,4,5,6,7,8,9],[1,2,3,4,5,6,7,8,9],[1,2,3,4,5,6,7,8,9]]
	public String toString() {
		String str = "[";
		int c = 1;
		for (int i=0; i<3;i++){
			for (int j=0; j<3;j++){
				str += plateau[i][j].toString();
				if (c!=9) str += ",";
				c++;
			}
		}
		return str +"]";
	}
}
