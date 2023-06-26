package java0626;

public class TankMain {
	public static void main(String[] args) {
		// 1) 추상클래스의 객체는 생성 불가
		// Unit u1 = new Unit();
		// GroundUnit gu1 =  new GroundUnit();
		
		// 2) 다형성
		Unit u = new Tank();
		GroundUnit gu = new Tank();
	}
}