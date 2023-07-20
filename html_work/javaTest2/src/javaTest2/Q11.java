package javaTest2;

public class Q11 { // 답: 3번 (1245)
	static String result = "1";
	
	public static void main(String[] args) {
		method(0);
		System.out.println(result);
	}
	
	public static void method(int x) {
		try {
			x /= x; // ArithmeticException 예외 발생
		} catch (ArithmeticException e) {
			result += "2"; // 처리
		} catch (Exception e) {
			result += "3";
		} finally {
			result += "4"; // 항상 실행
		} 
		result += "5"; // 항상 실행
	}
}
