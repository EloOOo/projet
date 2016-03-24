package ia;

public enum EtatGrille {
	Egalite('e'),
	Croix('x'),
	Rond('o'),
	Dispo('d');
	
	EtatGrille(char s){
		symbole = s;
	}
	
	private char symbole;
	
	public String toString(){
		return ""+symbole;
	}

}
