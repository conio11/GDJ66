package vo;
// 추상화 (vo는 타겟 테이블 추상화)
public class Sample {
	// 생성자 오버로딩
	public Sample() { // 디폴트 생성자
		// super(); // Object()
		// this.x = 0;
		// this.y = 0;
	}
	
	public Sample(int x, int y) { // 생성자 없어도 자동 생성(디폴트 생성자), source - Generate
		super(); // Object()
		this.x = x;
		this.y = y;
	}
	
	// 정보은닉: 자바 언어는 모든 필드를 정보은닉하는 규칙이 존재
	private int x;
	private int y;
	
	// 정보은닉된 필드 or 메소드를 부분 노출 -> 캡슐화 (setter, getter 모두 생성)
	public int getX() {
		return x;
	}
	public void setX(int x) {
		this.x = x;
	}
	public int getY() {
		return y;
	}
	public void setY(int y) {
		this.y = y;
	}

	@Override
	public String toString() { // 디버깅 - 메소드 내 필드값 확인 가능
		return "Sample [x=" + x + ", y=" + y + "]";
	}
}