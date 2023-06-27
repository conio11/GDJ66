package javaTest; // 13번 문제 // (빈칸) 3, 5

public class Main13 {
	public static void main(String[] args) {
    	int[][]a = new int[3][5];
        for(int i = 0; i <3; i++){ // i = 0, 1, 2
        	for(int j=0; j < 5; j++){ // j = 0, 1, 2, 3, 4
    			a[i][j] = j*3+(i+1); // a[0][0] = 1 a[0][1] = 3 + 1 = 4 a[0][2] = 6 + 1 = 7 a[0][3] = 9 + 1 = 10 a[0][4] = 12 + 1 = 13
        	System.out.print(a[i][j]+"");
         }
         System.out.println(); 
       }
     }
   } 
