package java0626;

public class Ex2 {
	public static void main(String[] args) {
		// 기본타입 형변환
		// int, long, float, double, char, boolean
		
		// 범위가 큰 것 -> 작은 것
		double a = 10.7;
		// float b = a; // float: 7자리 이후로 버림
		float b = (float) a; // 값의 손실이 발생할 수 있기 때문에 형변환 연산자 필요
		
		float c = 3.14F; // float 데이터 크기는 4byte로, long(8byte)보다 작지만 표현 범위가 더 큼 
		long d = (long) c; // 형변환 연산자 필요
		
		long e = 7L;
		int f = (int) e; // 형변환 연산자 필요
		
		int g = 66;
		char h = (char) g; // char도 2byte 숫자형, 표현 시만 맵핑된 글자를 표현
		
		// boolean i = (boolean) g; // 자바 언어는 boolean 타입은 형변환 불가
		
		// 범위 작은 것 -> 큰 것
		float j = 4.5F;
		double k = j; // 형변환 연산자 생략 가능 (암시적 형변환: 값의 손실이 발생하지 않음)
		
		int l = 7;
		double m = l; // 형변환 연산자 생략 가능
		
		char n = 'A'; // 숫자 65 맵핑
		int o = n;
	}
}