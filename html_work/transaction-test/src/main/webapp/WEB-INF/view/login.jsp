<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>login</title>
	</head>
	<body>
		<h1>login</h1>
		<form action="${pageContext.request.contextPath}/login" method="post">
	     	<div>
	        	 아이디 : <input type="text" name="id" value="${loginId}">
	        </div>
	        <div>
	        	비밀번호 : <input type="password" name="pw">
	      	</div>
	        <div>
	       		<input type="checkbox" name="idSave" value="y">ID저장 <!-- 체크가 되어있으면 value 넘어옴  -->
	        </div>
	        <div>
	       		<button type="submit">로그인</button>
	        </div>
   		</form>
	</body>
</html>