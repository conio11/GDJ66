<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%> 
<%@ page import="java.util.*" %>   
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<h1>샘플목록</h1>
		<table border="1">
			<tr>
				<th>x</th>
				<th>y</th>
			</tr>
			<%
				List<Sample> list = new SampleDao().selectSampleAll();
				for (Sample s : list) {
			%>
			
			<tr>	
				<td><%=s.getX()%></td>
				<td><%=s.getY()%></td>
			
			</tr>
			
			<%
				}	
			%>
		</table>
	</body>
</html>