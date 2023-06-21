package java0621;

public class Goodee {
	public String address;
	private Goodee() {} // private: 외부에서 호출 불가
	
	/*
	// 기존 생성자 사용 불가 -> 사용자 정의 생성자 O
	public static Goodee newInstance() { // 생성자 형태 바꿈
		Goodee g = new Goodee();
		return g;
	}
	*/
	
	// 싱글톤
	private static Goodee g = new Goodee();
	public static Goodee newInstance() {
		return Goodee.g;
	}
	
	/*
	public static void main(String args[]) {
		Goodee g1 = new Goodee();
		g1.address = "서울";
		Goodee g2 = new Goodee();
		g2.address = "서울";
		
		System.out.println(g1.hashCode() + g1.address);
		System.out.println(g2.hashCode() + g2.address);
	}
	*/
}
