package java0626;

public class MyThread extends Thread { // Thread 클래스를 상속받아 스레드로 동작할 수 있는 클래스
	@Override
	public void run() {
		for (int i = 1; i < 1000; i++) {
			System.out.println("X");
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}