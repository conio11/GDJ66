<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="java.sql.*" %>  
<%@ page import="vo.*" %>    

<%
	// lastEmpList.jsp, lastEmpListNew 복습용 파일
	// MVC 모델
	// Controller Layer - 요청값 처리 계층
	
	// 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// <input> 태그 내 동일한 이름을 가진 value 값 전체 배열 형태로 가져오기
	
	

%>


    
    
    
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>lastempListprac</title>
	</head>
	<body>
		<h1>사원 목록</h1>
		
		<form action="./lastEmpListprac.jsp" method="get">
	
		<%
			int[] months = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
			for (int m : months) {	
		%>
				<input type="checkbox" name="ckMonth" value="<%=m%>"><%=m%>월
		<%
			}
		%>		
			
			<button type="submit">조회</button> <!-- 값 선택하고 조회   -->
		
		</form>
	
	</body>
</html>