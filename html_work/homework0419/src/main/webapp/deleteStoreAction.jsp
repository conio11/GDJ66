<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>    

<%	
	// 맛집 기본 번호, 직원 수 중 null값이나 공백이 있을 경우 초기 화면으로 리다이렉트
	if (request.getParameter("storeNo") == null
	|| request.getParameter("storeEmpCnt") == null
	|| request.getParameter("storeNo").equals("")
	|| request.getParameter("storeEmpCnt").equals("")) {
		response.sendRedirect("./storeList.jsp");
		return; // 실행 종료 // 이 파일의 아래 구문 실행하지 않음
	}

	int storeNo = Integer.parseInt(request.getParameter("storeNo"));
	int storeEmpCnt = Integer.parseInt(request.getParameter("storeEmpCnt"));
	
	// 디버깅 코드 -> 입력된 storeNo, storeEmpCnt 확인
	System.out.println(storeNo + " <-- storeNo");
	System.out.println(storeEmpCnt + " <-- storeEmpCnt");
	
	// 데이터 삭제하는 쿼리문
	// delete from store where store_no=? and store_emp_cnt=?
			
	// 드라이버 설정
	Class.forName("org.mariadb.jdbc.Driver");
	// db, 로그인 정보 입력
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419", "root", "java1234");
	// 긴 쿼리문은 sql 변수로 설정
	// 쿼리 실행
	String sql = "delete from store where store_no=? and store_emp_cnt=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	// ? 2개 (1, 2)
	stmt.setInt(1, storeNo);
	stmt.setInt(2, storeEmpCnt);
	System.out.println(stmt + " <-- deleteStoreAction sql"); // 쿼리 출력
	
	int row = stmt.executeUpdate(); // 삭제 완료된 행 수 
	System.out.println(row + " <-- row");
	
	if (row == 0) { // 직원 수 틀려서 삭제행 0 // 삭제 실패 -> 이전 폼으로 리다이렉트
		response.sendRedirect("./deleteStoreForm.jsp?storeNo=" + storeNo);
	} else {
		response.sendRedirect("./storeList.jsp"); // 삭제 후 초기 화면으로 이동
	}
%>