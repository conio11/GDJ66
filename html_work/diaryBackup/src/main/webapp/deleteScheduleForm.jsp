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
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div><!-- 메인메뉴 -->
			<a href="./scheduleList.jsp" class="btn btn-outline-dark">일정 리스트</a>
		</div>
		<div class="container mt-3 d-flex justify-content-center">
			<h1>일정 삭제</h1>
		</div>
		<form action="./deleteScheduleAction.jsp" method="post">
			<table class="table table-bordered"> <!-- css 추후 수정  -->
				<tr>
					<td class="text-bg-dark text-center">schedule_no</td>
					<td>
						<input type="text" name="scheduleNo" value="<%=scheduleNo%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="text-bg-dark text-center">schedule_pw</td>
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