package ia;

public enum EContenuCase {
	libre('l'),
	rond('o'),
	croix('x');
	
	EContenuCase(char s){
		symbole = s;
	}
	
	private char symbole;
	
	public String toString(){
		return ""+symbole;
	}
}
