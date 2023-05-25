package service;

public class ExceptionTest {
	public void test(int x) {
	//public double divide(double x, double y) {
		// double result = x / y;
		// return result;
		// Class.forName("java.util.String"); // 메모리에 클래스 로딩
		try {
			int[] arr = new int[x];
			arr[0] = 100;
			arr[1] = 200;
		} catch (Exception e) { // 예외 발생 시 해당 구문 실행
			System.out.println("예외 발생");
		}
		
	}
	
	public void test2(String s) {
		try {
			int n = Integer.parseInt(s);
			System.out.println(n);
		} catch (Exception e) {
			System.out.println("숫자로 변경 가능한 문자를 입력하세요.");
		}
	}
	
	public void test3() throws Exception { // 예외 던짐 (외부에서 실행하도록)
		Class.forName("java.lang.String");
	}
	
	// 테스트 코드
	public static void main(String[] args) throws Exception {
		// ExceptionTest et = new ExceptionTest();
		// double result = et.divide(10, 0); 
		// System.out.println(result);
		ExceptionTest et = new ExceptionTest();
		et.test(3);
		// et.test(1);
		
		et.test2("100");
		et.test2("9디");
		
		et.test3();
	}
}
