package java0621;
// 2) 포함(has)
public class ThingExt2 {
	public Thing t; // 원본 타입(속성 + 메소드)을 포함
	public int pw; // 확장 속성
	// 원본 수정 시에도 확장본의 수정은 필요 X

	public static void main(String[] args) {
		ThingExt2 te = new ThingExt2();
		te.t = new Thing();
		te.t.id = 1; // 원본 속성
		te.t.printId(); // 원본 메소드
		te.pw = 2; // 확장 속성
		
		te.t.name = "goodee"; // 원본 수정(추가) 속성
	}
}