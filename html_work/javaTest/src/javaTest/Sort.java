package javaTest; // (빈칸) // idx2, item.length

public class Sort {
	 
    public static void swap(int[] arr, int idx1, int idx2){
        int temp = arr[idx1];
        arr[idx1] = arr[idx2];
        arr[idx2] = temp; // 빈칸 // idx2
    }
 
    public static void Usort(int[] array, int length) { // 버블 정렬: 인접한 두 요소를 비교하고 필요에 따라 위치를 교환하여 배열을 정렬
        for (int i = 0; i < length; i++) {
            for (int j = 0; j < length - i - 1; j++) {
                if (array[j] > array[j + 1]) {
                    swap(array, j, j + 1);
                }
            }
        }
    }
 
    public static void main(String[] args) {
        int[] item = new int[] { 5, 3, 8, 1, 2, 7 };
        int nx = 5;   
        Usort(item, item.length); // 빈칸 // item.length
 
        for (int data : item) {
            System.out.print(data + " ");
        }
    } 
}