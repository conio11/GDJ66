<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cosForm</title>
	</head>
	<body>
		<form action="./cosAction.jsp" method="post" enctype="multipart/form-data">
		<input type="text" name="id">
		<input type="file" name="pic">
		<button type="submit">multipart/form-data</button>
		</form>
	</body>
</html>