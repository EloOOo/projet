package ia;

public enum EPlateau {
	A('A'), B('B'), C('C'), D('D'), E('E'), F('F'), G('G'), H('H'), I('I');

	EPlateau(char n){
		nom = n;
	}
	
	private char nom;

	public char getN() {
		return nom;
	}
	
	public String toString(){
		return ""+nom;
	}
}
