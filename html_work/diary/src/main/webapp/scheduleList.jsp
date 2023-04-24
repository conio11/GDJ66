<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
	int targetYear = 0;
	int targetMonth = 0; // 0 ~ 11 값으로 들어옴 // 출력 단계에서 값 변경
	
	// 연도 또는 월 요청값이 넘어오지 않으면 오늘 날짜의 연도, 월 사용 (링크 클릭 시 값 입력)
	// (최초 실행 시 값 없으므로 오늘 날짜로 진행)
	if (request.getParameter("targetYear") == null
	|| request.getParameter("targetMonth") == null) {
		Calendar c = Calendar.getInstance();
		targetYear = c.get(Calendar.YEAR);
		targetMonth = c.get(Calendar.MONTH);
	
	} else {
		targetYear = Integer.parseInt(request.getParameter("targetYear"));
		targetMonth = Integer.parseInt(request.getParameter("targetMonth"));
	}
	
	// 디버깅 코드 항상 작성
	System.out.println(targetYear + " <-- targetYear(List)");
	System.out.println(targetMonth + " <-- targetMonth(List)");
	System.out.println((targetMonth + 1) + "월 <-- targetMonthReal(List)");
	
	// 오늘 날짜
	Calendar today = Calendar.getInstance(); // today - 오늘 날짜 정보 
	int todayDate = today.get(Calendar.DATE);
	
	// targetMonth의 1일의 요일
	Calendar firstDay = Calendar.getInstance(); // firstDay - 오늘 날짜 정보 (2023.4.24)
	firstDay.set(Calendar.YEAR, targetYear); // firstDay의 연도 -> targetYear (2023) 
	firstDay.set(Calendar.MONTH, targetMonth); // firstDay의 월 -> targetMonth (4) // Calendar API에서 -1, 12값 들어올 시 이전 연도 12월, 다음 연도 1월로 자동 변경
	firstDay.set(Calendar.DATE, 1); // (2023.4.1)
	
	// targetYear, targtMonth를 API 내부 값으로 다시 받아옴
	// 연: 23 월: 12 -> Calendar API에서 24년 1월로 변경
    // 연: 23 월: 1 ->  Calendar API에서 년22 월12 변경
	targetYear = firstDay.get(Calendar.YEAR);
	targetMonth = firstDay.get(Calendar.MONTH);
	System.out.println(targetYear + " <-- API 실행 후 targetYear(List)");
	System.out.println(targetMonth + " <-- API 실행 후 targetMonth(List)");
	
	int firstYoil = firstDay.get(Calendar.DAY_OF_WEEK); // (2023.4.1) -> 몇 번째 요일인지 // 일요일 1, 월요일 2, ... , 토요일 7
	
	// 1일 앞의 공백칸 수
	int startBlank = firstYoil - 1; // 일요일(1)에 공백 0, 월요일(2)이면 공백 1, ... 토요일(7)에 공백 6
	System.out.println(startBlank + " <--startBlank(List)");
	
	// targetMonth의 마지막 일
	int lastDate = firstDay.getActualMaximum(Calendar.DATE); // firstDay의 월의 날짜 중 가장 큰 값 (마지막 일) 반환
	
	// lastDate 날짜 뒤 공백칸 수
	// 1일 이전 공백 + 
	int endBlank = 0;
	int totalTd = 0;
	if ((startBlank + lastDate) % 7 != 0) {
		endBlank = 7 - ((startBlank + lastDate) % 7);
	}
	System.out.println(lastDate + " <-- lastDate(List)");
	
	// 이전 달 연도, 월
	int preTargetYear = targetYear;
	int preTargetMonth = targetMonth - 1;
	
	Calendar preMonth = Calendar.getInstance(); // preMonth - 오늘 날짜 정보
	preMonth.set(Calendar.YEAR, preTargetYear); // preMonth의 연도 변경
	preMonth.set(Calendar.MONTH, preTargetMonth); // preMonth의 월 변경
	int preLastDate = preMonth.getActualMaximum(Calendar.DATE); // 이전 달의 마지막 날짜
	
	
	// 전체 td 개수
	totalTd = startBlank + lastDate + endBlank;
	System.out.println(totalTd + " <-- totalTd(List)");
	
	System.out.println("=====================================");
	// 이전 달 날짜 -> dateNum + preLastDate // dateNum -> 0 이하
	// 다음 달 날짜 -> dateNum - lastDate // dateNum -> 30 ~ 31 이상
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>scheduleList.jsp</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
 		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div> <!-- 메인 메뉴 -->
			<a href="home.jsp">홈으로</a>
			<a href="noticeList2.jsp">공지 리스트</a>
			<a href="scheduleList.jsp">일정 리스트</a>
		</div>
		<div class="container mt-3 d-flex justify-content-center">
		<h1><%=targetYear%>년 <%=targetMonth + 1%>월</h1>
		</div>
		<div>
			<a href="./scheduleList.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth - 1%>">이전 달</a>
			<a href="./scheduleList.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth + 1%>">다음 달</a>
		</div>
		<table class="table table-bordered"> <!-- border="1" width="90%" / 나중에 css 수정  -->
			<tr>
				<th class="text-bg-dark">일</th>
				<th class="text-bg-dark">월</th>
				<th class="text-bg-dark">화</th>
				<th class="text-bg-dark">수</th>
				<th class="text-bg-dark">목</th>
				<th class="text-bg-dark">금</th>
				<th class="text-bg-dark">토</th>
			</tr>
			<tr>
		<%
			// 전체 칸 수만큼 반복
			for (int i = 0; i < totalTd; i++) { // i += 1
				if (i != 0 && i % 7 == 0) { // i가 0이어도 i % 7 == 0이므로 i != 0
		%>	
				</tr><tr>
		<%
				}
				String tdStyle = "";
				int dateNum = i - startBlank + 1;
				
				if (dateNum > 0 && dateNum <= lastDate) {
					// 오늘 날짜이면 배경색 변경
					if (today.get(Calendar.YEAR) == targetYear
						&& today.get(Calendar.MONTH) == targetMonth
						&& today.get(Calendar.DATE) == dateNum) {
						tdStyle = "background-color: orange";			
						
		%>
						<td style="<%=tdStyle%>">
							<a href="./scheduleListByDate.jsp?y=<%=targetYear%>&m=<%=targetMonth%>&d=<%=dateNum%>">
								<%=dateNum%>
							</a>
						</td>
		<%
					} else {
		%>
						<td>
							<a href="./scheduleListByDate.jsp?y=<%=targetYear%>&m=<%=targetMonth%>&d=<%=dateNum%>">
								<%=dateNum%>
							</a>
						</td>
		<% 					
					}	
				} else if (dateNum < lastDate){			
		%>
							<td style="color:gray">
								<%=dateNum + preLastDate%>
							</td>	
		<%	
				} else {
		%>	
							<td style="color:gray">
								<%=dateNum - lastDate%>
							</td>
		<%			
				}
			}	
		%>
			</tr>	
		</table>
	</body>
</html>