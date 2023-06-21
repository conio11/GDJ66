package java0621;

public class Car2 {
	public String model;
	public String color;
	public int maxSpeed;
	
	// 기본생성자
	public Car2() {
		this.model = null;
		this.color = null;
		this.maxSpeed = 0;
	}
	
	// 모든 필드의 매개값을 가지는 생성자
	public Car2(String model, String color, int maxSpeed) {
		this.model = model;
		this.color = color;
		this.maxSpeed = maxSpeed;
	}
	
	// 필드 하나 매개값을 갖는 생성자
	public Car2(String model) {
		// this.model = model;
		// this.color = "#FFFFFF";
		// this.maxSpeed = 300;
		// Car2(model, "#FFFFFF", 300); 와 같은 형태로 사용 불가
		this(model, "#FFFFFF", 300);
	}
	
	public int getMaxSpeed() {
		return this.maxSpeed;
	}
	
	
}
// Java: this가 바인딩하는 것
// 1) 객체 자신(메소드) 2) new 연산결과(생성자) 3) 다른 생성자(this())