package service;

import java.util.*;
import java.util.Calendar;
import vo.*;

public class PrimitiveMethod {
	// 1) 매개변수: 없음
	// a. 어떤 값을 입력받을 것인가? void
	// b. 어떻게 처리(구현)할 것인가? 0 ~ int 최대값 중 하나 리턴
	// c. 어떤 값을 반환할 것인가? 기본 타입(int)
	public int voidParam() {
		// 최소값: 0, 최대값: int 타입의 최대값 -> Integer 랩퍼타입
		int min = 0;
		double rNum = Math.random(); // 0.000000 ~ 0.9999999
		long intMax = (long)Integer.MAX_VALUE + (long)1;           
		int returnValue = (int) Math.floor(intMax * rNum);
		return returnValue;
	}
	
	// 2) 매개변수: 기본타입
	// a. 어떤 값을 입력받을 것인가? 태어난 연도
	// b. 어떻게 처리(구현)할 것인가? 성인이면 true / 아니면 false
	// c. 어떤 값을 반환할 것인가? 기본 타입(boolean) 
	public boolean primitiveParam(int birth) {
		int currentYear = Calendar.getInstance().get(Calendar.YEAR);
		if (birth < 0 || birth > currentYear) {
			System.out.println("잘못된 입력입니다.");
			return false;
		}
		if (currentYear - birth > 18) {
			return true;
		}
		return false;
	}	
	
	// 2-1) 매개변수: 기본타입
	// a. 어떤 값을 입력받을 것인가? int, int (int값 2개)
	// b. 어떻게 처리(구현)할 것인가? 두 입력값 중 더 큰 값을 반환
	// c. 어떤 값을 반환할 것인가? 기본 타입(int) 
	public int primitive2Param(int num1, int num2) { 
		if (num1 > num2) {
			return num1;
		}
		return num2; 
	}
	
	// 3) 매개변수: String
	// a. 어떤 값을 입력받을 것인가? 문자열 2개
	// b. 어떻게 처리(구현)할 것인가? firstName과 lastName의 길이 반환
	// c. 어떤 값을 반환할 것인가? 
	public int stringParam(String firstName, String lastName) { 
		// 문자열 길이 반환 기본 API 사용
		// 유효성 검사 추가
		if (firstName == null || lastName == null) {
			System.out.println("이름을 모두 입력해주세요.");
			return 0;
		}
		
		int lengthFName = firstName.length();
		int lengthLName = lastName.length();
		
		return lengthFName + lengthLName;
	}
	
	// 4) 매개변수: int 
	// a. 어떤 값을 입력받을 것인가? int[]
	// b. 어떻게 처리(구현)할 것인가? 배열의 합
	// c. 어떤 값을 반환할 것인가? long
	
	public long arrayParam(int[] arr) {
		if (arr == null) {
			System.out.println("입력값이 없습니다.");
			return 0;
		}
		
		long sum= 0;
		for (int i = 0; i < arr.length; i += 1) {
			sum += arr[i];
		}
		return sum;
	}
	
		/*
		int sum = 0;
		for (int n : arr) {
			sum += n;
		}
		return sum;
		 */
	
	// 5) 매개변수: 배열 (String 배열)  
	// a. 어떤 값을 입력받을 것인가? 이름 배열
	// b. 어떻게 처리(구현)할 것인가? 입력된 이름 중 한 명이라도 블랙리스트 명단에 있으면 true 
	// c. 어떤 값을 반환할 것인가? boolean
	public boolean strArrParam(String[] names) {
		// 블랙리스트
		final String[] blackList = {"루피", "상디", "조로"};
		if (names == null) {
			System.out.println("입력값이 없습니다.");
			return false;
		}
		for (int i = 0; i < names.length; i += 1) {	
			for (int j = 0; j < blackList.length; j += 1) {
				if (names[i] == blackList[j]) {
					System.out.println("블랙리스트에 해당하는 이름이 있습니다.");
					return true;
				}
			}
		}
		return false;
	}
	
	/*
	for (String b : blackList) {
		for (String n : names) {
			if (b.equals(n)) {
				return true;
			}
		}
	}
	return false;
	 */
	
	// 6) 매개변수: 클래스
	// a. 어떤 값을 입력받을 것인가? 학생타입의 번호, 이름 속성만 입력
	// b. 어떻게 처리(구현)할 것인가? 로그인 
	// c. 어떤 값을 반환할 것인가? boolean
	public boolean clsParam(Student student) {
		// 유효성 검사 추가
		// 학생 DB 목록
		Student[] db = new Student[3];
		db[0] = new Student();
		db[0].setId(100);
		db[0].setPw("1234");
		db[1] = new Student();
		db[1].setId(200);
		db[1].setPw("1234");
		db[2] = new Student();
		db[2].setId(300);
		db[2].setPw("1234");
		
		for (Student s : db) {
			if (s.getId() == student.getId() && s.getPw() == student.getPw()) {
				return true;
			}
		}
		return false;
	}
	
	// 7) 매개변수: 배열 (클래스 배열)
	// a. 어떤 값을 입력받을 것인가? 학생 배열 Student[]
	// b. 어떻게 처리(구현)할 것인가? 성별이 여자인 학생의 평균 나이 (소수점 2번째 자리까지 -> 1번째 자리까지만 출력됨)
	// c. 어떤 값을 반환할 것인가? double
	public double clsArrParam(Student[] s) {
		if (s == null) {
			System.out.println("입력값이 없습니다.");
			return 0;
		}
		
		int sumAge = 0;
		int fCnt = 0;
		double avgAge = 0;
		for (int i = 0; i < s.length; i += 1) {
			if (s[i].getGender() == "여") {
				fCnt += 1;
				sumAge += (Calendar.getInstance().get(Calendar.YEAR) - s[i].getBirth());
			}
		}
		avgAge = (double)sumAge / (double)fCnt;
		
		return Math.round(avgAge * 100) / 100;
	}
		
		
		/*
		// 다른 방법
		  if (s == null || s.length == 0) {
	         System.out.println("값을입력하세요");
	         return 0;
	      }
	      int currentYear = Calendar.getInstance().get(Calendar.YEAR);
	      int sum = 0;
	      int cnt = 0;
	      for (Student s1 : s) {
	         if("여자".equals(s1.getGender())) {
	            int age = currentYear - s1.getBirth() + 1;
	            sum += age;
	            cnt++;
	         }
	      }
	      double avg = Math.round(((double)sum / cnt * 100)) / 100.0;
	      return avg;
	   }
		 */
		
	// 8) 매개변수: ArrayList
	// a. 어떤 값을 입력받을 것인가? 성적 데이터 (국어, 영어, 수학, 과학 4과목)
	// 	ex) null이면 0 + 0 + 0 + 0 / 국어 80 나머지 점수 없음: 80 + 0 + 0 + 0
	// b. 어떻게 처리(구현)할 것인가? 4과목 (4과목이 안되면 점수 없는 과목은 0점으로 입력) 평균 90이상 A, 80이상 B, 70이상 C, 나머지 D
	// c. 어떤 값을 반환할 것인가? char 'A', 'B', 'C', 'D'
	public char listParam(ArrayList<Subject> list) {
		if (list == null || list.size() == 0) {
			return '\0';
		}
		int sumScore = 0;
		if (list != null) {
			for (Subject s : list) {
				sumScore += s.getScore();
			}
		}
		
		double avg = (double) sumScore / 4.0;
		char returnValue = '\0';
		if (avg >= 90) {
			returnValue = 'A';
		} else if (avg >= 80) {
			returnValue = 'B';
		} else if (avg >= 70) {
			returnValue = 'C';
		} else if (avg >= 60) {
			returnValue = 'D';
		} else {
			returnValue = 'F';
		} 
		return returnValue;
		
		
		
		/*
		for (int i = 0; i < list.size(); i += 1) {
			if (list.get(i) == null) {
			}s
		}
		*/
		
	}
	
	// 9) 매개변수: HashMap
	// a. 어떤 값을 입력받을 것인가? 두 개의 리스트 (Student, Emp)
	// b. 어떻게 처리(구현)할 것인가? 총 인원 (리스트 사이즈의 합)
	// c. 어떤 값을 반환할 것인가? int
	public int mapParam(HashMap<String, Object> map) {
		int studentCnt = 0;
		int empCnt = 0;
		
		// @SuppressWarnings("unchecked")
		ArrayList<Student> studentList = (ArrayList<Student>)map.get("studentList");
		// @SuppressWarnings("unchecked")
		ArrayList<Emp> empList = (ArrayList<Emp>)map.get("empList");
		
		// null 유효성 검사
		if (studentList == null || empList == null) {
			System.out.println("입력값이 없습니다.");
			return 0;
		}
		studentCnt = studentList.size();
		empCnt = empList.size();
		return studentCnt + empCnt;
	}
}