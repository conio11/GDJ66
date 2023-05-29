<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>home2</title>
	</head>
	<body>
		<!-- 폼 구성요소를 바이너리로 넘긴다. - 파일첨부 가능, 문자도 바이너리로 넘어간다 -->
		<form action="<%=request.getContextPath()%>/action2.jsp" enctype="multipart/form-data" method="post"> 
			<input type="text" name="msg1" value="hello">
			<input type="text" name="msg2" value="bye">
			<input type="file" name="myfile">
			<button type="submit">multipart/form-data 전송</button>
		</form>
	</body>
</html>