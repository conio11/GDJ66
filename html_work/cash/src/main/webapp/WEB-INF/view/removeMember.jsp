<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>removeMember</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				const urlParams = new URL(location.href).searchParams;
				const msg  = urlParams.get("msg");
				if (msg != null) {
					alert(msg);
				}
				
				$("#removeMemberBtn").click(function() {
					if ($("#memberPw").val() == "") {
						alert("비밀번호를 입력해주세요.");	
						$("#memberPw").focus();
					} else {
						$("#removeMember").submit();
					}
				});
			});
		</script>
	</head>
	<body>
		<a href="${pageContext.request.contextPath}/calendar">홈 화면으로</a>
		<h1>회원탈퇴</h1>
		<form method="post" action="${pageContext.request.contextPath}/removeMember" id="removeMember">
			<table border="1">
				<tr>
					<td>비밀번호 입력</td>
					<td><input type="password" name="memberPw" id="memberPw"></td>
				</tr>
			</table>
			<button type="button" id="removeMemberBtn">회원탈퇴</button>
		</form>
	</body>
</html>