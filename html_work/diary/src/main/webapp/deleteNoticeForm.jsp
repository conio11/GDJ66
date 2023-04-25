<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// noticeNo 값 넘어오지 않으면 noticeList2로 리다이렉트
	// 요청값 유효성 검사
	if (request.getParameter("noticeNo") == null) {
		response.sendRedirect("./noticeList2.jsp");
		return;
	}

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo + " <-- deleteNoticeForm param noticeNo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>deleteNoticeForm.jsp</title>
</head>
<body>
	<div><!-- 메인메뉴 -->
		<a href="./home.jsp" class="btn btn-outline-dark">홈으로</a>
	</div>
	<div class="container mt-3 d-flex justify-content-center">
	<h1>공지 삭제</h1>
	</div>
	<form action="./deleteNoticeAction.jsp" method="post">
		<table class="table table-bordered">
			<tr>
				<td class="text-bg-dark text-center">notice_no</td>
				<td>
					<input type="text" name="noticeNo" value="<%=noticeNo%>" readonly="readonly">
					<%-- <input type="hidden" name="noticeNo" value="<%=noticeNo%>"> 보이지 않게 설정  --%>
				</td>
			</tr>
			<tr>
				<td class="text-bg-dark text-center">notice_pw</td>
				<td>
					<input type="password" name="noticePw">
				</td>
			</tr>
		</table>
		<div>
			<button type="submit">삭제</button>
		</div>
	</form>
</body>
</html>