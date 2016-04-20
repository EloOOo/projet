package ia;

public enum ESousPlateau {
	UN("UN",1),
	DEUX("DEUX",2),
	TROIS("TROIS",3),
	QUATRE("QUATRE",4),
	CINQ("CINQ",5),
	SIX("SIX",6),
	SEPT("SEPT",7),
	HUIT("HUIT",8),
	NEUF("NEUF",9);
	
	ESousPlateau(String n, int v){
		nom = n;
		val = v;
	}

	private String nom;
	private int val;

	public int getVal(){
		return val;
	}
	
	public String toString(){
		return nom;
	}
}
