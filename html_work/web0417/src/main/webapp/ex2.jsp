<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<%
	// Calendar c = new Calendar(); // new(); 와 같이 생성 불가
	Calendar c = Calendar.getInstance();
	
		String yoil = "";
		switch (c.get(Calendar.DAY_OF_WEEK)) {
		case 1: 
			yoil = "일";
			break;
		case 2: 
			yoil = "월";
			break;
		case 3: 
			yoil = "화";
			break;
		case 4: 
			yoil = "수";
			break;
		case 5: 
			yoil = "목";
			break;
		case 6: 
			yoil = "금";
			break;
		default:
			yoil = "토";
		}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ex2.jsp</title>
</head>
<body>
	<div>Calendar.getInstance : <%=c%></div>
	<div>Year : <%=c.get(Calendar.YEAR)%></div>
	<div>Month : <%=c.get(Calendar.MONTH)%> (+1 해서 읽어야 함)</div>
	<div>Date : <%=c.get(Calendar.DATE)%></div>
	<div>이번 주의 몇 번째 날 : <%=c.get(Calendar.DAY_OF_WEEK)%></div>
	<div>요일 : <%=yoil%></div>
	<div>현재 달의 마지막 날짜 : <%=c.getActualMaximum(Calendar.DATE)%></div>
</body>
</html>