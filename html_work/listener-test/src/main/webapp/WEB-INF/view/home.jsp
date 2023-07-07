<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>home</title>
	</head>
	<body>
		<h1>home</h1>
		<div>
			현재 접속자: ${currentCounter} <!-- application.getAttribute("currentCounter")  -->
		</div>
		<div>
			오늘 접속자: ${counter} <!-- request.getAttribute("counter")  -->
		</div>
		<div>
			누적 접속자: ${totalCounter} <!-- request.getAttribute("totalCounter")  -->
		</div>
	</body>
</html>