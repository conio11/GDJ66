<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<ul>
		<li><a href="<%= request.getContextPath()%>/home2.jsp" class="btn">홈으로</a></li>
		<!--
		로그인 전: 회원가입 링크	
		로그인 후: 회원정보 / 로그아웃 (로그인 정보 세션: loginMemberID) 링크
		-->
		<%
			if (session.getAttribute("loginMemberID") == null) {
		%>
				<li><a href="<%= request.getContextPath()%>/member/insertMemberForm.jsp" class="btn">회원가입</a></li>
		<% 
			} else { // 로그인 후 
		%>
				<li><a href="<%= request.getContextPath()%>/member/memberInfo.jsp" class="btn">회원정보</a></li>
				<li><a href="<%= request.getContextPath()%>/member/logoutAction.jsp" class="btn">로그아웃</a></li>
		<%
			}
		%>
	</ul>
</div>