<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="btn-group">
	<a href="<%=request.getContextPath()%>/home.jsp" class="btn btn-outline-warning">홈으로</a>
	<!-- 로그인 전: 회원가입 링크 보이게 / 로그인 후: 회원정보, 지역정보, 로그아웃 링크 보이게  -->
	<!-- 로그인 정보 세션: loginMemberID  -->
	<%
		if (session.getAttribute("loginMemberID") == null) { // 세션 없을 경우(로그인 전)	
	%>
			<a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp" class="btn btn-outline-warning">회원가입</a>
	<%
		} else { // 로그인 후
	%>
			<a href="<%=request.getContextPath()%>/member/memberInfo.jsp" class="btn btn-outline-warning">회원정보</a>
			<a href="<%=request.getContextPath()%>/local/localOne.jsp" class="btn btn-outline-warning">지역정보</a>
			<a href="<%=request.getContextPath()%>/member/logoutAction.jsp" class="btn btn-outline-warning">로그아웃</a>
	<%	
		}
	%>
</div>