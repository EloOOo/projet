package ia;

public class Coup {
	private int sousPlateau;
	private int numCase;
	private int nbSpGagne;
	
	public Coup(int sp, int c, int nb)
	{
		sousPlateau = sp;
		numCase = c;
		nbSpGagne = nb;
	}
	
	public int getSousPlateau() {
		return sousPlateau;
	}
	public void setSousPlateau(int sousPlateau) {
		this.sousPlateau = sousPlateau;
	}
	public int getNumCase() {
		return numCase;
	}
	public void setNumCase(int numCase) {
		this.numCase = numCase;
	}
	public int getNbSpGagne() {
		return nbSpGagne;
	}
	public void setNbSpGagne(int nbSpGagne) {
		this.nbSpGagne = nbSpGagne;
	}

	public String toString() {
		return "[" + sousPlateau + ',' + numCase + "] -" + nbSpGagne;
	}
	
}
