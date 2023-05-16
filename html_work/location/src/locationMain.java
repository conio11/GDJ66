import java.util.*;
public class locationMain {
	public static void main(String[] args) {
		ArrayList<String> list = new ArrayList<>(26); //
		list.add("구은혜");
		list.add("권원중");
		list.add("김미선");
		list.add("김미진");
		list.add("김승준");
		list.add("김영훈");
		list.add("김예은");
		list.add("김희진");
		list.add("송예지");
		list.add("송현정");
		list.add("신정음");
		list.add("안소나");
		list.add("양희주");
		list.add("오다빈");
		list.add("이강산");
		list.add("이예은");
		list.add("이재성");
		list.add("이정환");
		list.add("임지예");
		list.add("장우정");
		list.add("정석현");
		list.add("정지형");
		list.add("조동욱");
		list.add("최준");
		list.add("하명진");
		list.add("홍진표");
		
		/*
		int num = 1;
		for (String name : list) {
			System.out.println(num + ")" + name);
			num = num + 1;
		}
		*/
		
		Collections.shuffle(list);
		
		int num = 1;
		for (String name : list) {
			System.out.println(num + ")" + name);
			num = num + 1;
		}
	}
}