package javaTest2;
// 다형성 - 컴파일 시 오류가 발생되는 라인 체크
public class Q06 {
	public static void main(String[] args) {
		Parent parent = new Parent();
		((Child)parent).subMethod();
		
		Child child = new Child();
		
		parent = child;
		child = (Child) parent;
		
		parent.subMethod(); // 자식 메소드 접근 불가
		
		((Child)parent).subMethod();
		
		child.superMethod();
		
		System.out.println(parent.a); // private - 외부 접근 불가
		System.out.println(parent.b);
		System.out.println(parent.c);
		System.out.println(parent.x); // Parent 타입이 가진 값이 아님
		System.out.println(parent.y); // Parent 타입이 가진 값이 아님
		System.out.println(parent.z); // Parent 타입이 가진 값이 아님
		
		System.out.println(child.a); // private - 외부 접근 불가
		System.out.println(child.b); 
		System.out.println(child.c); 
		System.out.println(child.x); // private - 외부 접근 불가
		System.out.println(child.y);
		System.out.println(child.z);
	}
}

class Parent {
	private int a = 1;
	protected int b = 2;
	public int c = 3;
	
	public void superMethod() {
		System.out.println("superMethod");
	}
}

class Child extends Parent {
	private int x = 4;
	protected int y = 5;
	public int z = 6;
	
	public void subMethod() {
		System.out.println("subMethod");
	}
}
