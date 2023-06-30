<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cash.model.MemberDao"%>
<%@ page import="cash.vo.Member"%>

<%
	Member m = (Member) request.getAttribute("member"); // request 보낼 때 "member"라는 이름의 member 객체 생성
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>memberOne</title>
	</head>
	<body>
		<h1>회원 상세정보</h1>
		<table border="1">
			<tr>
				<td>memberId</td>
				<td><%=m.getMemberId()%></td>
			</tr>
			<tr>
				<td>memberPw</td>
				<td><%=m.getMemberPw().substring(0, 2)%></td>
			</tr>
			<tr>
				<td>createdate</td>
				<td><%=m.getCreatedate()%></td>
			</tr>
			<tr>
				<td>updatedate</td>
				<td><%=m.getUpdatedate()%></td>
			</tr>
		</table>
		<a href="${pageContext.request.contextPath}/modifyMember">회원정보수정</a>
		<a href="${pageContext.request.contextPath}/removeMember">회원탈퇴</a>
	</body>
</html>