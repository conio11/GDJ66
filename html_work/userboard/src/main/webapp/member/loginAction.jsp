<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="vo.*"%>
<%
	// 세션 유효성 확인 -> 요청값 유효성 확인
	
	// 세션 유효성 확인
	if (session.getAttribute("loginMemberID") != null) { 
		response.sendRedirect(request.getContextPath()+ "/home2.jsp");
		return; // 실행 종료
	}
	
	// 요청값 유효성 확인
	String memberID = request.getParameter("memberID");
	String memberPW = request.getParameter("memberPW");
	
	// 디버깅
	System.out.println(memberID + " <-- memberID(loginAction)");
	System.out.println(memberPW + " <-- memberPW(loginAction)");
	
	// 요청값을 Member 클래스에 정리
	Member paramMember = new Member();
	paramMember.setMemberID(memberID);
	paramMember.setMemberPW(memberPW);
	
	// DB 연결
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/userboard";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(loginAction)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(loginAction)");
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT member_id memberID FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, paramMember.getMemberID());
	stmt.setString(2, paramMember.getMemberPW());
	System.out.println(stmt + " <-- stmt(loginAction)");
	rs = stmt.executeQuery();
	if (rs.next()) { // 로그인 성공
		// 세션에 로그인 정보(memberID) 저장
		session.setAttribute("loginMemberID", rs.getString("memberID"));
		System.out.println("로그인 성공 세션 정보 : " + session.getAttribute("loginMemberID"));
	} else { // 로그인 실패
		System.out.println("로그인 실패");
	}
	response.sendRedirect(request.getContextPath()+ "/home2.jsp");
	
	System.out.println("==============================");
%>