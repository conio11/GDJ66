package service;

import vo.*;
import java.util.*;

public class ClassMethod {
	// 1) Member 타입의 일부 속성(ID, PW)을 입력받아 
	// m66메소드 내에 정의된 정적 멤버 자료구조(배열 or List)에 동일한 데이터가 있으면 해당 데이터의 풀 속성 반환, 없으면 null 반환  
	public Member m66(Member member) { // 반환값이 Member 클래스 타입인 m66 메소드, Member 타입의 매개변수 m을 받음
		if (member == null || member.getMemberPW() == null) {
			System.out.println("멤버 정보가 없습니다.");
			return null;
		}
	       
		ArrayList<Member> mList = new ArrayList<>();
	       
		Member m1 = new Member();
		m1.setMemberID(100);
		m1.setMemberPW("1234");
		mList.add(m1);
	   
		Member m2 = new Member();
		m2.setMemberID(200);
		m2.setMemberPW("1234");
		mList.add(m2);
	   
		Member m3 = new Member();
		m3.setMemberID(300);
		m3.setMemberPW("1234");
		mList.add(m3);
	   
		for (Member m : mList) { // 메소드 내부의 3개 키, 값 쌍과 매개변수로 받아온 키, 값 쌍을 비교
			if (m.getMemberID() == member.getMemberID()
			&& m.getMemberPW().equals(member.getMemberPW())) {
	        return m; // m.getMemberID()와 같이 작성 시 에러 -> 반환값 타입이 일치하지 않음
	     }
	  }
	  return null;
    }
	
	// 2)
	// String 리스트를 입력받아 String 배열로 반환하는 String[](문자열 배열) 타입의 m78 메소드 
	public String[] m78(ArrayList<String> list) {
		if (list == null || list.size() ==0) {
			System.out.println("입력값이 없습니다.");
			return null;
		}
		
		int listSize = list.size(); // 입력받은 String 리스트의 크기
		String[] array = new String[listSize]; // 배열은 선언 시 크기 지정해야 함
		int arrIndex = 0; // array의 인덱스
		
		for (String s : list) { // list값 반복
			array[arrIndex] = s;
			arrIndex++;
		}
		return array; // array[arrIndex]와 같이 작성 시 에러 -> 반환값 타입이 일치하지 않음
	}
	
	// 3)
	// 숫자배열을 입력받아 짝수만 문자열로 변경 후 ArrayList<String> 타입으로 반환하는 m84 메소드
	public ArrayList<String> m84(int[] arr) {
		if (arr == null || arr.length == 0) {
			System.out.println("입력값이 없습니다.");
			return null;
		}
		ArrayList<String> list = new ArrayList<>();
		for (int a : arr) {
			if (a % 2 == 0) { // arr 내 값이 짝수이면
				String newA = "" + a; // String값으로 변환 -> int형 변수 앞에 공백 추가하는 방식
				list.add(newA);
			}
		}
		return list;
	}
	
	// 4)
	// 여러타입의 데이터를 입력받아 Emp, Dept타입으로 분산 저장 후 다시 Emp와 Dept를 HashMap<String, Object>에 저장후 반환
	public HashMap<String, Object> m96(int empNo, String ename, boolean retirer, int deptNo, String dname) {
		if (ename == null || dname == null) {
			System.out.println("입력되지 않은 문자열 값이 있습니다.");
			return null;
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		Emp2 e = new Emp2();
		e.setEmpNo(empNo);
		e.setEname(ename);
		e.setRetirer(retirer);
		
		Dept d = new Dept();
		d.setDeptNo(deptNo);
		d.setDname(dname);
		
		map.put("empNo", e.getEmpNo());
		map.put("ename", e.getEname());
		map.put("retirer", e.isRetirer());
		map.put("deptNo", d.getDeptNo());
		map.put("dname", d.getDname());
	
		return map;
	}
	
	/*
	// 다른 방법
	 
	package service;

	import java.util.HashMap;

	import vo.Dept;
	import vo.Emp2;

	public class MapReturnMethod {
		public HashMap<String, Object> m910(
				int empNo, String ename, boolean retirer, int deptNo, String dname) {
			
			Emp2 emp = new Emp2();
			emp.setEmpNo(empNo);
			emp.setEname(ename);
			emp.setRetirer(retirer);
			
			Dept dept = new Dept();
			dept.setDeptNo(deptNo);
			dept.setDname(dname);
			
			HashMap<String, Object> map = new HashMap<>();
			map.put("emp", emp);
			map.put("dept", dept);
			
			return map;
		}
	 */
}