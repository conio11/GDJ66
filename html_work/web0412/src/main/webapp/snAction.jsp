<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<!DOCTYPE html
<html>
<head>
<meta charset="UTF-8">
<title>snAction</title>
</head>
<body>

<%
	// 1. 요청처리
	String sn = request.getParameter("sn1") + request.getParameter("sn2"); // 주민번호 앞자리 + 뒷자리 숫자 붙여서 출력

	// 9012251234567
	// 7(인덱스 6)번째 문자(열)를 뽑아서 숫자로 변경
	String s7 = sn.substring(6, 7); // (시작) ~ (끝 - 1) 출력
	int gender = Integer.parseInt(s7);
	
	String sGender = null; // if gender 짝수 - 여성, 홀수 - 남성
	
	if (gender % 2 == 0) {
		sGender = "여성";
	} else {
		sGender = "남성";
	}
	

	String preYear = null;
	if (gender == 0 || gender == 9) {
		preYear = "18";
	} else if (gender == 1 || gender == 2 || gender == 5 || gender == 6) {
		preYear = "19";
	} else {
		preYear = "20";
	}
	
	String year = preYear + sn.substring(0, 2); // 태어난 연도 4자리 : String 타입
	int birthYear = Integer.parseInt(year); // 형변환
	
	// java.util.Calendar today = new java.util.Calendar(); // new(); 로 생성 불가
	// java.util.Calendar today = java.util.Calendar.getInstance();
	
	// 오늘 날짜 정보를 반환(today) 하는 코드
	Calendar today = java.util.Calendar.getInstance();
	
	
	// today에서 오늘 연도만 추출
	int todayYear = today.get(Calendar.YEAR);
	int age = todayYear - birthYear + 1;
%>

	<div>성별: <%=sGender%></div>
	<div>나이: <%=age%></div>

</body>
</html>