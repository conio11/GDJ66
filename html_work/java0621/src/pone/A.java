package pone;
import pone.*; // 없으면 컴파일러에 의해 자동 추가
import ptwo.*;
import java.lang.*; // 없으면 컴파일러에 의해 자동 추가

public class A {
	public A() {} // 기본(디폴트) 생성자는 생성자(오버로딩 가능)가 하나도 없으면 컴파일러에 의해 자동 생성
	
	public void otherClassTest() {
		// 같은 패키지에 있는 B클래스
		pone.B b = new pone.B();
		
		// 다른 패키지에 있는 C클래스
		ptwo.C c = new ptwo.C();
		
		// 현재 클래스와 같은 패키지의 클래스는 풀네임을 사용하지 않아도 됨 X
		// 모든 클래스는 풀네임으로 표현해야 하나 import문이 있으면 클래스명으로 표현 가능
		// 모든 클래스는 자신의 패키지에 대해 import 패키지명.*; 가지고 있어야 함 (없을 시 컴파일러에 의해 자동 추가)
		// -> 현재 클래스와 같은 패키지의 클래스는 풀네임을 사용하지 않아도 됨 
		B b2 = new B(); 
		
		C c2 = new C();
		
		// 풀네임을 사용하지 않는 이유?
		// 모든 클래스는 import.java.lang.* 문을 포함하고 있어야 함 -> 없으면 컴파일러에 의해 자동 추가
		String s = new String("goodee");
		Integer i = 1;
	}
	
	public void modifierTest() {
		// 같은 패키지 접근제한자 - private만 접근 불가
		B b = new B();
		b.pubNum = 1;
		b.proNum = 2;
		b.defNum = 3;
		// b.priNum = 4;
		
		// 다른 패키지 접근제한자 - public만 접근 가능
		C c = new C();
		c.pubNum = 1;
		// c.proNum = 2; // protected의 경우 상속 관계의 클래스에서 접근 가능
		// c.defNum = 3;
		// c.priNum = 4;
	}
}