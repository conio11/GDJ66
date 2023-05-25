<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>   
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="util.*"%>
<%
	DBUtil dbUtil = new DBUtil();
	SubjectDao subDao = new SubjectDao();

	Connection conn = dbUtil.getConnection(); // conn이 return됨
	
	Subject sub = new Subject();
	sub = subDao.selectSubjectOne(5);
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>subjectOne</title>
	</head>
	<body>
		<h1>상세페이지</h1>
		<table border="1">
			<tr>
				<th>subjectNo</th>
				<td><%=sub.getSubjectNo()%></td>
			</tr>
			<tr>
				<th>subjectName</th>
				<td><%=sub.getSubjectName()%></td>
			</tr>
			<tr>
				<th>subjectTime</th>
				<td><%=sub.getSubjectTime()%></td>
			</tr>
			<tr>
				<th>createdate</th>
				<td><%=sub.getCreatedate()%></td>
			</tr>
			<tr>
				<th>updatedate</th>
				<td><%=sub.getCreatedate()%></td>
			</tr>
		</table>
	</body>
</html>