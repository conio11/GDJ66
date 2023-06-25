package java0621;

public class PersonMain {
	public static void main(String[] args) {
		Tutor t = new Tutor();
		t.age = 20;
		t.name = "구디";
		t.playRole();
		
		Student s = new Student();
		s.age = 17;
		s.name = "구원이";
		s.playRole();
	}
}