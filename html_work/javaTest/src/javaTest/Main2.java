package javaTest; // 2번 문제 // 0123

public class Main2 {
	 static int[] MakeArray(){
		 
		  int[] tempArr = new int[4];
		  
		  for(int i=0; i<tempArr.length;i++){
		    tempArr[i] = i; // [0, 1, 2, 3]
		  }
		  
		  return tempArr;
		  }
		  
		  public static void main(String[] args){
		  
		  int[] intArr;
		  intArr = MakeArray(); // [0, 1, 2, 3]
		  
		  for(int i=0; i < intArr.length; i++)
		  System.out.print(intArr[i]); // 0123		 
		  }
}