package ia;

public class PlateauUltimate {
	private PlateauMorpion[][] plateau;

	public PlateauUltimate() {
		plateau = new PlateauMorpion[3][3];
	}
	
	public PlateauMorpion[][] getPlateau() {
		return plateau;
	}

	public void setPlateau(PlateauMorpion[][] plateau) {
		this.plateau = plateau;
	}
	
	
	// [[d,[1,2,3,4,5,6,7,8,9]], [d,[1,2,3,4,5,6,7,8,9]],[d,[1,2,3,4,5,6,7,8,9]],[d,[1,2,3,4,5,6,7,8,9]],[d,[1,2,3,4,5,6,7,8,9]],[d,[1,2,3,4,5,6,7,8,9]],[d,[1,2,3,4,5,6,7,8,9]],[d,[1,2,3,4,5,6,7,8,9]],[d,[1,2,3,4,5,6,7,8,9]]]
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
