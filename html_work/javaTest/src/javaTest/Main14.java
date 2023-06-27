package javaTest; // 14번 문제 // 1

class parent{
	public int compute(int num){
    	if(num <=1) return num; // compute(4)
        return compute(num-1) + compute(num-2);
    }
 }
 
 class Child extends parent {
 	public int compute(int num){ // com(4) = com(3) + com(1) = 1
    	if(num<=1) return num;
        	return compute(num-1) + compute(num-3);
        }
   }
   
  class Main14 {
  	public static void main (String[] args){
    parent obj = new Child();
    System.out.print(obj.compute(4)); // 1
   }
 }
  
  // com(1) = 1
  // com(3) = com(2) + com(0) = 0
  // com(0) = 0;
  // com(2) = com(1) + com(-1) = 1 + (-1) = 0