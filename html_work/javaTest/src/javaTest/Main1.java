package javaTest; // 1번 문제 // 10 11 10 20
	 
	class Static{
		public int a = 20; // this.a 객체 수만큼 존재
		static int b = 0; // Static.b 클래스에 하나만 존재 (공통값)
	}
	
	public class Main1{
	    public static void main(String[] args) {
	        
	        int a;
	        a = 10;
	        Static.b = a;
	 
	        Static st = new Static();
	 
	        System.out.println(Static.b++); // 10
	        System.out.println(st.b); // 11
	        System.out.println(a); // 10
	        System.out.print(st.a); // 20 
	    } 
	}