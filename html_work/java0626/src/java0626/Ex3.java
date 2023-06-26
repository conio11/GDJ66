package java0626;

public class Ex3 {
	public static void main(String[] args) {
		Object o = new Object();
		String s = new String();
		
		o = s; // 개념의 범위: Object(부모)가 더 큼 -> 형변환 연산자 생략 가능
		s = (String) o; // 자식 -> 부모 형변환 시 형변환 연산자 필요 
		
		Thing t = new Thing(); // Thing: int x, int y 필드
		o = t; // 다형성
		// System.out.println(o.x); // 부모타입으로 형변환하면 필드가 존재함에도 숨겨져 호출 불가
		
		Object o2 = new Thing();
		// System.out.println(o2.x); // 호출 불가
		
		Thing t2 = (Thing) o2; // 부모타입 -> 자식타입 변환: 형변환 연산자 필요
		System.out.println(t2.x);
		// System.out.println(((Thing)o2).y);
		
		/*
		Person p = (Person) o2; // 참조타입은 모두 강제 형변환 가능
		p.name = "구디"; // 코드 상 오류 없으나 실행 시 예외 발생 
		*/
		
		// 강제 형변환 시 instanceof 연산자를 같이 사용 -> 안전장치
		if (o2 instanceof Person) {
			Person p = (Person) o2;
			p.name = "구디";
		} else {
			System.out.println(o2 instanceof Person); // false
			System.out.println("o2 -> Person으로 형변환 불가");
		}
	}
}