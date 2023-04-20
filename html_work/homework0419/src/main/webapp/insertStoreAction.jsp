<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement" %>
<!-- ResultSet 사용 X, 쿼리문의 결과를 해당 화면에서 출력하지 않음 -->

<%
	// Validation (요청 파라미터값 유효성 검사)
	
	// post 방식 인코딩 처리
	request.setCharacterEncoding("UTF-8");

	// 한 개의 값이라도 공백이거나 null이면 넘어가지 않고 insertStoreForm.jsp 다시 실행
	if (request.getParameter("storeName") == null
		|| request.getParameter("storeCategory") == null
		|| request.getParameter("storeAddress") == null
		|| request.getParameter("storeEmpCnt") == null
		|| request.getParameter("storeBegin") == null
		|| request.getParameter("storeName").equals("") 
		|| request.getParameter("storeCategory").equals("") 
		|| request.getParameter("storeAddress").equals("") 
		|| request.getParameter("storeEmpCnt").equals("") 
		|| request.getParameter("storeBegin").equals("")) {
		response.sendRedirect("./insertStoreForm.jsp");
		return; // 종료 // 없을 시 오류 발생
	}
	
	String storeName = request.getParameter("storeName");
	String storeCategory = request.getParameter("storeCategory");
	String storeAddress = request.getParameter("storeAddress");
	String storeEmpCnt = request.getParameter("storeEmpCnt");
	String storeBegin = request.getParameter("storeBegin");
	
	// 입력값 확인용 디버깅 코드
	System.out.println("storeName: " + storeName);
	System.out.println("storeCategory: " + storeCategory);
	System.out.println("storeAddress: " + storeAddress);
	System.out.println("storeEmpCnt: " + storeEmpCnt);
	System.out.println("storeBegin: " + storeBegin);
	
	// 입력값 DB 테이블에 입력
	// ? 는 values에 대해서만 사용 가능
	// insert into store(store_name,store_category, store_address, store_emp_cnt, store_begin, createdate, updatedate)
	// values(?, ?, ?, ?, ?, now(), now())
				
	// 드라이버 설정
	Class.forName("org.mariadb.jdbc.Driver");
	// db, 로그인 정보 입력
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419", "root", "java1234");
	// 쿼리문 sql 변수로 설정
	String sql = "insert into store(store_name, store_category, store_address, store_emp_cnt, store_begin, createdate, updatedate) values(?, ?, ?, ?, ?, now(), now())";
	PreparedStatement stmt = conn.prepareStatement(sql);
	// ? 5개 (1 ~ 5)
	stmt.setString(1, storeName); // 첫 번째 ? 에 들어갈 값
	stmt.setString(2, storeCategory);
	stmt.setString(3, storeAddress);
	stmt.setString(4, storeEmpCnt);
	stmt.setString(5, storeBegin);
	System.out.println(stmt + " <-- stmt"); // stmt 내부 쿼리문 확인 디버깅 코드
	
	int row = stmt.executeUpdate(); // 0이면 입력된 행 X, 1이면 1행 입력 성공, 2이면 2행 입력 성공 
	System.out.println(row + " <-- row"); // 디버깅 코드 -> row 값 확인
	
	conn.setAutoCommit(true); // 디폴트 값이 true이므로 executeUpdate(); 후 커밋 자동실행
	// conn.commit(); // 커밋 자동실행 설정되어 있으므로 생략 가능

	response.sendRedirect("./storeList.jsp"); // 데이터 입력 후 storeList.jsp 페이지로 리다이렉트(연결) // 마지막에 작성
%>