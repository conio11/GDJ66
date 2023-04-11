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
		text-align: center;
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
	
	String ox1;
	String ox2;
	String ox3;
	String ox4;
	String ox5;
	String ox6;
	String ox7;
	String ox8;
	String ox9;
	String ox10;

	if (job.equals("해적")) {
		sum++;
		ox1 = "O";
	} else {
		ox1 = "X";	
  	} 

	if (ocean.equals("이스트 블루")) {
		sum++;
		ox2 = "O";
	} else {
		ox2 = "X";
	}
		
	if (ship.equals("사우전드 써니")) {
		sum++;
		ox3 = "O";
	} else {
		ox3 = "X";
	} 

	if (member.equals("10명")) {
		sum++;
		ox4 = "O";
	} else {
		ox4 = "X";
	} 	

	if (fruit.equals("개발개발열매")) {
		sum++;
		ox5 = "O";
	} else {
		ox5 = "X";
	}

	if (power.equals("상디")) {
		sum++;
		ox6 = "O";
	
	} else {
		ox6 = "";
	} 

	if (job_grandpa.equals("군인")) {
		sum++;
		ox7 = "O";
	} else {
		ox7 = "X";
	} 
	
	if (color.equals("#000000")) {
		sum++;
		ox8 = "O";
	} else {
		ox8 = "X";
	} 

	if (sword.equals("3개")) {
		sum++;
		ox9 = "O";
	} else {
		ox9 = "X";
	} 

	if (onepiece.equals("보물")) {
		sum++;
		ox10 = "O";
	} else {
		ox10 = "X";
 	} 	
	
	sum = 10 * sum;
%>
	<table border="1">
		<tr>
			<th colspan="2">이름: <%=name%></th>
			<!-- <td></td> -->
			<th colspan="2">점수: <%=sum%></th>
			<!-- <td></td> -->
		</tr>
		<tr>
			<td>1번</td>
			<td><%=ox1%></td>
			<td>6번</td>
			<td><%=ox6%></td>
		</tr>
			<tr>
			<td>2번</td>
			<td><%=ox2%></td>
			<td>7번</td>
			<td><%=ox7%></td>
		</tr>
			<tr>
			<td>3번</td>
			<td><%=ox3%></td>
			<td>8번</td>
			<td><%=ox4%></td>
		</tr>
		<tr>
			<td>4번</td>
			<td><%=ox4%></td>
			<td>9번</td>
			<td><%=ox9%></td>
		</tr>
			<tr>
			<td>5번</td>
			<td><%=ox5%></td>
			<td>10번</td>
			<td><%=ox10%></td>
		</tr>
	</table>
</body>
</html>