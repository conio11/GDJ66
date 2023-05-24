package service;

public class StringMethod {
	// 1) 매개변수: 없음
	// 2) 매개변수: 기본타입
	
	// 3) 매개변수: String
	// a. 어떤 값을 입력받을 것인가? 파일 이름 (확장자 포함)
	// b. 어떻게 처리(구현)할 것인가? 확장자 추출
	// c. 어떤 값을 반환할 것인가? 확장자만 반환
	public String stringParam(String filename) {
		/*
		school.jpg -> jpg
		보고서.hwp -> hwp
		극장.영수증.pdf -> pdf
		test -> 공백 ("")
		 */
		if (filename == null || filename.length() == 0) {
			// System.out.println("입력값이 없습니다.");
			return "입력값 없음";
		}
		
		char target = '.';
		int lastIndex = filename.lastIndexOf(target); // 마지막으로 나오는(뒤에서 처음으로 나오는) (.)의 인덱스
		if (lastIndex != -1) { // 해당 값을 찾지 못한 경우(-1)가 아니면 확장자 반환
			// char lastChar = filename.charAt(lastIndex);
			// System.out.println(lastIndex + " <-- (.)lastIndex");
			// System.out.println(filename.substring(lastIndex));
			return filename.substring(lastIndex + 1); // 확장자명 (. 제외)
			
		} else {
			// return "확장자를 찾을 수 없습니다.";
			return "";
		}		
	}
}