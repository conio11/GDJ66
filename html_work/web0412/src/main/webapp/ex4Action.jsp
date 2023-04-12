<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8"); // void: 반환값 없음
	String gender = request.getParameter("gender");
	String married = request.getParameter("married");
%>
		<div>
			성별
			<%
				if (gender.equals("남")) {
					// 라디오에서 남이 선택된 상태
			%>
					<input type="radio" value="남" name="gender" checked="checked">남
					<input type="radio" value="여" name="gender">여
			<% 		
				} else {
					// 라디오에서 여가 선택된 상태
			%>
					<input type="radio" value="남" name="gender">남
					<input type="radio" value="여" name="gender" checked="checked">여
			<% 
				}
			%>
		</div>

		<div>
			<select name="married">
			<%
				if (married.equals("미혼")) {
					// 옵션에서 미혼이 선택된 상태
			%>
					<option value="미혼" selected="selected">미혼</option>
					<option value="기혼">기혼</option>
			<% 		
				} else {
					// 옵션에서 기혼이 선택된 상태
			%>
					<option value="미혼">미혼</option>
					<option value="기혼" selected="selected">기혼</option>
			<% 
				}
			%>
			</select>
		</div>
		
		<div>
			<button type="submit">전송</button>
		</div>
		
</body>
</html>