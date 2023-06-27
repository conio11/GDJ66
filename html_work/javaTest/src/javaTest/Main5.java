package javaTest; // 5번 문제

public class Main5 {
	    public Main5(int a) {
	        this.a = a;
	    } 

	    int func() {
	        int b =1; 
	        for (int i=1; i<a; i++){ // a = 5;
	            b = a * i + b; // b = 5 * 1 + 1 = 6, b = 5 * 2 + 6 = 16, b = 5 * 3 + 16 = 31, b = 5 * 4 + 31 = 51
	        }
	        return a +b; // 56
	    }
	    
	    int a;
	 
	    public static void main(String[] args){
	        Main5 obj = new Main5(3); // obj.a = 3;
	        obj.a=5; // obj.a = 5;
	        int b = obj.func(); // 
	        System.out.print(obj.a + b); // 5 + 56 = 61
	    }
	}

