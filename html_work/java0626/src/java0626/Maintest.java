package java0626;

public class Maintest {
	public static void main(String[] args) throws InterruptedException {
		MyThread mt = new MyThread();
		mt.start(); // .start(): 스레드 실행 메소드
		
		ThreadTest tt = new ThreadTest();
		tt.printO();		
		//tt.printX();
	}
}