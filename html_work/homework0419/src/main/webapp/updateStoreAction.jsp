<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%-- <%@ page import="java.sql.ResultSet"%> 해당 페이지 내에서 출력값 없음--%>

<%
	// 인코딩 처리
	request.setCharacterEncoding("UTF-8");
	
	// 유효성 확인 코드
	// no, address, pw, name, category, emp_cnt에 null값이나 공백값 있으면 전체 리스트 페이지로 리다이렉트
	if (request.getParameter("storeNo") == null
	|| request.getParameter("storeAddress") == null
	|| request.getParameter("storePw") == null
	|| request.getParameter("storeName") == null
	|| request.getParameter("storeCategory") == null
	|| request.getParameter("storeEmpCnt") == null
	|| request.getParameter("storeNo").equals("")
	|| request.getParameter("storeAddress").equals("")
	|| request.getParameter("storePw").equals("")
	|| request.getParameter("storeName").equals("")
	|| request.getParameter("storeCategory").equals("")
	|| request.getParameter("storeEmpCnt").equals("")) {
		
		response.sendRedirect("storeList.jsp");
		return; // 리다이렉트 후 실행 종료
	}
	
	int storeNo = Integer.parseInt(request.getParameter("storeNo"));
	String storePw = request.getParameter("storePw");
	String storeAddress = request.getParameter("storeAddress");
	String storeName = request.getParameter("storeName");
	String storeCategory = request.getParameter("storeCategory");
	String storeEmpCnt = request.getParameter("storeEmpCnt");
	
	// 입력값(form에서 넘겨받은 값) 디버깅 코드
	System.out.println(storeNo + "updateAction storeNo");
	System.out.println(storeAddress + "updateAction Address");
	System.out.println(storePw + "updateAction storePw");
	System.out.println(storeName + "updateAction storeName");
	System.out.println(storeCategory + "updateAction storeCategory");
	System.out.println(storeEmpCnt + "updateAction storeEmpCnt");
	
	// 수정된 값 DB 테이블에 입력 (update 구문 사용)
	// update store set store_name=?, store_category=?, store_emp_cnt=? where store_no=? and store_pw=?	
	
	// 드라이버 설정
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("updateAction 드라이버 확인");
	
	// DB, 로그인 정보 입력
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419", "root", "java1234");
	System.out.println(conn + " <-- updateAction DB 연결");
	
	// SQL 구문 작성 및 변환
	String sql = "update store set store_name=?, store_address=?, store_category=?, store_emp_cnt=? where store_no=? and store_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	System.out.println(stmt + " <-- stmt1");
	
	// ? 6개 처리 (1 ~ 6)		
	stmt.setString(1, storeName);		// 첫 번째 ?
	stmt.setString(2, storeAddress);		// 두 번째 ?
	stmt.setString(3, storeCategory);   // 세 번째 ?
	stmt.setString(4, storeEmpCnt);		// 네 번째 ?
	stmt.setInt(5, storeNo);    	 	// 다섯 번째 ?
	stmt.setString(6, storePw);			// 여섯 번째 ?
	System.out.println(stmt + " <-- stmt2");
	
	int row = stmt.executeUpdate(); // 0: 입력 실패, 1: 입력 성공
	System.out.println(row + " <-- row"); // row 값 확인
	
	if (row == 0) { // 수정 실패했을 때 
		response.sendRedirect("./updateNoticeForm.jsp?=storeNo" + storeNo);
	} else { // 수정 성공했을 때 상세 페이지로 이동
		response.sendRedirect("./storeOne.jsp?storeNo=" + storeNo);
	}
%>