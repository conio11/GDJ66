package javaTest;

public class Test {
	public static void main(String[] args) {
		oneToTen(1);
	}
	
	public static void oneToTen(int i) {
		if (i == 11) {	
			return; // 없으면 무한루프	
		}
		System.out.println(i);
		oneToTen(i + 1); // 재귀함수 -> 탈출조건 필요
		
	}

}
