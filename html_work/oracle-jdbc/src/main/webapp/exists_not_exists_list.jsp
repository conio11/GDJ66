<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
/*
select 번호, 사원ID, 이름
from
	(select rownum 번호, e.employee_id 사원ID, e.first_name 이름
		from employees e 
		where exists (select * from departments d where d.department_id = e.department_id))
where 번호 between ? and ?
*/

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>