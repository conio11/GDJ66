<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*" %> 
<%
	// 지역정보(지역명) 수정 폼
	
	// 인코딩 설정
	response.setCharacterEncoding("UTF-8");

	// 세션 유효성 확인: 세션 없는 경우(로그인 상태가 아닌 경우) home2.jsp로 이동
	String msg = "";
	if (session.getAttribute("loginMemberID") == null) {
		msg = URLEncoder.encode("잘못된 접근입니다. 로그인 후 이용하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/home2.jsp");
		return;
	}
	String loginMemberID = (String) session.getAttribute("loginMemberID");
	System.out.println(loginMemberID + " <-- loginMemberID(updateLocalForm)");
	
	// 요청값 유효성 확인
	// localName 값이 넘어오지 않을 경우 폼 이동(현재 화면 새로고침)
	if (request.getParameter("localName") == null
	|| request.getParameter("localName").equals("")) {
		response.sendRedirect(request.getContextPath() + "/local/updateLocalForm.jsp");
		return;
	}
	String localName = request.getParameter("localName");
	System.out.println(localName + " <-- localName(updateLocalForm)");
	
	// DB 연결
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/userboard";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(updateLocalForm)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(updateLocalForm)");
	
	// local_name 가져오기 위한 쿼리 작성
	// SELECT local_name localName FROM local WHERE local_name=?
	String localSql = "SELECT local_name localName FROM local WHERE local_name=?";
	PreparedStatement localStmt = conn.prepareStatement(localSql);
	localStmt.setString(1, localName);
	System.out.println(localStmt + " <-- localStmt(updateLocalForm)");

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateLocalForm</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div>
			<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
		</div>
		<br>
		<div class="text-center">
			<h1>지역이름 수정</h1>
		</div>
		<%
			if (request.getParameter("msg") != null) {	
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
		<form action="<%=request.getContextPath()%>/local/updateLocalAction.jsp" method="post">
			<table class="table table-bordered">
				<tr>
					<th class="table-primary text-center">현재 지역명</th>
					<td><input type="hidden" name="oldLocalName" value="<%=localName%>"></td>
				</tr>
				<tr>
					<th class="table-primary text-center">새 지역명</th>
					<td><input type="text" name="localName"></td>
				</tr>
			
			</table>
		</form>
	</body>
</html>