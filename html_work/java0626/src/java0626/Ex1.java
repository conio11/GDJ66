package java0626;

public class Ex1 {
	public static void main(String[] args) {
		// toString() 메소드 오버라이딩 안된 경우
		Thing t = new Thing();
		t.x = 10;
		t.y = 100;
		// String s = t.toString();
		System.out.println(t); // println 매개값으로 객체가 들어오면 객체의 toString() 결과를 출력
		
		// 필드 디버깅 코드
		System.out.println("x값: " + t.x);
		System.out.println("y값: " + t.y);
		
		// Object 클래스의 일부 메소드는 오버라이딩 용도로 사용되기도 함
		// toString() 클래스 필드: 디버깅용으로 사용
		// Thing2 클래스 toString() 오버라이딩한 경우
		Thing2 t2 = new Thing2();
		t2.x = 7;
		t2.y = 9;
		System.out.println(t2); // t2.toString() 결과 출력
	}
}