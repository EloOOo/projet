package ia;

import java.io.Serializable;

public class Case implements Serializable {
	private static final long serialVersionUID = 1L;
	private EPlateau numPlat;
	private ESousPlateau numSousPlat;
	
	public Case(EPlateau np, ESousPlateau nsp) {
		numPlat = np;
		numSousPlat = nsp;
	}
	
	public EPlateau getNumPlat() {
		return numPlat;
	}
	public void setNumPlat(EPlateau numPlat) {
		this.numPlat = numPlat;
	}
	public ESousPlateau getNumSousPlat() {
		return numSousPlat;
	}
	public void setNumSousPlat(ESousPlateau numSousPlat) {
		this.numSousPlat = numSousPlat;
	}
}
