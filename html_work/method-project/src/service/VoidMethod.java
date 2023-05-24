package service;

import vo.*;
import java.util.*;

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
	
	// 5) 매개변수: 배열(String 배열)
	// a. 어떤 값을 입력받을 것인가? (사람 이름 배열 입력)
	// b. 어떻게 처리(구현)할 것인가? "김"씨 성의 인원 출력 + 유효성 검사(null, 0 등에 대한 처리)
	// c. 어떤 값을 반환할 것인가? void(반환값 X)
	// d. 출력값: 전체 n명 중 김씨는 x명입니다.
	public void stringArrParam(String[] names) {
		if (names == null || names.length == 0) {
			System.out.println("이름이 입력되지 않았습니다.");
		} else {
			int cnt = names.length;
			int kimCnt = 0;
			for (int i = 0; i < names.length; i += 1) {
				if (names[i].startsWith("김")) {
					kimCnt++;
				}
			}
			System.out.println("전체 " + cnt + "명 중 김씨는 " + kimCnt + "명입니다.");
		}
	}
	
		/*
		if (names == null || names.length == 0) {
			System.out.println("이름 배열을 입력하세요");
			return;
		}
		
		int nameCnt = 0;
		for (String n : names) {
			if (n.startsWith("김")) {
				nameCnt += 1;
			}
		}
		// \n: 줄바꿈
		System.out.printf("전체 %d명 중 김씨는 %d명입니다.\n", names.length, nameCnt);
		*/
	
	// 6) 매개변수: 클래스
	// a. 어떤 값을 입력받을 것인가? - 한 학생의 정보 (Vo)
	// b. 어떻게 처리(구현)할 것인가? 학생 정보 출력 + 유효성 검사(null, 0 등에 대한 처리)
	// c. 어떤 값을 반환할 것인가? void(반환값 X)
	// d. 출력값: 10번, 김XX, 남자, 20살
	public void clsParam(Student student) { 
		if (student == null || student.getName() == null || student.getGender() == null || student.getBirth() < 1900) { // 유효성 검사
			return;
		}
		
		Calendar c = Calendar.getInstance();
		int age = c.get(Calendar.YEAR) - student.getBirth();
		System.out.printf("%d번, %sXX, %s, %d살\n", student.getId(), student.getName().substring(0, 1), student.getGender(), age);

	}
	
	// 7) 매개변수: 클래스 배열
	// a. 어떤 값을 입력받을 것인가? - 여러 학생의 정보 (Vo)
	// b. 어떻게 처리(구현)할 것인가? 학생 정보 출력 + 유효성 검사(null, 0 등에 대한 처리)
	// c. 어떤 값을 반환할 것인가? void(반환값 X)
	// d. 출력값: 남자 x명, 여자 y명
	public void clsArrParam(Student[] students) {
		// 유효성 검사
		if (students == null) { 
			return;
		}
		
		int maleCnt = 0; // 남자 인원
		int femaleCnt = 0; // 여자 인원
		for (int i = 0; i < students.length; i += 1) {
			if (students[i].getGender() == null) {
				return;
			}
			if (students[i].getGender().startsWith("남")) {
				maleCnt++;
			} else {
				femaleCnt++;
			}
					
		}
		System.out.printf("남자 %d명, 여자 %d명\n", maleCnt, femaleCnt);
	}
	
	/*
	if (students == null) {
		return;
	}
	
	int mCnt = 0; // 남자 인원
	int fCnt = 0; // 여자 인원
	
	for (Student s : students) {
		if (s == null || s.getGender() == null) {
			return;
		}
		if (s.getGender().equals("남")) {
			mCnt++;
		} else if (s.getGender().equals("여")) {
			fCnt++;
		}
	}
	
	System.out.println("남자는 " + mCnt + "명, 여자는 " + fCnt + " 명");
	}
	*/
	
	// 8) 매개변수: ArrayList
	// a. 어떤 값을 입력받을 것인가? - 여러 학생의 정보 (ArrayList<Student>)
	// b. 어떻게 처리(구현)할 것인가? 학생 정보 출력 + 유효성 검사(null, 0 등에 대한 처리)
	// c. 어떤 값을 반환할 것인가? void(반환값 X)
	// d. 출력값: 전체 x명, 20대 x명, 30대 x명
	public void clsArrayListParam(ArrayList<Student> studentList) {
		if (studentList == null || studentList.size() == 0) {
			System.out.println("입력값이 없습니다.");
			return;
		}
		
		int cnt = 0;
		int cnt20 = 0;
		int cnt30 = 0;
		cnt = studentList.size();
		Calendar c = Calendar.getInstance();
		for (int i = 0; i < studentList.size(); i += 1) {
			if (studentList.get(i).getBirth() <= 19) {
				System.out.println("나이가 제대로 입력되지 않았습니다.");
				return;
			}
			int age = c.get(Calendar.YEAR) - studentList.get(i).getBirth();
			if (age >= 30) {
				cnt30++;
			} else if (age >= 20) {
				cnt20++;
			}
		}
	
		System.out.printf("전체 %d명, 20대 %d명, 30대 %d명\n", cnt, cnt20, cnt30);
	}
	
	public void listParam(ArrayList<Student> list) {
		if (list == null) {
			return; 
		}
		
		int ages20 = 0;
		int ages30 = 0;
		int currentYear = Calendar.getInstance().get(Calendar.YEAR);
		
		for (Student s : list) {
			int age = currentYear - s.getBirth();
			int ages = age / 10 * 10;
			if (ages == 20) {
				ages20++;
			} else if (ages == 30) {
				ages30++;
			}
		}
		System.out.printf("전체 %d명, 20대 %d명, 30대 %d명\n", list.size(), ages20, ages30);
	}
	
	// 9) 매개변수: HashMap
	// a. 어떤 값을 입력받을 것인가? - Student 1명 + Emp 1명 --> HashMap 하나를 입력
	// b. 어떻게 처리(구현)할 것인가? 학생 정보 출력 + 유효성 검사(null, 0 등에 대한 처리)
	// c. 어떤 값을 반환할 것인가? void(반환값 X)
	// d. 출력값: 학생 이름은 XXX이고, 담당 직원의 이름은 XXX입니다.
	public void mapParam(HashMap<String, Object> map) {
		if (map == null || map.size() == 0) {
			System.out.println("입력값이 없습니다.");
			return;
		}
		Emp emp = (Emp)(map.get("e1"));
		Student student = (Student)(map.get("s1"));
		
		System.out.printf("학생 이름은 %s이고, 담당 직원의 이름은 %s입니다.\n", student.getName(), emp.getEmpName());
	}
}