import service.VoidMethod;

public class VoidMain {
	public static void main(String[] args) {
		VoidMethod vm = new VoidMethod();
		vm.voidParam();
		
		int num = 8;
		vm.intParam(num);
		
		String name = "철수";
		vm.stringParam(name);
		
		int a = 10;
		int b = 10;
		vm.int2Param(a, b);
		
		int[] arr = {5, 1, 10, 7, 999, 21};
		vm.intArrayParam(arr);
		
		// 기본타입(값) 매개변수 vs 참조타입(주소) 매개변수
		int value = 100;
		vm.valueTypeParam(value);
		System.out.println(value); // 100
		
		int[] refer = {1, 2, 3};
		System.out.println(refer[0]); // 1
		System.out.println(refer);
		
		vm.referTypeParam(refer);
		System.out.println(refer[0]); // 777
		System.out.println(refer); // 주소값은 변하지 않음
		
		System.out.println("================================");
	}
}