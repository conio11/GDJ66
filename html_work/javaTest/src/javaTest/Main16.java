package javaTest; // 16번 문제 // 30

public class Main16 {
	public static void main(String[] args){
    int i=0;
    int sum=0;
    while (i<10){
    	i++; // i = 0 1 2 3 4 5 6 7 8 9
        if(i%2 ==1) // i가 2의 배수가 아니면 (홀수이면)
        	continue; // 다시 위로 올라감 -> 2의 배수일 때만 계산
        sum += i; // i = 1 2 3 4 5 6 7 8 9 10 -> 2 + 4 + 6 + 8 + 10
     }
     System.out.println(sum); // 30
   }
}

