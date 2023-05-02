<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 로그인한 사용자만 접근 (주소로 접근 불가)
	if (session.getAttribute("loginID") == null) { // 현재 사용자 브라우저에서 로그인 발생하지 않은 경우
		String msg = URLEncoder.encode("잘못된 접근, 로그인 필요", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?msg=" + msg); // 메시지와 함께 로그인 폼으로 리다이렉트
		return; // 실행 종료 // return 사용하지 않을 시 else 없으므로 해당 파일 계속 실행 
	}
%>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>home</title>
	</head>
	<body>
	<%	
		String loginID = (String) session.getAttribute("loginID"); // . 연산자가 가장 먼저 실행, 대입 연산자는 마지막에 실행
	%>
		<h1>홈</h1>
		<div>
			<%=loginID%>님 반갑습니다
			<a href="<%=request.getContextPath()%>/logoutAction.jsp">로그아웃</a> <!-- 로그아웃 실행 ->  -->
		</div>
	</body>
</html>