<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<%
	int targetYear = 0;
	int targetMonth = 0; // 0 ~ 11
	// int targetDate = 0; // 추가
	
	// 최초 실행 시 request값 없으므로 if문 실행
	if (request.getParameter("targetYear") == null 
			|| request.getParameter("targetMonth") == null) {
		// 둘 중 하나라도 null이면 예외 발생
		// 값이 지정되지 않으면 오늘 날짜 사용
		
		Calendar today = Calendar.getInstance();
		targetYear = today.get(Calendar.YEAR);
		targetMonth = today.get(Calendar.MONTH);
		
	} else { // 링크 클릭 이후 request 전달값 받아 else문 실행
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
	
	// startTdBlank: 달력 1일 앞의 공백 수
	// 현재 월의 1일의 DAY_OF_WEEK(요일): (일1, 월2, 화3, ..., 토7) - 1
	int startTdBlank = 0; 
	
	// 출력하고자 하는 연, 월, 1일
	Calendar firstDate = Calendar.getInstance(); // firstDate에 오늘 날짜 가져옴
	firstDate.set(Calendar.YEAR, targetYear); // firstDate의 연도를 2023년으로 변경
	firstDate.set(Calendar.MONTH, targetMonth); 
	firstDate.set(Calendar.DATE, 1); 
	
	// 출력하고자 하는 연, 월의 공백 수
	startTdBlank = firstDate.get(Calendar.DAY_OF_WEEK) - 1; 									
	System.out.println(startTdBlank + " <-- startTdBlank");
	
	// 출력하고자 하는 연/월/마지막 날짜
	int endDateNum = firstDate.getActualMaximum(Calendar.DATE); // 현재 출력할 달력의 마지막 날
	System.out.println(endDateNum + " <-- endDateNum");
	
	// 추가
	// 출력하는 이전 달의 연, 월, 마지막 날짜
	// 출력하는 이전 달 예외 처리
	int preTargetYear = targetYear;
	int preTargetMonth = targetMonth - 1;
	
	if (preTargetMonth == -1) {
		preTargetMonth = 11;
		preTargetYear = preTargetYear - 1;
	} 
	
/* 	else if (preTargetMonth == 12) {
		preTargetMonth = 0;
		preTargetYear = preTargetYear + 1;
	} */
	
	System.out.println(preTargetYear + "<-- preTargetYear");
	System.out.println(preTargetMonth + " <-- preTargetMonth");
	
	// 추가
	// 출력하는 전월 연, 월, 마지막 날짜 출력
	Calendar preMonth = Calendar.getInstance();
	preMonth.set(Calendar.YEAR, preTargetYear);
	preMonth.set(Calendar.MONTH, preTargetMonth);
	int preEndDateNum = preMonth.getActualMaximum(Calendar.DATE);
	System.out.println(preEndDateNum + "<-- preEndDateNum");
	
	// 추가 
	// 출력하는 다음 달 예외 처리
	int nextTargetYear = targetYear;
	int nextTargetMonth = targetMonth + 1;
	
/* 	if (nextTargetMonth == -1) {
		nextTargetMonth = 11;
		nextTargetYear = nextTargetYear - 1; 
	} else */

	if (nextTargetMonth == 12) {
		nextTargetMonth = 0;
		nextTargetYear = nextTargetYear + 1;
	}
	
	// 디버깅 코드
	System.out.println(nextTargetYear + "<-- nextTargetYear");
	System.out.println(nextTargetMonth + " <-- nextTargetMonth");
	
	// 달력 마지막 날짜 출력 후 공백(td) 수
	int endTdBlank = 0;
	if ((startTdBlank + endDateNum) % 7 != 0) {
		endTdBlank = 7 - ((startTdBlank + endDateNum) % 7);
	}
	
	int totalTdCnt = startTdBlank + endDateNum + endTdBlank;
	
	System.out.println("==================");
%>
<!DOCTYPE html>
<html>
	<head>
		<title>calendar3.jsp</title>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1"> <!-- 임시 -->

		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<style>
			.green {color: green;}
			
		</style>
	</head>
	<body>
		<div class="container"></div>
		<h1>
			<a href="./calendar3.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth - 1%>" class="green">이전 달</a>
			<%=targetYear%>년 <%=targetMonth + 1%>월
			<a href="./calendar3.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth + 1%>" class="green">다음 달</a>
		</h1>
		<form action="calender3.jsp" method="post">
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
	 			
	 			// 주석 추가
	 			// 날짜 출력
	 			int dateNum = i - startTdBlank + 1;
	 			
	 			// 추가
	 			// 이전 달 날짜 출력
	 			int preMonthDate = preEndDateNum - startTdBlank + 1;
	 			
	 			// 추가
	 			// 다음 달 날짜 출력
	 			int nextMonthDate = i - endDateNum - startTdBlank + 1;
	 			
	 			if (dateNum > 0 && dateNum <= endDateNum) {
	 					if (i % 7 == 0) {
		%>		
							<td>
								<a href="./calendarConnect.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth%>&targetDate=<%=dateNum%>" class="text-danger"><%=dateNum%></a>
							</td>
		<%		
	 					} else {
		%>	
							<td>
								<a href = "./calendarConnect.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth%>&targetDate=<%=dateNum%>" class="text-light"><%=dateNum%></a>
							</td>
		<%					
 						}
	 					
	 			} else if (dateNum < 1) {
	 				
		%>	
	 				<td>
	 					<a href="./calendarConnect.jsp?targetYear=<%=preTargetYear%>&targetMonth=<%=preTargetMonth%>&targetDate=<%=preMonthDate + i%>" class="text-muted">
	 					<%=preMonthDate + i%>
	 					</a>
	 				</td>
 		<%			
	 			} else {
	 				
		%>
					<td>
						<a href="./calendarConnect.jsp?targetYear=<%=nextTargetYear%>&targetMonth=<%=nextTargetMonth%>&targetDate=<%=nextMonthDate%>" class="text-muted"><%=nextMonthDate%></a>
					</td>
		<%	
	 			}
	 		}
	 	%>
			</tr>
		</table>
		</form>	
	</body>
</html>