package java0626;

public abstract class GroundUnit extends Unit { // 추상 클래스: 객체 생성 불가 -> 생성자 호출 불가
	public abstract void attack(GroundUnit u); // 이 메소드가 직접 실행될 일 X -> 추상 메소드로 설정
}