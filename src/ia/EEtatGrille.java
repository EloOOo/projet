package ia;

public enum EEtatGrille {
	Egalite('e'),
	Croix('x'),
	Rond('o'),
	Libre('l');
	
	EEtatGrille(char s){
		symbole = s;
	}
	
	private char symbole;
	
	public char getS(){
		return symbole;
	}
	
	public String toString(){
		return ""+symbole;
	}

}
