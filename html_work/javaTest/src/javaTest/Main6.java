package javaTest; // 6번 문제

	class A1 {
		  int a;
		  int b;
		}
		  
	public class Main6 {
	  static void func1(A1 m){
	   m.a *= 10;
	  }
	  
	  static void func2(A1 m){
	    m.a += m.b;
	  }
	  
	  public static void main(String args[]){
	  
	      A1 m = new A1();
	  
	      m.a = 100; // m.a = 100;
	      func1(m); // m.a = 100 * 10 = 1000;
	      m.b = m.a; // m.b = 1000
	      func2(m); // m.a = m.a + 1000 = 1000 + 1000 = 2000
	   
	      System.out.printf("%d", m.a); // 2000
	  }
}