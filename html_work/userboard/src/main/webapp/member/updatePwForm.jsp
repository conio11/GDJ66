<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%> 
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>

<%
 	// 회원정보(비밀번호) 수정 폼
 	// 비밀번호만 변경 가능
  	
	// 인코딩 설정
	response.setCharacterEncoding("UTF-8");
	
	// 세션 유효성 확인 -> 요청값 유효성 확인
	
	// 세션 유효성 확인: 로그인 상태가 아닌 경우 home2.jsp로 이동
	// 로그인된 상태에서만 '회원정보'를 볼 수 있는 상태이므로 없어도 되는 부분인지?
	if (session.getAttribute("loginMemberID") == null) { 
		response.sendRedirect(request.getContextPath() + "/home2.jsp"); 
		return;
	} 
	String loginMemberID = (String) session.getAttribute("loginMemberID");
	System.out.println(loginMemberID + " <-- loginMemberID(updateMemberInfoForm)");
	
	// DB 연결
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/userboard";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(updateMemberInfoForm)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(updateMemberInfoForm)");
	
	// member_id, createdate, updatedate 를 가져오기 위한 쿼리 작성
	// SELECT member_id memberID, createdate, updatedate FROM member WHERE member_id=?
	String memberSql = "SELECT member_id memberID, member_pw memberPW, createdate, updatedate FROM member WHERE member_id=?";
	PreparedStatement memberStmt = conn.prepareStatement(memberSql);
	memberStmt.setString(1, loginMemberID);
	System.out.println(memberStmt + " <-- memberStmt(updateMemberInfoForm)");
	
	ResultSet memberRs = memberStmt.executeQuery();
	Member member = null;
	if (memberRs.next()) {
		member = new Member();
		member.setMemberID(memberRs.getString("memberID"));
		member.setMemberPW(memberRs.getString("memberPW"));
		member.setCreatedate(memberRs.getString("createdate"));
		member.setUpdatedate(memberRs.getString("updatedate"));
	}
	System.out.println(member + " <-- member(updateMemberInfoForm)");
	
	System.out.println("=============================");
%>
    
    
    
    
    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updatePwForm</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div>
			<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
		</div>
		<div class="container mt-3 d-flex justify-content-center">
			<h1>비밀번호 수정</h1>
		</div>
		<table>
			<tr>
				<th>memberID</th>
				<td><%=member.getMemberID()%></td>
			</tr>
			<tr>
				<th>memberPW</th>
				<td><%=member.getMemberPW()%></td>
			</tr>
			<tr>
				<th>createdate</th>
				<td><%=member.getCreatedate()%></td>
			</tr>
			<tr>
				<th>updatedate</th>
				<td><%=member.getUpdatedate()%></td>
			</tr>
			
		</table>
	</body>
</html>