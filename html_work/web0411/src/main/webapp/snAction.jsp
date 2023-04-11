<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>snAction</title>
</head>
<body>
<%
	//요청값 (parameter value) 처리	
	String name = request.getParameter("name");

	String year = request.getParameter("year");
	int numYear  = Integer.parseInt(year);
	
	String sn7 = request.getParameter("sn7");
	int s = Integer.parseInt(sn7); 
	// int sn7 = Integer.parseInt(request.getParameter("sn7")); // 한번에 구현 가능
	
	int currentYear = 2023; 
	int age = currentYear - numYear + 1;
	
	String gender = null;
	
	if (age >= 20) {
		out.println(name + "님(" + age + ")은 성인입니다");
	} else {
		out.println(name + "님(" + age + ")은 미성년자입니다");
	}
	
	if (s % 2 == 0) {
		gender = "여";
	} else {
		gender = "남";
	}
%>	
	<div><%=name%>님(<%=age%>)은 <%=gender%>성입니다</div>

</body>
		<!-- 
		XXX님(21)은 성인입니다
		XXX님(17)은 미성년자입니다
		XXX님(17)은 남성입니다
		 -->
</html>