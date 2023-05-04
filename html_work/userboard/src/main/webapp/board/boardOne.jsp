<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>    
<%@ page import="vo.*"%>

<%
	// 인코딩 설정
	response.setCharacterEncoding("UTF-8");
	
	// 1. 컨트롤러 계층
	// request값 확인
	// boardNo 값 넘어오지 않았을 경우 home2.jsp로 이동
	if (request.getParameter("boardNo") == null 
	|| request.getParameter("boardNo").equals("")) {
		response.sendRedirect(request.getContextPath()+ "/home2.jsp");
		return; // 실행 종료
	}
		
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int currentPage = 1;
	int rowPerPage = 10;
	int startRow = 0;
	System.out.println(boardNo + " <-- boardNo(boardOne)");
	
	// 2. 모델 계층
	// DB 연결
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/userboard";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(boardOne)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(boardOne)");
	
	// 2 - 1) boardOne 결과셋
	// 상세정보 쿼리
	// SELECT board_no boardNo, local_name localName, board_title boardTitle, board_content boardContent, member_id memberID, createdate, updatedate
	// FROM board WHERE board_no=?
	String boardSql = "SELECT board_no boardNo, local_name localName, board_title boardTitle, board_content boardContent, member_id memberID, createdate, updatedate FROM board WHERE board_no=?";
	PreparedStatement boardStmt = conn.prepareStatement(boardSql);
	boardStmt.setInt(1, boardNo); // ? 에 boardNo 저장	
	System.out.println(boardStmt + " <-- stmt(boardOne)");
	ResultSet boardRs = boardStmt.executeQuery(); // row -> 1 -> Board 타입
	
	Board board = null; 
	if (boardRs.next()) {
		board = new Board();
		board.boardNo = boardRs.getInt("boardNo");
		board.localName = boardRs.getString("localName");
		board.boardTitle = boardRs.getString("boardTitle");
		board.boardContent = boardRs.getString("boardContent");
		board.memberID = boardRs.getString("memberID");
		board.createdate = boardRs.getString("createdate");
		board.updatedate = boardRs.getString("updatedate");
	}
	System.out.println(board + " <-- board(boardOne)");
	
	// 2 - 2) commentList 결과셋
	// comment list 결과셋
	// SELECT comment_no, board_no, comment_content FROM COMMENT
	// WHERE board_no=? LIMIT ?, ?;
	String commentSql = "SELECT comment_no commentNo, member_id memberID, board_no boardNo, comment_content commentContent, createdate, updatedate FROM COMMENT WHERE board_no=? LIMIT ?, ?";
	PreparedStatement commentListStmt = conn.prepareStatement(commentSql);
	commentListStmt.setInt(1, boardNo);
	commentListStmt.setInt(2, startRow);
	commentListStmt.setInt(3, rowPerPage);
	ResultSet commentListRs = commentListStmt.executeQuery(); // row -> 최대 10 -> ArrayList<Comment>
	ArrayList<Comment> commentList = new ArrayList<Comment>();
	while(commentListRs.next()) {
		Comment c = new Comment();
		c.commentNo = commentListRs.getInt("commentNo");
		c.boardNo = commentListRs.getInt("boardNo");
		c.memberID = commentListRs.getString("memberID");
		c.commentContent = commentListRs.getString("commentContent");
		c.createdate = commentListRs.getString("createdate");
		c.updatedate = commentListRs.getString("updatedate");
		commentList.add(c);
	}
	
	System.out.println("====================================");
	
	// 3. 뷰 계층
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>boardOne</title>
	</head>
	<body>
		<!-- 메인 메뉴(가로) -->
		<div>
			<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
		</div>

		<h1>상세 페이지</h1>
		<!-- boardOne 결과셋  -->
		<table border="1">
			<tr>
				<th>boardNo</th>
				<td><%=board.boardNo%><td>
			</tr>
			<tr>
				<th>localName</th>
				<td><%=board.localName%><td>
			</tr>
			<tr>
				<th>boardTitle</th>
				<td><%=board.boardTitle%><td>
			</tr>
			<tr>
				<th>boardContent</th>
				<td><%=board.boardContent%><td>
			</tr>
			<tr>
				<th>memberID</th>
				<td><%=board.memberID%><td>
			</tr>
			<tr>
				<th>createdate</th>
				<td><%=board.createdate%><td>
			</tr>
			<tr>
				<th>updatedate</th>
				<td><%=board.updatedate%><td>
			</tr>
		</table>
		
		<!-- 3-2) comment(댓글) 입력 : 세션유무에 따른 분기 -->
		<!-- comment 입력: 세션 유무 확인  -->
		<h2>댓글</h2>
		<%
			// 로그인한 사용자만 댓글 입력 허용
			if (session.getAttribute("loginMemberID") != null) {
				// 현재 로그인한 사용자의 ID
				String loginMemberID = (String) session.getAttribute("loginMemberID");
		%>
				<form action="<%=request.getContextPath()%>/board/insertCommentAction.jsp" method="post">
					<input type="hidden" name="boardNo" value="<%=board.boardNo%>">
					<input type="text" name="memberID" value="<%=loginMemberID%>" readonly="readonly">
					<table border="1">
						<tr>
				<%-- 			<th>boardNo</th>
							<td>
								<input type="text" name="boardNo" value="<%=board.boardNo%>" readonly="readonly">
							</td> --%>
							<th>commentContent</th>
							<td>
								<textarea rows="2" cols="80" name="commentContent"></textarea>
							</td>
						</tr>	
					</table>
					<button type="submit">댓글 입력</button>
				</form>
		<%
			}
		%>
				
		<!-- comment list 결과셋  -->
		<!-- 댓글 출력 -->
		<table border="1">
			<tr>
				<th>memberID</th>
				<th>commentContent</th>
				<th>createdate</th>
				<th>updatedate</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		<%
			for (Comment c : commentList) {
		%>	
			<tr>	
				<td><%=c.memberID%></td>
				<td><%=c.commentContent%></td>
				<td><%=c.createdate%></td>
				<td><%=c.updatedate%></td>
				<td></td>
				<td></td>
			</tr>
		<% 		
			}
		%>
		</table>
		
		<%
			// 로그인된 상태이면
			if (session.getAttribute("loginMemberID") != null) {
		%>
			<div>
				<a href="">수정</a>
				<a href="">삭제</a>
			</div>
		<%		
			}
		%>
			<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=boardNo%>&currentPage=<%=currentPage - 1%>">이전</a>
			<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=boardNo%>&currentPage=<%=currentPage + 1%>">다음</a>
			
		<div>
			<!-- include 페이지 : Copyright &copy; 구디아카데미 -->
			<jsp:include page="/inc/copyright.jsp"></jsp:include>
		</div>	
	</body>
</html>