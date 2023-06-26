package java0626;

public class RobotDog extends Robot implements IDog { 
	// 다중 상속 불가 -> 두 클래스 중 한쪽에 기능을 몰아주고 하나는 추상 클래스로 설정 또는 인터페이스 상속
	public void go() {
		System.out.println("RobotDog go");
	}
	
	public static void main(String[] args) {
		Robot r1 = new RobotDog(); // RobotDog의 부모 타입
		IDog r2 = new RobotDog(); // RobotDog의 부모 타입
		RobotDog r3 = new RobotDog();
		
		r3.name = "안드로이드";
		r3.onoff = true;
		r3.play();
		r3.go();
	}
}