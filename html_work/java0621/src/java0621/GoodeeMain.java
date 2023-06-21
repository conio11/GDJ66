package java0621;

public class GoodeeMain {
	public static void main(String[] args) {
		// Goodee g1 = new Goodee(); // 사용 불가
		
		// 기존 생성자 사용 불가 -> 사용자 정의 생성자 O
		Goodee g1 = Goodee.newInstance();
		Goodee g2 = Goodee.newInstance();
		
		System.out.println(g1.hashCode());
		System.out.println(g2.hashCode());
		
		g1.address = "KM타워";
		System.out.println(g2.address);
		
		// 사용자 정의 생성자 싱글톤 알고리즘 (new 한번만)	
	}
}
