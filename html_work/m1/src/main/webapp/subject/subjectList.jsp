<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>   
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="util.*" %>
    
<%
	int beginRow = 0;
	int rowPerPage = 10;
	
	DBUtil dbUtil = new DBUtil();
	SubjectDao subDao = new SubjectDao();
	
	Connection conn = dbUtil.getConnection(); // conn이 return됨
	
	// ArrayList<Subject> list 생성 후 값 추가 
	ArrayList<Subject> list = new ArrayList<>();
	list = subDao.selectSubjectListByPage(beginRow, rowPerPage);
	System.out.println(subDao.selectSubjectListByPage(beginRow, rowPerPage));
	
	System.out.println("=============subjectList=============");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>subjectList</title>
	</head>
	<body>
		<table border="1">
			<tr>
				<th>subjectNo</th>
				<th>subjectName</th>
				<th>subjectTime</th>
				<th>createdate</th>
				<th>updatedate</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		<%
			for (Subject s : list) {
		%>
			<tr>
				<td><%=s.getSubjectNo()%></td>
				<td><%=s.getSubjectName()%></td>
				<td><%=s.getSubjectTime()%></td>
				<td><%=s.getCreatedate()%></td>
				<td><%=s.getUpdatedate()%></td>
				<td><a href="">수정</a></td>
				<td><a href="">삭제</a></td>
			</tr>	
		<%
			}
		%>
		</table>
	</body>
</html>