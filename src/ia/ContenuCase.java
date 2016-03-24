package ia;

public enum ContenuCase {
	vide('v'),
	rond('o'),
	croix('x');
	
	ContenuCase(char s){
		symbole = s;
	}
	
	private char symbole;
	
	public String toString(){
		return ""+symbole;
	}
}
