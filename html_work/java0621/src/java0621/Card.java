package java0621;

public class Card {
	// 정적(static) 필드 / 클래스 멤버 (객체가 갖는 값이 아님) 
	// this 사용 불가
	public static int width;
	public static int height;
	
	// 인스턴스 필드 / 객체 멤버
	public int num;
	public String kind;
	
	public static void main(String[] args) {
		Card c1;
		c1 = new Card();
		
		Card c2;
		c2 = new Card();
		
		c1.width = 200;
		c1.height = 250;
		c1.num = 1;
		c1.kind = "spade";
		
		c2.width = 100;
		c2.height = 150;
		c2.num = 2;
		c2.kind = "diamond";
		
		System.out.println(Card.width); // 100
		
	}
	
	
	
}
