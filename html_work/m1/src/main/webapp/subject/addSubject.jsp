<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addSubject</title>
	</head>
	<body>
		<h1>과목 추가</h1>
		<form action="<%=request.getContextPath()%>/subject/addSubjectAction.jsp" method="post">
			<table border="1">
				<tr>
					<th>subjectName</th>
					<td><input type="text" name="subjectName"></td>
				</tr>
				<tr>
					<th>subjectTime</th>
					<td><input type="text" name="subjectTime"></td>
				</tr>
			</table>
			<button type="submit">과목 정보 추가</button>
		</form>
	</body>
</html>