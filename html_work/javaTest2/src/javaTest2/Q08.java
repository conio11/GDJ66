package javaTest2;

public class Q08 { // 답: 2번 (10 true)
	private static int result = 0; // 0 -> 10
	private static boolean flag = false; // false -> true
	
	public static void main(String[] args) {
		Q08.setResult(10);
		Q08.display();
	}
	
	public static void setResult(int x) {
		Q08.flag = Q08.method1(x) || Q08.method2();
	}
	
	public static boolean method1(int x) {
		System.out.println("method1() 실행"); // 실행
		boolean temp = false;
		if (x > 0) {
			Q08.result = x;
			temp = true;
		}
		return temp;
	}
	
	public static boolean method2() {
		System.out.println("method2() 실행");
		Q08.result = Q08.result * 10;
		return true;
	}
	
	public static void display() {
		System.out.println(Q08.result + " ");
		System.out.println(Q08.flag);
	}
}
