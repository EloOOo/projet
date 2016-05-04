package ia;

public class Tools {
	
	public static char intToCharSp(int i){
		char ch;
		
		switch(i) {
		case 1 :
			ch = 'A'; break;
		case 2 :
			ch = 'B'; break;
		case 3 :
			ch = 'C'; break;
		case 4 :
			ch = 'D'; break;
		case 5 :
			ch = 'E'; break;
		case 6 :
			ch = 'F'; break;
		case 7 :
			ch = 'G'; break;
		case 8 :
			ch = 'H'; break;
		case 9 :
			ch = 'I'; break;
		default :
			ch = 'A'; break;
		}	
		
		return ch;
	}

	public static int charToIntSP(char ch) {
		int i = 0;

		switch(ch) {
		case 'A' :
			i = 1; break;
		case 'B' :
			i = 2; break;
		case 'C' :
			i = 3; break;
		case 'D' :
			i = 4; break;
		case 'E' :
			i = 5; break;
		case 'F' :
			i = 6; break;
		case 'G' :
			i = 7; break;
		case 'H' :
			i = 8; break;
		case 'I' :
			i = 9; break;
		default :
			ch = 0; break;
		}	
		
		return 0;
	}
}
