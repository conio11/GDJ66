package java0626;

public class Marine extends GroundUnit {
	@Override
	public void attack(GroundUnit u) {
		u.hp -= 1;
	}
	
	/*
	 * public void gong(GroundUnit u) { u.hp -= 1; }
	 */
}
