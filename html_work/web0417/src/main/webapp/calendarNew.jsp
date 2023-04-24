<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.Calendar" %>
<%
	int targetYear = 0; //선언	
	int targetMonth = 0;
	
	if(request.getParameter("targetYear") == null
			|| request.getParameter("targetMonth") == null) {
		Calendar today = Calendar.getInstance(); //getInstance()는 최초에 할당된 하나의 메모리를 계속 쓰는 방식
		targetYear = today.get(Calendar.YEAR);
		targetMonth = today.get(Calendar.MONTH);
	} else {
		targetYear = Integer.parseInt(request.getParameter("targetYear")); //getParameter는 항상 String 형태로 반환하므로
		targetMonth = Integer.parseInt(request.getParameter("targetMonth")); // 주의할점은 int 타입의 변수에 값을 저장하고 싶다면 형변환을 해줘야함
		if(targetMonth == -1) {
			targetMonth = 11;
			targetYear = targetYear - 1;
		} else if(targetMonth == 12) {
			targetMonth = 0;
			targetYear = targetYear + 1;
		}
	}
	
	// 디버깅
	
	System.out.println(targetYear + " <-- targetYear");
	System.out.println(targetMonth + " <-- targetMonth");
	
	//달력 1일 앞의 공백수
	// 현재월의 1일의 DAY_OF_WEEK(일 1, 월 2, ... 토 7 ) - 1
	int startTdBlank = 0;
	// 출력하고자 하는 년/월/1일
	Calendar firstDate = Calendar.getInstance();
	firstDate.set(Calendar.YEAR, targetYear);
	firstDate.set(Calendar.MONTH, targetMonth);
	firstDate.set(Calendar.DATE, 1);
	startTdBlank = firstDate.get(Calendar.DAY_OF_WEEK) - 1;
	
	// 출력하고자 하는 년/월-1/1일
	Calendar secondDate = Calendar.getInstance();
	secondDate.set(Calendar.YEAR, targetYear);
	secondDate.set(Calendar.MONTH, targetMonth-1);
	secondDate.set(Calendar.DATE, 1);
	startTdBlank = secondDate.get(Calendar.DAY_OF_WEEK) - 1;
	
	//디버깅
	System.out.println(startTdBlank + " <-- startTdBlank");
	
	//마지막 날 구하기
	int endDateNum = firstDate.getActualMaximum(Calendar.DATE);
	int endDateNum2 = secondDate.getActualMaximum(Calendar.DATE);
	//디버깅
	System.out.println(endDateNum + " <-- endDateNum");
	
	//달력 마지막 날짜 출력 후 공백(td) 수
	int endTdBlank = 0;
	if((startTdBlank + endDateNum) % 7 != 0) {
		endTdBlank = 7-((startTdBlank + endDateNum)%7);
	}
	int totalTdCnt = startTdBlank + endDateNum + endTdBlank;
	
	//디버깅
	System. out.println(totalTdCnt + " <--totalTdCnt");
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>calendar.jsp</title>
</head>
	<style>
	.black{
		color:#000000;
	}
	.red{
		color:#FF0000;
	}
	
	</style>
<body>
<div class="container">
	<h1>
		<a href="./calendarNew.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth-1%>">이전달</a>
		<%=targetYear%>년 <%=targetMonth+1%>월
		<a href="./calendarNew.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth+1%>">다음달</a>
	</h1>
	<table class="table table-bordered table-striped">
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
				for(int i=0; i<totalTdCnt; i++) {
					if(i%7==0) {
			%>
						</tr><tr>
			<%		
					}
			//날짜 출력
					int dateNum = i - startTdBlank + 1;
					
					
					if(0<dateNum && dateNum <= endDateNum) {
						if(i%7==0){
			%>
						
						<td><a class="red" href="./schedule.jsp"><%=dateNum%></a></td> 
			<%
							}	else{
			%>					
						<td> <a class="gray" href="./schedule.jsp"><%=dateNum%></a></td>			
			<%					
						}	
					}else if (dateNum <= endDateNum){
			%>			
						<td style="color:gray;"><%=dateNum+endDateNum2 %></td>
			<% 		
						System.out.println(dateNum);
						System.out.println(endDateNum2);
					}
				
					else {
			%>
						<td style="color:gray;"><%=dateNum-endDateNum%></td>
			<%			
					}
				}
			%>
		</tr>
	</table>
</div>
</body>
</html>