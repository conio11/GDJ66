<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertPracForm</title>
	</head>
	<body>
		<div>
			<a href="./pracHome.jsp">홈 화면으로</a>
			<a href="./pracList.jsp">데이터 리스트</a>
			<a href="">임시 링크</a>
		</div>
		<h1>데이터 입력</h1>
		<form action="./insertPracAction.jsp" method="post">
			<table border="1">
				<tr>
					<td>prac_title</td>
					<td>
						<input type="text" name="pracTitle">
					</td>
				</tr>
				<tr>
					<td>prac_content</td>
					<td>	
						<textarea rows="5" cols="50" name="pracContent"></textarea>
					</td>
				</tr>
				<tr>
					<td>prac_writer</td>
					<td>
						<input type="text" name="pracWriter">
					</td>
				</tr>
				<tr>
					<td>prac_pw</td>
					<td>
						<input type="password" name="pracPw">
					</td>
				</tr>
			</table>
			<div>	
				<button type="submit">입력</button>
			</div>
		</form>
	</body>
</html>