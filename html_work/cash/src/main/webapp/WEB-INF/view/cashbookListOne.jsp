<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> <!-- JSP 컴파일 시 자바 코드로 변환되는 c: ... (제어 문법) 커스텀 태그  -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> <!-- JSTL substring() 호출 -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cashbookListOne</title>
	</head>
	<body>
		<h1>${targetYear}년 ${targetMonth + 1}월 ${targetDate}일 가계부</h1>
		
		<table border="1">
			<tr>
				<th>카테고리</th>
				<th>금액</th>
				<th>메모</th>
				<th>작성일자</th>
			</tr>
		<c:forEach var="c" items="${list}">
			<tr>
				<td>${c.category}</td>	
				<td>${c.price}</td>
				<td>${c.memo}</td>	
				<td>${fn:substring(c.createdate, 0, 10)}</td>			
			</tr>
		</c:forEach>
		</table>
	</body>
</html>