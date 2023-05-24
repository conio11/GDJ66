// import service.VoidMethod;
// import vo.Student;
import java.util.*;
import service.*;
import vo.*;

public class VoidMain {
	public static void main(String[] args) {
		VoidMethod vm = new VoidMethod();
		vm.voidParam();
		
		int num = 8;
		vm.intParam(num);
		
		String name = "철수";
		vm.stringParam(name);
		
		int a = 10;
		int b = 10;
		vm.int2Param(a, b);
		
		int[] arr = {5, 1, 10, 7, 999, 21};
		vm.intArrayParam(arr);
		
		// 기본타입(값) 매개변수 vs 참조타입(주소) 매개변수
		int value = 100;
		vm.valueTypeParam(value);
		System.out.println(value); // 100
		
		int[] refer = {1, 2, 3};
		System.out.println(refer[0]); // 1
		System.out.println(refer);
		
		vm.referTypeParam(refer);
		System.out.println(refer[0]); // 777
		System.out.println(refer); // 주소값은 변하지 않음
		
		String[] names = {"김철수", "이철수", "김철수", "박철수"};
		vm.stringArrParam(names);
		
		Student st = new Student();
		st.setId(10);
		st.setName("김철수");
		st.setBirth(2000);
		st.setGender("남자");
		vm.clsParam(st);
		
		
		Student[] st2 = new Student[4];
		st2[0] = new Student();
		st2[0].setGender("남자");
		st2[0].setBirth(1999);
		st2[1] = new Student();
		st2[1].setGender("남자");
		st2[1].setBirth(1999);
		st2[2] = new Student();
		st2[2].setGender("여자");
		st2[2].setBirth(1999);
		st2[3] = new Student();
		st2[3].setGender("여자");
		st2[3].setBirth(1999);
		vm.clsArrParam(st2);
		
		ArrayList<Student> st3 = new ArrayList<Student>();
		
		
		Student s = new Student();
		s.setName("김철수");
		
		Emp e = new Emp();
		e.setEmpName("김철수2");
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("e1", e);
		map.put("s1", s);
		vm.mapParam(map);
		
		Student ch = new Student();
		ch.setId(3);
		ch.setName("최동욱");
		ch.setGender("남");
		ch.setBirth(1999);
		vm.clsParam(ch);

		Student s1 = new Student();
		s1.setId(3);
		s1.setName("최동욱");
		s1.setGender("남");
		s1.setBirth(1999);
		Student s2 = new Student();
		s2.setId(4);
		s2.setName("최명진");
		s2.setGender("남");
		s2.setBirth(1995);
		Student s3 = new Student();
		s3.setId(4);
		s3.setName("최미진");
		s3.setGender("여");
		s3.setBirth(2000);
		Student[] students = new Student[3];
		students[0] = s1;
		students[1] = s2;
		students[2] = s3;
		vm.clsArrParam(students);
		//
		ArrayList<Student> list = new ArrayList<>();
		list.add(s1);
		list.add(s2);
		list.add(s3);
		vm.listParam(list);
		
		vm.clsArrayListParam(list);
		
		Emp emp = new Emp();
		emp.setEmpName("루피");
		Student hkd = new Student();
		hkd.setName("홍길동");
		HashMap<String, Object> map1 = new HashMap<>();
		map1.put("e1", emp);
		map1.put("s1",hkd);
		vm.mapParam(map1);		
		
		// HashMap<Student, Emp> map = new HashMap<Student, Emp>();
		// s.setName(String name)
		// e.setEmpName(String empName)
	 	// map.put(s, e);
		
		//vm.mapParam(null);
		
		// map.put(Student.);
		
		// System.out.println(map.get("김철수"));
		
		
		System.out.println("================================");
	}
}