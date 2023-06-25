package java0621;

public class Tutor extends Person {
	@Override // annotaion(시스템 주석): 부모 메소드 이름 확인 (다형성)
	public void playRole() {
		System.out.println(this.name + " 가르치다");
	}
}