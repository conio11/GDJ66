<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>modifyMember</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				const urlParams = new URL(location.href).searchParams;
				const msg  = urlParams.get("msg");
				if (msg != null) {
					alert(msg);
				}
				
				$("#modifyMemberBtn").click(function() {
					if ($("#memberPw").val() == "") {
						alert("현재 비밀번호를 입력해주세요.");
					} else if ($("#newPw1").val() == "") {
						alert("새 비밀번호를 입력해주세요.");
					} else if ($("#newPw2").val() == "") {
						alert("새 비밀번호를 다시 입력해주세요.");
					} else {
						$("#modifyMember").submit();
					}
				});
			});
		</script>
	</head>
	<body>
		<h1>회원정보수정</h1>
		<form method="post" action="${pageContext.request.contextPath}/modifyMember" id="modifyMember">
			<table border="1">
				<tr>
					<td>현재 비밀번호 입력</td>
					<td><input type="password" name="memberPw" id="memberPw">
				</tr>
				<tr>
					<td>새 비밀번호 입력</td>
					<td><input type="password" name="newPw1" id="newPw1">
				</tr>
				<tr>
					<td>새 비밀번호 다시 입력</td>
					<td><input type="password" name="newPw2" id="newPw2">
				</tr>
			</table>
			<button type="button" id="modifyMemberBtn">비밀번호 수정</button>
		</form>
	</body>
</html>