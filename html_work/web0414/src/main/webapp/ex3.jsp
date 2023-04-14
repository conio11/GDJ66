<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	
	// 랩퍼(박싱) 타입 : 기본타입과 동일한 데이터가 저장 가능한 자바의 참조타입
	// 기본 라이브러리(API)에 포함된 클래스
	
	// 랩퍼(Wrapper) 타입 8개
	Byte a = new Byte((byte) 1);
	Short b = new Short((short) 2);
	Integer c = new Integer(3);
	Long d = new Long(4L);
	Character e = new Character('가');
	Float f = new Float(3.14F);
	Double g = new Double(3.14);
	Boolean h = new Boolean(true);
	
	Integer c2 = 3; // auto boxing
	int x = c2; // auto unboxing
	
	int y = Integer.parseInt("777"); // 참조 타입 형변환
	// String -(참조 타입 형변환)-> Integer -(언박싱)-> int
	
/*	
   다음은 참조타입의 형변환과 언박싱이 발생하여 String -> int 변경
   ex) int x = Integer.parseInt("14");
   1) 문자 14를 (Integer)"14" -> !nteger 타입으로 형변환 : 참조타입 간 형변환
   2) Integer 14를 int 14로 변경 : 언박싱
     (랩퍼타입과 기본타입 간 변환 / 박싱: 기본 -> 렙퍼, 언박싱: 랩퍼 -> 기본)
     
    // 랩퍼 타입 ArrayList 
    ArrayList<int> list; // error
    ArrayList<Integer> list;
 */



%>
</body>
</html>

