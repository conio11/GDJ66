package java0621;

public class ThingExt1 {
	public int id;
	public void printId() {}
	
	public int pw;
	
	// 1) 데이터타입(코드) 재활용 첫 번째 방법(복사)
	// 원본 수정 -> 확장본도 수정 필요
	public String name;
	
	// 디버깅 용도로 static main 메소드 추가
	public static void main(String[] args) {
		ThingExt1 t = new ThingExt1();
		t.id = 1; // 원본 복사 속성
		t.printId(); // 원본 복사 메소드
		t.pw = 2; // 확장본 속성
		t.name = "t"; // 원본 수정(추가) 속성
	}
}