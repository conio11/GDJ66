<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
 	request.setCharacterEncoding("UTF-8"); /* 전달값 있을 경우 사용 */
 	int dan = Integer.parseInt(request.getParameter("dan"));
 %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>guguAction.jsp</title>
		<style>
			table, td {border-collapse: collapse;}
		</style>
	</head>
	<body>
		<table border="1">
			<tr>
	<%
		for (int i = 1; i <= 9; i = i + 1) {
	%>			
				</tr>
					<td><%=dan%> * <%=i%> = <%=dan * i%></td>
				<tr>
	<%
		}
	%>
			</tr>
		</table>
	</body>
</html>