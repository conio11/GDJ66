package java0626;

public class Tank extends GroundUnit {
	// public int hp;
	public int mode;
	@Override
	public void attack(GroundUnit u) {
		u.hp -= 10;
	}
	
	/*
	public void attack(Tank t) { 
		if (t.hp > 0) {
			t.hp = t.hp - 1;
		}
	}
	*/
}