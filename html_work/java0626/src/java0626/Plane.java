package java0626;

public class Plane extends AirUnit {
	// public int hp;
	/*
	public void attack(Tank t) {
		if (t.hp > 0) {
			t.hp = t.hp - 1;
		}
	}
	*/
	
	public void attack(Unit u) { // 오버로딩
		if (u instanceof GroundUnit) {
			u.hp -= 1;
		} else if (u instanceof AirUnit) {
			u.hp -= 2;
		}
	}
	
	// 단점: 유닛이 많아지면 유닛별로 모두 오버로딩 해야 함
	/*
	public void fly() {
		System.out.println("비행하다");
	}
	*/
}