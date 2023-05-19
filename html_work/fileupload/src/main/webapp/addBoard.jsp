<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//인코딩 설정
	response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>add board + file</title>
		<style type="text/css">
			table, th, td {
				border: 1px solid #FF0000;
			}
		</style>
	</head>
	<body>
		<h1>자료 업로드</h1>
		<form action="<%=request.getContextPath()%>/addBoardAction.jsp" method="post" enctype="multipart/form-data">
			<table>
				<!-- 자료 업로드 글 제목  -->
				<tr>
					<th>boardTitle</th>
					<td>
						<textarea rows="3" cols="50" name="boardTitle" required="required"></textarea> <!-- required: null값 submit 시 경고창 출력 -->
					</td>
				</tr>
				<!-- 로그인 사용자 아이디 -->
			<%
				// String memberID = String(session.getAttribute("loginMemberID");
				String memberID = "test";
			%>
				<tr>
					<th>memberID</th>
					<td>
						<input type="text" name="memberID" value="<%=memberID%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>boardFile</th>
					<td>
						<input type="file" name="boardFile" required="required"> <!-- multiple="multiple": 복수 선택 가능  --> <!-- required: null값 submit 시 경고창 출력 -->
					</td>
				</tr>
			</table>
			<button type="submit">자료 업로드</button>
		</form>
	</body>
</html>