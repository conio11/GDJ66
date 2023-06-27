package javaTest; // 3번 문제 // 993

public class Main3 {
	  public static void main(String[] args){
	  
	  int a = 0;
	  for (int i = 1; i < 999; i++) {
	    if (i % 3 == 0 && i % 2 != 0) // 999 미만의 수 중 3의 배수이면서 2의 배수는 아니고 가장 큰 수 -> 3, 9, 27, ... 999, 996(x), 993 
	      a = i;
	    }
	    System.out.print(a); // 993
	  }
	}