package javaTest; // 12번째 문제 // (빈칸) i <= n, n - i

class Main12 {
	// 출력결과: 00001010
	public static void main (String[] args) {
    	int[]a = new int[8];
        int i=0; int n=10;
        while (i <= a.length - 1) { 
        	a[i++] = n % 2; 
            n /= 2;
        }
        for(i=7; i>=0; i--){
         System.out.print(a[i]);
        }
     }
  }
