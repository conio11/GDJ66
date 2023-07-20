package javaTest2;

public class Q05 { // 답: 1 2 ArrayIndexOutOfBoundsException 발생
	public static void main(String[] args) {
		int ar[][] = new int[3][];
		int value = 0;
		
		ar[0] = new int[2]; // [][]
		ar[1] = new int[3]; // [][][]
		ar[2] = new int[4]; // [][][][]
		
		for (int out = 0; out < ar.length; out++) { // 3회 반복 	
			for (int in = 0; in < ar[out].length; in++) { // ar[0], ar[1], ar[2] 길이만큼 반복
				ar[out][in] = ++value;
			}
		}
		
		try {
			for (int out = 0; out < ar.length; out++) {
				for (int in = 0; in < ar.length; in++) { // ar.length = 3 -> 3회 반복 => 1, 2 출력 후 범위를 벗어나 예외 발생
					System.out.println(ar[out][in]);
				}
			}
		} catch (ArrayIndexOutOfBoundsException e) {
			System.out.println("ArrayIndexOutOfBoundsException 발생");
		}
	}
}
