package java0626;

public class Thing2 {
	public int x;
	public int y;
	
	/*
	@Override
	public String toString() {
		String s = "x: " + this.x;
		s += ", ";
		s += "y: " + this.y;
		s += ", ";
		s += super.toString();
		return s; 
	}
	*/
	
	// 이클립스 소스 자동완성 기능 사용
	@Override
	public String toString() {
		return "Thing2 [x=" + x + ", y=" + y + "]";
	}
	
	// @Override
	// public void notify() { // final 메소드는 상속 불가
	// }
}