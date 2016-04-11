package ia;

public enum ESousPlateau {
	UN("UN"),
	DEUX("DEUX"),
	TROIS("TROIS"),
	QUATRE("QUATRE"),
	CINQ("CINQ"),
	SIX("SIX"),
	SEPT("SEPT"),
	HUIT("HUIT"),
	NEUF("NEUF");
	
	ESousPlateau(String n){
		nom = n;
	}
	
	private String nom;

	public String toString(){
		return nom;
	}
}
