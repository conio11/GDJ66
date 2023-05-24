import java.util.*;
import service.*;
import vo.*;

public class PrimitiveMain {
	public static void main(String[] args) {
		PrimitiveMethod pm = new PrimitiveMethod();
		int maxIntValue = pm.voidParam();
		System.out.println(maxIntValue);
		System.out.println("===(1)===");
		
		System.out.println(pm.stringParam("kevin", "degea"));
		System.out.println("===(3)===");
		
		int[] arr = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
		System.out.println(pm.arrayParam(arr));
		System.out.println("===(4)===");
		
		String[] names = {"루피", "나미", "샹크스"};
		System.out.println(pm.strArrParam(names));
		System.out.println("===(5)===");
		
		
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
		
		StringMethod sm = new StringMethod();
		
		String filename = "극장.영수증.pdf"; // 보고서.hwp // 극장.영수증.pdf
		System.out.println(sm.stringParam(filename));
		System.out.println("===stringParam===");
		
		
		
		
	}
}