package javaTest; // 15번 문제 // // Car name : Spark

abstract class Vehicle{
	private String name;
    abstract public String getName(String val);
    public String getName(){
    	return "vehicle name:" + name;
    }
	public void setName(String val){
    	name = val;
    }
}

class Car1 extends Vehicle {
	public Car1(String val){
    	setName(val);
   }
public String getName(String val){
	return "Car name : " + val;
   }
public String getName(byte val[]){
	return "Car name : " + val;
   }
}

public class Main15 { 
	public static void main(String[] args){
    Vehicle obj = new Car1("Spark"); // 부모로 자식 생성 -> super() 생성자
    System.out.print(obj.getName()); // 부모의 생성자 중 매개변수 없는 것 -> vehicle name : Spark
    }
}
