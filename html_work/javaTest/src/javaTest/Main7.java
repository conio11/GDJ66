package javaTest; // 7번 문제 // Car

	class Car implements Runnable{
		  int a;
		  
		  public void run(){
		     System.out.println("message"); 
		  }
		}
		  
		public class Main7 {
		  public static void main(String args[]){
		    Thread t1 = new Thread(new Car()); // Car
		    t1.start();
		  }
		}


