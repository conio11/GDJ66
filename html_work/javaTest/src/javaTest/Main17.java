package javaTest; // 17번 문제 // (빈칸) new

class Parent {
	public void show(){
		System.out.println("Parent");
		}
}

class Child1 extends Parent{
	public void show(){
		System.out.println("Child");
	}
}

public class Main17 {
public static void main(String[] args){
	Parent pa = new Child1(); // new
    pa.show();
	}
}

// new
