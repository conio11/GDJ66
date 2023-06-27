package javaTest; // 11번 문제 // 0+1+2+3+4+5=15 

public class Main11 {
	public static void main(String[] args){
    int i, j;
    for(j=0, i=0; i<=5; i++){
    	j+=i; // j = j + i // 0 1 3 6 10 15
    	System.out.print(i); // 0 + 1 + 2 + 3 + 4 + 5 
    	if(i==5) {
    		System.out.print("=");  // = 15
    		System.out.print(j); //
   } else{
   	System.out.print("+");
	}
   }
  }
 }

// 0+1+2+3+4+5=15 
