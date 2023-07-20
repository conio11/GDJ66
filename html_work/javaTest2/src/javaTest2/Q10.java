package javaTest2;

public class Q10 { // 답: 1번 (춤춘다, 연기한다)
	public static void main(String[] args) {
		Person[] persons = new Person[2];
		persons[0] = new Dancer();
		persons[1] = new Actor();
		for (int i = 0; i < persons.length; i++) { // 다형성
			persons[i].play(); // persons[0], persons[1]의 값 설정
			// persons[i].test(); // 오버라이딩 메소드 아님 -> Person 타입으로 참조 불가
			persons[i].display(); // 춤춘다 / 연기한다
		}
	}
}

abstract class Person {
	String str;
	abstract void play();
	
	void display() {
		System.out.println(str);
	}
}

class Dancer extends Person { // Person p = new Dancer();
	@Override
	protected void play() {
		str = "춤춘다";
	}
	public void test() {}
}

class Actor extends Person {
	@Override
	protected void play() {
		str = "연기한다";
	}
}