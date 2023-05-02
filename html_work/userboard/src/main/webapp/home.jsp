<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>home</title>
	</head>
	<body>
		<%
			// request.getRequestDispatcher(request.getContextPath()+ "/inc/mainmenu.jsp").include(request, response);
			// 위 코드를 액션 태그로 변경하면 아래와 같음
		%>
		<div>
			<jsp:include page="./inc/mainmenu.jsp"></jsp:include> <!-- mainmenu.jsp 의 결과를 현재 페이지에서 사용 가능 -->
		</div>
		
		<div>
			<!-- home 내용: 카테고리별 게시글 5개씩  -->
			<!-- 로그인 폼  -->
		<%
			if (session.getAttribute("loginMemberID") == null) { // 로그인 전이면 로그인 폼 출력
		%>
				<form action="<%=request.getContextPath()%>/member/loginAction.jsp" method="post"> <!-- 절대 주소로 작성 - "/web0502/loginAction.jsp"  -->
					<table border="1">
						<tr>
							<td>아이디</td>
							<td><input type="text" name="memberID"></td>
						</tr>
						<tr>
							<td>패스워드</td>
							<td><input type="password" name="memberPW"></td>
						</tr>
					</table>
					<button type="submit">로그인</button>
				</form>
		<%
			}
		%>
			<!-- 카테고리별 게시글 5개씩 -->
		
		</div>
		
		<div>
			<!-- include 페이지 : Copyright &copy; 구디아카데미 -->
			<jsp:include page="./inc/copyright.jsp"></jsp:include>
		</div>
	</body>
</html>