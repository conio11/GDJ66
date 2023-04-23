<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	
	// pracNo 값 넘어오지 않으면 pracList로 리다이렉트
	// 요청값 유효성 검사
	if (request.getParameter("pracNo") == null) {
		response.sendRedirect("./pracList.jsp");
		return; // 실행 종료
	}
	
	int pracNo = Integer.parseInt(request.getParameter("pracNo"));
	System.out.println(pracNo + " <-- pracNo(delete)");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>deletePracForm</title>
	</head>
	<body>
		<h1>데이터 삭제</h1>
		<form action="deletePracAction.jsp" method="post">
			<table border="1">
				<tr>
					<td>prac_no</td>
					<td>
						<input type="text" name="pracNo" value="<%=pracNo%>" readonly="readonly">
					</td>	
				</tr>
				<tr>
					<td>prac_pw</td>
					<td>
						<input type="password" name="pracPw">
					</td>
				</tr>
			
			</table>
			<div>
				<button type="submit">삭제</button>
			</div>
		</form>
	</body>
</html>