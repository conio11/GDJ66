package java0626;

public class ThreadTest {
	public void printO() throws InterruptedException {
		for (int i = 1; i < 1000; i++) {
			System.out.println("O");
			// for (long j = 0; j < 100000000000000000L; j ++) {}
			Thread.sleep(1000);
		}
	}
	
	public void printX() {		
	}
}