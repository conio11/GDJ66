package vo;

public class Subject {
	private String name; // 국어, 영어, 수학, 과학
	private int score; // 0 ~ 100
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
}
