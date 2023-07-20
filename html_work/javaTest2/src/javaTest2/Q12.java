package javaTest2;

public class Q12 {
	public static void main(String[] args) {
		StringBuffer stringbuffer = new StringBuffer("Stringbuffer");
		StringBuffer test = new StringBuffer("Test");
		method(stringbuffer, test);
		System.out.println(stringbuffer);
		System.out.println(test);
	}
	
	static void method(StringBuffer sb1, StringBuffer sb2) {
		sb1.append(sb2);
		sb2 = sb1;
	}
}
