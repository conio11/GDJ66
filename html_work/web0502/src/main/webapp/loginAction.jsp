<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<% 
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	// 아이디, 비밀번호 디버깅
	System.out.println(id + " <-- id(loginAction)");
	System.out.println(pw + " <-- pw(loginAction)");
	
	// DB 접근 후 멤버 테이블에 입력한 id와 pw가 일치하는 행이 있는 경우 로그인 성공, 없으면 실패 (해당 파일에서는 DB 사용 X)
	// SELECT * FROM member WHERE id=? and pw=?
			
	// 아이디, 비밀번호를 상수로 지정		
	final String tableID = "admin";
	final String tablePW = "1234";
	
	if (tableID.equals(id) && tablePW.equals(pw)) { // loginForm.jsp에서 넘어온 아이디와 비밀번호가 모두 일치하면
		System.out.println("로그인 성공(loginAction)"); // 디버깅
		session.setAttribute("loginID", id); // 로그인 성공 정보(사용자 ID만)를 세션에 저장
		response.sendRedirect(request.getContextPath() + "/home.jsp"); // home.jsp로 이동
	} else {
		System.out.println("로그인 실패");
		String msg = URLEncoder.encode("ID와 PW 다시 입력", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?msg=" + msg); // 오류 메시지와 함께 로그인 폼으로 리다이렉트
	}
	
	System.out.println("=========================");
%>