package vo;

import java.util.Calendar;

public class Person {
	private int birth; // 필드 은닉

	/*
	private int getBirth() { // getter 은닉 -> 쓰기 전용
		return birth;
	}
	*/
	public void setBirth(int birth) {
		if (birth > 0) {
			this.birth = birth;
		}
		
	}
	
	public int getAge() {
		if (this.birth > 0) {
			Calendar c = Calendar.getInstance(); // c: 오늘 날짜 정보
			int y = c.get(Calendar.YEAR);
			return y - this.birth;
		}
		return 0; // 조건 만족하지 않을 경우 0 처리
	}
}
