package ia;

public enum EEtatGrille {
	Egalite('e'),
	Croix('x'),
	Rond('o'),
	Dispo('d');
	
	EEtatGrille(char s){
		symbole = s;
	}
	
	private char symbole;
	
	public String toString(){
		return ""+symbole;
	}

}
