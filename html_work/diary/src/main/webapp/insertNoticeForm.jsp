<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertNoticeForm</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div><!-- 메인메뉴 -->
			<a href="./home.jsp">홈으로</a>
			<a href="./noticeList2.jsp">공지 리스트</a>
			<a href="./scheduleList.jsp">일정 리스트</a>
		</div>
		<div class="container mt-3 d-flex justify-content-center">
		<h1>공지 입력</h1>
		</div>
		<form action="./insertNoticeAction.jsp" method="post">
			<table class="table table-bordered">
				<tr>
					<td class="text-bg-dark text-center">notice_title</td>
					<td>
						<input type="text" name="noticeTitle">
					</td>
				</tr>
				<tr>
					<td class="text-bg-dark text-center">notice_content</td>
					<td>
						<textarea rows="5" cols="80" name="noticeContent"></textarea>
					</td>
				</tr>
				<tr>
					<td class="text-bg-dark text-center">notice_writer</td>
					<td>
						<input type="text" name="noticeWriter">
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