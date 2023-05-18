<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>home</title>
	</head>
	<body>
		<h1>1. enctype : application/x-www-form-urlencoded(디폴트 값)</h1>
		<form action="./action.jsp" method="post" enctype="application/x-www-form-urlencoded">
			<input type="text" name="id">
			<input type="file" name="pic">
			<button type="submit">appication/x-www-form-urlencoded</button>
		</form>
		
		<hr>
		
		<h1>2. enctype : multipart/form-data</h1>
		<form action="./action.jsp" method="post" enctype="multipart/form-data">
			<input type="text" name="id">
			<input type="file" name="pic">
			<button type="submit">multipart/form-data</button>
		</form>
	</body>
</html>