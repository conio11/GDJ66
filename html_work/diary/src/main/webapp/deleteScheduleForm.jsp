<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 요청값 유효성 검사
	if (request.getParameter("scheduleNo") == null) {
		response.sendRedirect("./scheduleListByDate.jsp");
		return;
	}
	
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	System.out.println(scheduleNo + " <-- scheduleNo(deleteForm)");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>deleteSchedule</title>
	</head>
	<body>
		<h1>일정 삭제</h1>
		<form action="./deleteScheduleAction.jsp" method="post">
			<table border="1"> <!-- css 추후 수정  -->
				<tr>
					<td>schedule_no</td>
					<td>
						<input type="text" name="scheduleNo" value="<%=scheduleNo%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>schedule_pw</td>
					<td>
						<input type="password" name="schedulePw">
					</td>
				</tr>
			</table>
			<div>
				<button type="submit">삭제</button>
			</div>
		</form>
	</body>
</html>