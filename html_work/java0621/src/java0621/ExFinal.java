package java0621;

public class ExFinal { // 클래스 앞에 final 붙이면 더 이상 확장(상속) 불가
	public final int id = 10; // 필드 변수 앞에 final 붙이면 상수
	
	public void print() {
		final int x = 7; // 지역변수 앞에 final 붙이면 상수
	}
	
	public final void test() { // 메소드 앞에 final 붙이면 자식 타입에서 오버라이딩 불가(클래스명으로 자식 생성은 가능)		
	}
}

class Ex2 extends ExFinal {
	// @Override
/*	public void test() {
		System.out.println("test() 오버라이딩");
	}
	*/
}