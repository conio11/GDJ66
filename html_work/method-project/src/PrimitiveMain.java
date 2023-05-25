import java.util.*;
import service.*;
import vo.*;

public class PrimitiveMain {
	public static void main(String[] args) {
		PrimitiveMethod pm = new PrimitiveMethod();
		int maxIntValue = pm.voidParam();
		System.out.println(maxIntValue);
		System.out.println("===(1)===");
		
		System.out.println(pm.primitiveParam(2000));
		System.out.println("===(2)===");
		
		System.out.println(pm.stringParam("kevin", "degea"));
		System.out.println("===(3)===");
		
		int[] arr = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
		System.out.println(pm.arrayParam(arr));
		System.out.println("===(4)===");
		
		String[] names = {"루피", "나미", "샹크스"};
		System.out.println(pm.strArrParam(names));
		System.out.println("===(5)===");
		
		Student student = new Student();
		student.setId(100); // 학생 ID 설정
		student.setPw("1234"); // 학생 비밀번호 설정
		System.out.println(pm.clsParam(student));
		System.out.println("===(6)===");
		
		Student s1 = new Student();
		s1.setBirth(2000);
		s1.setGender("남");
		
		Student s2 = new Student();
		s2.setBirth(1998);
		s2.setGender("여");
		
		Student s3 = new Student();
		s3.setBirth(2000);
		s3.setGender("여");
		
		Student s4 = new Student();
		s4.setBirth(1996);
		s4.setGender("여");
		
		Student[] sNew = {s1, s2, s3, s4};
		System.out.println(pm.clsArrParam(sNew));
		System.out.println("===(7)===");
		
		ArrayList<Subject> sub = new ArrayList<>();
		Subject sub1 = new Subject();
		sub1.setName("국어");
		sub1.setScore(100);
		
		Subject sub2 = new Subject();
		sub2.setName("영어");
		sub2.setScore(90);
		
		Subject sub3 = new Subject();
		sub3.setName("수학");
		sub3.setScore(80);
		
		Subject sub4 = new Subject();
		sub4.setName("과학");
		sub4.setScore(70);
		
		sub.add(sub1);
		sub.add(sub2);
		sub.add(sub3);
		sub.add(sub4);
		
		System.out.println(pm.listParam(sub));
		System.out.println("===(8)===");
		
		// 예시 map 객체 생성
		HashMap<String, Object> map = new HashMap<>();

		// 예시 Student 리스트 생성
		ArrayList<Student> studentList = new ArrayList<>();
		
		// 학생 객체 생성 및 리스트에 추가
		Student student1 = new Student();
		student1.setId(100);
		studentList.add(student1);
		Student student2 = new Student();
		student2.setId(200);
		studentList.add(student2);

		// 예시 Emp 리스트 생성
		ArrayList<Emp> empList = new ArrayList<>();
		
		// 직원 객체 생성 및 리스트에 추가
		Emp emp1 = new Emp();
		emp1.setEmpID(1);
		empList.add(emp1);
		Emp emp2 = new Emp();
		emp2.setEmpID(2);
		empList.add(emp2);

		// 맵에 리스트들을 저장
		map.put("studentList", studentList);
		map.put("empList", empList);

		// 메소드 호출
		int result = pm.mapParam(map);
		System.out.println(result); // 결과 출력
		System.out.println("===(9)===");
		
		StringMethod sm = new StringMethod();
		String filename = "극장.영수증.pdf"; // 보고서.hwp // 극장.영수증.pdf
		System.out.println(sm.stringParam(filename));
		System.out.println("===stringParam===");	
	
		ClassMethod cm = new ClassMethod();
		Member mem = new Member();
		mem.setMemberID(100);
		mem.setMemberPW("1234");
		mem.setMemberName("ABC");
		mem.setMemberBirth(2000);
		System.out.println(cm.m66(mem)); // null이 아닐 경우 클래스 객체 참조값 반환
		System.out.println("===(CM1)===");
		
		ArrayList<String> list = new ArrayList<>();
		list.add("리스트1");
		list.add("리스트2");
		list.add("리스트3");
		System.out.println(cm.m78(list)); // null이 아닐 경우 배열 참조값 반환
		System.out.println("===(CM2)===");
	
		int[] numArr = {1, 2, 3, 4, 5, 6};
		System.out.println(cm.m84(numArr));
		System.out.println("===(CM3)===");
		
		System.out.println(cm.m96(1, "구디", false, 200, "운영"));
		
		System.out.println("===(CM4)===");
		
		
		// 테스트 코드
		// 1) 테스트용 클래스 생성 뒤 테스트 클래스 내부 static main() 에서 테스트 실행
		// 2) 테스트하려는 메소드의 클래스 안에 static main() 생성, 호출
		/*
		MapReturnMethod mrm = new MapReturnMethod();
		HashMap<String, Object> map 
			= mrm.m910(1, "구디", false, 100, "운영");
		
		Emp2 emp = (Emp2)(map.get("emp"));
		Dept dept = (Dept)(map.get("dept"));
		
		System.out.printf("%s님의 부서는 %s 입니다%n"
				, emp.getEname(),dept.getDname());
		*/

	}
}