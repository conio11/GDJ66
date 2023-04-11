<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>answer</title>
		<style>
			table, td {
				border-collapse: collapse;
			}
		</style>
	</head>
	<body>
	<%
		String name = request.getParameter("name");
		String job = request.getParameter("job");
		String ocean = request.getParameter("ocean");
		String ship = request.getParameter("ship");
		String member = request.getParameter("member");
		String fruit = request.getParameter("fruit");
		String power = request.getParameter("power");
		String job_grandpa = request.getParameter("job_grandpa");
		String color = request.getParameter("color");
		String sword = request.getParameter("sword");
		String onepiece = request.getParameter("onepiece");
		
		int sum = 0;
	%>
	
	<table>
	 <tr>
	 	<td>이름: <%=name%></td>
	 </tr>
	 </table>
	
	<%
		if (job.equals("해적")) {
			sum++;
	%>	 
			<div>1. O</div>
	<% 
		} else {
	%>		
			<div>1. X</div>		
	<% } %>	
	
	
	<%
		if (ocean.equals("이스트 블루")) {
			sum++;
	%>	 
			<div>2. O</div>
	<% 
		} else {
	%>		
			<div>2. X</div>	
	<% } %>	
	
	<%
		if (ship.equals("사우전드 써니")) {
			sum++;
	%>	 
			<div>3. O</div>
	<% 
		} else {
	%>		
			<div>3. X</div>	
	<% } %>	
	
	<%
		if (member.equals("10명")) {
			sum++;
	%>	 
			<div>4. O</div>
	<% 
		} else {
	%>		
			<div>4. X</div>	
	<% } %>	
	
	<%
		if (fruit.equals("개발개발열매")) {
			sum++;
	%>	 
			<div>5. O</div>
	<% 
		} else {
	%>		
			<div>5. X</div>	
	<% } %>	
	
	<%
		if (power.equals("상디")) {
			sum++;
	%>	 
			<div>6. O</div>
	<% 
		} else {
	%>		
			<div>6. X</div>	
	<% } %>	
	
	<%
		if (job_grandpa.equals("군인")) {
			sum++;
	%>	 
			<div>7. O</div>
	<% 
		} else {
	%>		
			<div>7. X</div>	
	<% } %>	
	
	<%
		if (color.equals("#000000")) {
			sum++;
	%>	 
			<div>8. O</div>
	<% 
		} else {
	%>		
			<div>8. X</div>	
	<% } %>	
	
	<%
		if (sword.equals("3개")) {
			sum++;
	%>	 
			<div>9. O</div>
	<% 
		} else {
	%>		
			<div>9. X</div>	
	<% } %>	
	
	<%
		if (onepiece.equals("보물")) {
			sum++;
	%>	 
			<div>10. O</div>
	<% 
		} else {
	%>		
			<div>10. X</div>	
	<% } %>	
	
	<%
		sum = 10 * sum;
	%>
		<table>
			<tr>
				<td>
					점수: <%=sum%>
				</td>
			</tr>
		</table>
	
	<!-- 
	답
	1-> 4
	2-> 4
	3-> 2
	4-> 1
	5-> 2
	6-> 4
	7-> 3
	8-> 2
	9-> 3
	10-> 4
	 -->
	
	</body>
</html>