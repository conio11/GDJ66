package javaTest2;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

public class Q07 { // 답: guest
	public static void main(String[] args) {
		Set<Singer> set = new HashSet<>();
		Singer singer;
		
		singer = new Singer();
		
		singer.setName("admin");
		singer.setAge(30);
		set.add(singer);
		
		// Singer singer2 = new Singer();
		singer.setName("guest"); // 중복 허용되지 않음
		singer.setAge(32);       // 새 값으로 덮어쓰기
		set.add(singer);
		
		Iterator<Singer> it = set.iterator();
		while (it.hasNext()) {
			System.out.println(it.next().getName()); // singer.getName() -> guest
		}
	}
}

class Singer {
	private String name;
	private int age;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
}
