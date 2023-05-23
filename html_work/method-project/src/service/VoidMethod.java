package service;

// 해당 클래스의 모든 리턴타입: void
public class VoidMethod {
	// 1) 매개변수 : 없음 
	public void voidParam() {
		System.out.println("안녕하세요. 구디아카데미입니다.");
	}
	
	// 매개변수: 기본타입 (byte, short, int, long, float, double, char, boolean)
	// 2) 매개변수: int
	public void intParam(int num) {  
		if (num % 2 == 0) {
			System.out.println("입력한 " + num + "은 짝수입니다.");
			return; // 실행 종료
		} 
		System.out.println("입력한 " + num + "은 홀수입니다.");
	}
	
	// 2-1) 두 개의 숫자를 입력받아 21을 넘기지 않으면서 21에 더 가까운 수를 출력하는 메소드
	// a, b 중 21을 넘기지 않으면서 21에 더 가까운 수를 출력
	// 21과 비교하여 차이가 더 작은 수를 출력
	// 22, 9 -> 9 출력
	// 21, 20 -> 21 출력
	// 23, 24 -> 없음
	
	public void int2Param(int a, int b) {
		if (a > 21 && b > 21) {
			System.out.println("없음");
			return;
		}
		
		if (21 - a < 21 - b) {
			if (a <= 21) {
				System.out.println(a);
			} else {
				System.out.println(b);
			}
		} else {
			if (b <= 21) {
				System.out.println(b);
			} else {
				System.out.println(a);
			}
		}
	}
	/*
	   // 다른 방법
	   public void int2Param(int a, int b) {
		      if(a > 21 && b > 21) {
		         System.out.println("없음");
		      } else if (a > 21) {
		         System.out.println(b);
		      } else if (b > 21) {
		         System.out.println(a);
		      } else if (a > b){
		         System.out.println(a);
		      } else {
		         System.out.println(b);
		      }
		   }
	   */
	
	// 3) 매개변수: String
	public void stringParam(String name) {
		if (name.startsWith("김") || name.startsWith("이") || name.startsWith("박") ) {
			System.out.println(name.substring(0, 1) + "씨 입니다.");
		} else {
			System.out.println("김/이/박이 아닙니다.");
		}
	}
	
	// 4) 매개변수(참조타입): int 배열
	// int 배열을 입력받아 요소 중 가장 큰 수 출력
	public void intArrayParam(int[] arr) {
		if (arr == null || arr.length == 0) { // 우항을 먼저 적을 시 null값 참조 오류 발생
			System.out.println("입력 error");
			return; // 1) 메소드 종료 2) 호출된 코드부분에 종료 후 반환값 남김 
		}
		
		int max = arr[0]; // ex) 5, 7, 1, 10
		for (int i = 0; i < arr.length; i += 1) {
			if (arr[i] > max) {
				max = arr[i];
			}
		}
		System.out.println("가장 큰 수는 " + max + " 입니다.");
	}
	
	// 기본타입(값) 매개변수 vs 참조타입(주소) 매개변수
	public void valueTypeParam(int value) {
		value = 777;
	}
	
	public void referTypeParam(int[] refer) {
		refer[0] = 777;
	}
}