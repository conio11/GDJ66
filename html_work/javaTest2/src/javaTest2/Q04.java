package javaTest2;
// 캡슐화 - Player 클래스의 장점을 캡슐화 관점에서 설명
public class Q04 {
	public static void main(String[] args) {
		Player luffy = new Player();
		Player zoro = new Player();
		Player nami = new Player();
		
		System.out.println(luffy.getId());
		System.out.println(zoro.getId());
		System.out.println(nami.getId());
	}
}

class Player {
	private static int nextId = 1; // 1) why private? static? -> 외부 클래스, 패키지에서 직접 접근 불가하기 때문에 보안, 오류 방지 등에 유리. player 마다 id가 중복되지 않도록 정적인 변수를 사용함.
	private int id; // 2) why private? -> 외부 클래스, 패키지에서 직접 접근 불가하기 때문에 보안, 오류 방지 등에 유리.(유효하지 않은 값 입력 방지 등)
	public Player() { // 3) why public? -> 외부에서 Player() 타입 객체를 선언할 수 있도록 하기 위해 public 사용
		this.id = Player.nextId++;
	}
	protected int getId() { // 4) why protected? -> 같은 패키지나 상속받은 클래스에서는 id값을 가져올 수 있도록 하기 위함. (getId() 사용 가능 범위 제한)
		return id;
	}
	private void setId(int id) { // 5) why private? -> id 설정 시 클래스 외부의 영향을 받지 않도록 함
		this.id = id;
	}
}
