<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<%
	int targetYear = 0;
	int targetMonth = 0; // 0 ~ 11
	
	if (request.getParameter("targetYear") == null 
			|| request.getParameter("targetYear") == null) {
		// 둘 중 하나라도 null이면 예외 발생
		// 값이 지정되지 않으면 오늘 날짜 사용
		
		Calendar today = Calendar.getInstance();
		targetYear = today.get(Calendar.YEAR);
		targetMonth = today.get(Calendar.MONTH);
		
	} else {
		// 출력하고자 하는 달력의 연도와 월
		targetYear = Integer.parseInt(request.getParameter("targetYear"));
		targetMonth = Integer.parseInt(request.getParameter("targetMonth"));
		if (targetMonth == -1) { // targetMonth == 0일 때 1(targetMonth + 1)월,
								 // targetMonth == - 1일 때 이전 해 12(targetMonth + 1)월이므로 tM = 11, tY = tY - 1
			targetMonth = 11;	
			targetYear = targetYear - 1;
		} else if (targetMonth == 12) { // targetMonth == 12 일 때 다음 해 1(targetMonth + 1)월 이므로 tM = 0, tY = tY + 1
			targetMonth = 0;
			targetYear = targetYear + 1;
		}
	}
	
	// 디버깅 코드
	// http://localhost:8080/web0417/calendar.jsp?targetYear=2023&targetMonth=3
	System.out.println(targetYear + " <-- targetYear");
	System.out.println(targetMonth + " <-- targetMonth");
	
	// 달력 1일 앞의 공백 수
	// 현재 월의 1일의 DAY_OF_WEEK(요일): (일1, 월2, 화3, ..., 토7) - 1
	int startTdBlank = 0; // 1일 앞 공백의 개수
	
	// 출력하고자 하는 연, 월, 1일
	Calendar firstDate = Calendar.getInstance(); // firstDate에 오늘 날짜 가져옴
	firstDate.set(Calendar.YEAR, targetYear); // firstDate의 연도를 2023년으로 바꿈
	firstDate.set(Calendar.MONTH, targetMonth); 
	firstDate.set(Calendar.DATE, 1); 
	startTdBlank = firstDate.get(Calendar.DAY_OF_WEEK) - 1;
	
	System.out.println(startTdBlank + " <-- startTdBlank");
	
	// 출력하고자 하는 연/월/마지막 날짜
	int endDateNum = firstDate.getActualMaximum(Calendar.DATE); // 현재 출력할 달력의 마지막 날
	System.out.println(endDateNum + " <-- endDateNum");
	
	// 달력 마지막 날짜 출력 후 공백(td) 수
	int endTdBlank = 0;
	if ((startTdBlank + endDateNum) % 7 != 0) {
		endTdBlank = 7 - ((startTdBlank + endDateNum) % 7);
	}
	
	// 전체 칸 개수
	int totalTdCnt = startTdBlank + endDateNum + endTdBlank;
	
	System.out.println("==================");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>calendar2.jsp</title>
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div class="container"></div>
		<h1>
			<a href="./calendar2.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth - 1%>">이전 달</a>
			<%=targetYear%>년 <%=targetMonth + 1%>월
			<a href="./calendar2.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth + 1%>">다음 달</a>
		</h1>
		<table class="table table-dark table-striped">
			<thead>
			 	<tr>
			 		<th>일</th>
			 		<th>월</th>
			 		<th>화</th>
			 		<th>수</th>
			 		<th>목</th>
			 		<th>금</th>
			 		<th>토</th>
			 	</tr>
		 	</thead>
		 		<tr>
	 	<% 
	 		for (int i = 0; i < totalTdCnt; i++) {
	 			if (i % 7 == 0) {
		%>	
					</tr><tr>
		<%		
	 			}
	 			
	 			int dateNum = i - startTdBlank + 1;
	 			if (dateNum > 0 && dateNum <= endDateNum) {
		%>			
	 				<td><a href=""><%=i - startTdBlank + 1%></a></td>
 		<%		
	 			} else {	
		%>	
	 				<td>&nbsp;</td>
 		<%			
	 			}	
	 		}
	 	%>
	 	
	 	<!-- 부트스트랩-CSS -->
	 	<!-- 날짜 클릭 시 일정입력 폼 -->
	 	<!-- 일요일 빨간색 -->
	 	<!-- 전, 후 날짜 회색으로 출력-->
			</tr>
		</table>	
	</body>
</html>