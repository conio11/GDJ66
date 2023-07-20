package javaTest2;

public class Q13 {
	public static void main(String[] args) {
		Thread t1 = new MyThread();
		Thread t2 = new Thread(new MyRunnable());
		t1.start();
		t2.start();
		
	}
}

class MyThread extends Thread {
	@Override
	public void run() {
		for (int i = 0; i < 30; i++) {
			System.out.println("*");
		} try {
			int r = (int)(Math.random() * 2000);
			Thread.sleep(r); // Thread.sleep(1000); // 1초 간 멈춤, 1일 때 0.001초 멈춤
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}

class MyRunnable implements Runnable {
	@Override
	public void run() {
		for (int i = 0; i < 30; i++) {
			System.out.println("*");
		} try {
			int r = (int)(Math.random() * 2000);
			Thread.sleep(r);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}
