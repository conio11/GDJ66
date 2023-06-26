package java0626;

public class GameMain {
	public static void main(String[] args) {
		// 청군
		Tank blueTank = new Tank();
		blueTank.hp = 100;
		
		Plane bluePlane = new Plane();
		bluePlane.hp = 50;
		
		// 백군
		Tank whiteTank = new Tank();
		whiteTank.hp = 100;
		
		Plane whitePlane = new Plane();
		whitePlane.hp = 50;
		
		// 청군이 공격
		blueTank.attack(whiteTank); // attack(GroundUnit u) u = whiteTank -> 다형성
		System.out.println(whiteTank.hp); // 99 
		// blueTank.attack(whitePlane); // 공격 불가
		
		bluePlane.attack(whiteTank); // attack(Unit u) u = whiteTank -> 다형성
		System.out.println(whiteTank.hp); // 98
		
		bluePlane.attack(whitePlane); // attack(Unit u) u = whiteTank -> 다형성
		System.out.println(whitePlane.hp); // 48
	}
}