package javaTest; // 9번 문제 // 7

public class Main9 {
	 public static void main(String[] args) {
	  int a = 3, b = 4, c = 3, d = 5;
	  if((a == 2 | a == c) & !(c > d) & (1 == b ^ c != d)) { // 좌(ㅇ) 중(o) 우(o) // xor 연산: 비트값 다르면 1, 비트값 같으면 0
	   a = b + c; // a = 7
	    if(7 == b ^ c != a) { // 0, 1 -> 1
	     System.out.println(a); // 7
	    } else {
	    System.out.println(b);
	    }
	  } else {
	    a = c + d;
	    if(7 == c ^ d != a) {
	    System.out.println(a);
	    } else {
	    System.out.println(d);
	    }
	  }
	 }
	}

