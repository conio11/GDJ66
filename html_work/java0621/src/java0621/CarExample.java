package java0621;

public class CarExample {
	public static void main(String[] args) {
		Car c; // Car 데이터타입에 객체(참조) 변수 c를 선언
		c = new Car(7); // c 변수 안에 Car 객체를 할당
		// c의 반환값은 new 연산의 결과가 반환
		// Car() 반환값이 없음
		// 이름만으로 호출 가능
		// new는 힙 메모리에 새 공간 확보
		System.out.println(c.id);
		
		// 기본 생성자가 없는 경우는 error
		Car c2 = new Car();
		System.out.println(c2.id);
		
		Car2 c1 = new Car2();
		// Car2() this => new 연산 영역
		// c1.model -> null
		// c1.color -> null
		// c1.maxSpeed -> 0
		
		System.out.println(c1.getMaxSpeed());
		// c1.getMaxSpeed() 안의 this -> c1 1) 객체 자신
		
		Car2 c3 = new Car2("그랜저");
		// this() -> 다른 생성자 바인딩
		System.out.println(c3.color);
	}
}
//Java: this가 바인딩하는 것
//1) 객체 자신(메소드) 2) new 연산결과(생성자) 3) 다른 생성자(this()) 


 