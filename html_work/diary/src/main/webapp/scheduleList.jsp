<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%> <!-- java. 생략 가능  -->
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
    // 연: 23 월: 1 ->  Calendar API에서 22년 12월로 변경
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
	
	// 이전 달 날짜 -> dateNum + preLastDate // dateNum -> 0 이하
	// 다음 달 날짜 -> dateNum - lastDate // dateNum -> 30 ~ 31 이상
	System.out.println("=====================================");
	
	
	// DB data를 가져오는 알고리즘
	// YEAR() MONTH() DAY()
	// SUBSTR(1, 5) : 1 ~ 5번째 문자열 (인덱스 주의)
	// select schedule_no scheduleNo, substr(schedule_memo, 1, 5) scheduleMemo
	// from schedule where year(schedule_date)=? and month(schedule_date)=?
	// order by month(schedule_date) asc;
		
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공(scheduleList)");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	System.out.println("DB 접속 성공(scheduleList) : " + conn);
	
	String sql = "select schedule_no scheduleNo, day(schedule_date) scheduleDate, substr(schedule_memo, 1, 5) scheduleMemo, schedule_color scheduleColor from schedule where year(schedule_date)=? and month(schedule_date)=? order by month(schedule_date) asc";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	stmt.setInt(1, targetYear); // 첫 번째 ? 에 targetYear
	stmt.setInt(2, targetMonth + 1); // 두 번째 ? 에 targetMonth + 1 (mariadb 들어갈 때 1 ~ 12로 표현)
	System.out.println(stmt + " <-- stmt(scheduleList)");
	ResultSet rs = stmt.executeQuery();
	System.out.println(rs + " <-- rs(scheduleList)");
	
	// ResultSet -> ArrayList<Schedule>
	ArrayList<Schedule> scheduleList = new ArrayList<Schedule>();
	while (rs.next()) { // rs 개수만큼 스케줄 생성, 행의 모든 정보 저장 가능, s는 while문 안에서 사라짐 -> 바깥 ArrayList에 저장
		Schedule s = new Schedule();
		s.scheduleNo = rs.getInt("scheduleNo");
		s.scheduleDate = rs.getString("scheduleDate"); // 실제 데이터: 날짜(day)값만 해당
		s.scheduleMemo = rs.getString("scheduleMemo"); // 실제 데이터: memo의 1 ~ 5번째 문자열만 출력
		s.scheduleColor = rs.getString("scheduleColor");
		scheduleList.add(s);
	}	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>scheduleList.jsp</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
 		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<style>
			/* 링크 요소를 화면 좌측에 출력하는 클래스 
			.link-element1 {
			  position: absolute;
			  top: 0;
			  left: 0;
	
			}
			*/
			
			/* 링크 요소를 화면 우측에 출력하는 클래스 */
			.link-element {
			  position: absolute;
			  top: -50;
			  right: 0;
			}
			
			/* 부모 컨테이너에 relative 위치 설정 */
			.parent-container {
			  position: relative;
			}
		</style>
	</head>
	<body>
		<div> <!-- 메인 메뉴 -->
			<a href="home.jsp" class="btn btn-outline-dark">홈으로</a>
			<a href="noticeList2.jsp" class="btn btn-outline-dark">공지 리스트</a>
			<a href="scheduleList.jsp" class="btn btn-outline-dark">일정 리스트</a>
		</div>
		<div class="container mt-3 d-flex justify-content-center">
		<h1><%=targetYear%>년 <%=targetMonth + 1%>월</h1>
		</div>
		<div>
			<a href="./scheduleList.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth - 1%>" class="btn btn-dark">이전 달</a>
			<a href="./scheduleList.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth + 1%>" class="link-element btn btn-dark">다음 달</a>
		</div>
		<table class="table table-bordered"> <!-- border="1" width="90%" / 나중에 css 수정  -->
			<tr>
				<th class="text-bg-dark text-center">일</th>
				<th class="text-bg-dark text-center">월</th>
				<th class="text-bg-dark text-center">화</th>
				<th class="text-bg-dark text-center">수</th>
				<th class="text-bg-dark text-center">목</th>
				<th class="text-bg-dark text-center">금</th>
				<th class="text-bg-dark text-center">토</th>
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
							<div> <!-- 날짜 숫자  -->
								<a href="./scheduleListByDate.jsp?y=<%=targetYear%>&m=<%=targetMonth%>&d=<%=dateNum%>">
									<%=dateNum%>
								</a>
							</div> 
							<div> <!--일정 memo(5글자) -->
								<%
									for (Schedule s : scheduleList) {
										if (dateNum == Integer.parseInt(s.scheduleDate)) {
								%>
									<div style="color:<%=s.scheduleColor%>"><%=s.scheduleMemo%></div>
								<%
										}
									}
								%>
							</div>
						</td>
		<%
					} else {
		%>
						<td>
							<div> <!-- 날짜 숫자  -->
								<a href="./scheduleListByDate.jsp?y=<%=targetYear%>&m=<%=targetMonth%>&d=<%=dateNum%>">
									<%=dateNum%>
								</a>
							</div>
							<div> <!--일정 memo(5글자) -->
								<%
									for (Schedule s : scheduleList) {
										if (dateNum == Integer.parseInt(s.scheduleDate)) {
								%>
									<div style="color:<%=s.scheduleColor%>"><%=s.scheduleMemo%></div>
								<%
										}
									}
								%>
							</div>
							
						</td>
		<% 					
					}	
				} else if (dateNum < lastDate){	// dateNum이 0 이하	
		%>
							<td style="color:gray">
								<%=dateNum + preLastDate%>
							</td>	
		<%	
				} else { // dateNum이 현재 달 마지막 날짜보다 큰 경우
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