package javaTest2;

public class Q03 { // 답: 20 / 210
	public static void main(String[] args) {
		Q03 q = new Q03();
		int a = 20;
		int[] b = {100, 200, 300}; // 참조 타입
		q.change(a, b); // a = 20, b = 200 -> 210 (참조 타입의 값만 바뀜)
		q.display(a, b);	
	}
	
	void change(int a, int[] b) {
		a = a + 10; 
		b[1] = b[1] + 10;
	}
	
	void display(int a, int b[]) {
		System.out.println(a + "/" + b[1]);
	}
}
