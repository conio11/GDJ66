<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	// 1. request 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 2. 4개의 값을 확인(디버깅)
	System.out.println(request.getParameter("noticeNo") + " <-- updateNoticeAction2.jsp param noticeNo");
    System.out.println(request.getParameter("noticeTitle") + " <-- updateNoticeAction2.jsp param noticeTitle");
    System.out.println(request.getParameter("noticeContent") + " <-- updateNoticeAction2.jsp param noticeContent");
    System.out.println(request.getParameter("noticePw") + " <-- updateNoticeAction2.jsp param noticePw");
 
    // 3. 2번 유효성 검정 -> 잘못된 결과 -> 분기 -> 리다이렉션 (액션을 요청한 웹브라우저-form에게 다른 곳을 요청하도록 안내) -> 코드진행종료 (return)
    // -> updateNoticeForm.jsp?noticeNo=&msg=)
	if (request.getParameter("noticeNo") == null) { // noticeNo에 값이 없으면 전체 리스트 출력
		response.sendRedirect("./noticeList2.jsp");
	}

	String msg = null;

	if (request.getParameter("noticeTitle") == null // or 연산자는 앞의 연산 먼저 실행
	|| request.getParameter("noticeTitle").equals("")) {
		msg = "noticeTitle is required";	
	} else if (request.getParameter("noticeContent") == null 
	|| request.getParameter("noticeContent").equals("")) {
		msg = "noticeContent is required";
	} else if (request.getParameter("noticePw") == null 
	|| request.getParameter("noticePw").equals("")) {
		msg = "noticePw is required";
	}
		
	if (msg != null) { // 위 if-else 문에 하나라도 해당될 경우
		response.sendRedirect("./updateNoticeForm.jsp?noticeNo=" + request.getParameter("noticeNo") + "&msg=" + msg);
		return;
	}
	
	// 4. 요청값 변수에 할당 (형변환 포함)
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	String noticePw = request.getParameter("noticePw");
	
	// 변수 확인
	System.out.println(noticeNo + " <-- updateAction2 noticeNo");
	System.out.println(noticeTitle + " <-- updateAction2 noticeTitle");
	System.out.println(noticeContent + " <-- updateAction2 noticeContent");
	System.out.println(noticePw + " <-- updateAction2 noticePw");
	
	// 5. MariaDB RDBMS에 update 문을 전송
	// 드라이버 연결 확인
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("updateForm 드라이버 연결");
	
	// DB 연결 확인
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	System.out.println(conn + " <-- updateForm DB 연결");
	
	// SQL 구문 작성 및 변환
	String sql = "update notice set notice_title=?, notice_content=?, updatedate=now() where notice_no=? and notice_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, noticeNo); // stmt의 첫 번째 ? -> noticeNo로 바뀜 // notice_no가 int 타입이므로 setInt() 사용
	System.out.println(stmt + " <-- updateAction 2stmt");
	
	stmt.setString(1, noticeTitle);   // 첫 번째 ? 에 들어갈 값: noticeTitle
	stmt.setString(2, noticeContent); // 두 번째 ? 에 들어갈 값 : noticeContent
	stmt.setInt(3, noticeNo);		  // 세 번째 ? 에 들어갈 값 : noticeNo
	stmt.setString(4, noticePw); 	  // 네 번째 ? 에 들어갈 값 : noticePw
	System.out.println(stmt + " <-- updateAction2 stmt2");
	
	int row = stmt.executeUpdate(); // 적용된 행의 수
	
	// 6. 위 결과에 페이지(view)를 분기
	if (row == 0) {
		response.sendRedirect("./updateNoticeForm.jsp?noticeNo=" + request.getParameter("noticeNo") + "&msg=incorrect noticePw");
	} else if (row == 1) {
		response.sendRedirect("noticeOne.jsp?noticeNo=" + noticeNo);
	} else {
		// update 문 실행 취소 (rollback)해야
		System.out.println("error row값: " + row);
	}
%>