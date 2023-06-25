package java0621;
// 3) 상속(is)
// Object -> Thing -> ThingExt3
public class ThingExt3 extends Thing {
	public ThingExt3() {
		super(); // 생성자 호출 시 부모 생성자 먼저 호출
		this.pw = 0;
	}
	public int pw;
	
	public static void main(String[] args) {
		ThingExt3 te = new ThingExt3();
		// Thing 속성
		te.id = 1;
		// Thing 메소드
		te.printId();
		// ThingExt3 속성
		te.pw = 2;
		// Thing 속성
		te.name = "goodee";
		// Object 메소드
		String s = te.toString();
	}	
}