<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>    
<%@ page import="vo.*"%>

<%
	// 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// 1. 컨트롤러 계층
	// request값 확인
	// boardNo 값 넘어오지 않았을 경우 home2.jsp로 이동
	if (request.getParameter("boardNo") == null 
	|| request.getParameter("boardNo").equals("")) {
		response.sendRedirect(request.getContextPath()+ "/home2.jsp");
		return; // 실행 종료
	}
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	System.out.println(boardNo + " <-- boardNo(boardOne)");
	
/*  int currentPage = 1;
	if (request.getParameter("currentPage") != null && !request.getParameter("currentPage").equals("")) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + " <-- currentPage(boardOne)");  */
	
	int rowPerPage = 10;
	int startRow = 0;
	
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
	System.out.println(boardStmt + " <-- boardStmt(boardOne)");
	ResultSet boardRs = boardStmt.executeQuery(); // row -> 1 -> Board 타입
	
	Board board = null; 
	if (boardRs.next()) {
		board = new Board();
		board.setBoardNo(boardRs.getInt("boardNo"));
		board.setLocalName(boardRs.getString("localName"));
		board.setBoardTitle(boardRs.getString("boardTitle"));
		board.setBoardContent(boardRs.getString("boardContent"));
		board.setMemberID(boardRs.getString("memberID"));
		board.setCreatedate(boardRs.getString("createdate"));
		board.setUpdatedate(boardRs.getString("updatedate"));
	}
	System.out.println(board + " <-- board(boardOne)");
	
	// 2 - 2) commentList 결과셋
	// comment list 결과셋
	// SELECT comment_no, board_no, comment_content FROM COMMENT
	// WHERE board_no=? LIMIT ?, ?;
	String commentListSql = "SELECT comment_no commentNo, member_id memberID, board_no boardNo, comment_content commentContent, createdate, updatedate FROM COMMENT WHERE board_no=? LIMIT ?, ?";
	PreparedStatement commentListStmt = conn.prepareStatement(commentListSql);
	commentListStmt.setInt(1, boardNo);
	commentListStmt.setInt(2, startRow);
	commentListStmt.setInt(3, rowPerPage);
	ResultSet commentListRs = commentListStmt.executeQuery(); // row -> 최대 10 -> ArrayList<Comment>
	ArrayList<Comment> commentList = new ArrayList<Comment>();
	while(commentListRs.next()) {
		Comment c = new Comment();
		c.setCommentNo(commentListRs.getInt("commentNo"));
		c.setBoardNo(commentListRs.getInt("boardNo"));
		c.setMemberID(commentListRs.getString("memberID"));
		c.setCommentContent(commentListRs.getString("commentContent"));
		c.setCreatedate(commentListRs.getString("createdate"));
		c.setUpdatedate(commentListRs.getString("updatedate"));
		commentList.add(c);
	}
	
	// 마지막 페이지
/* 	String lastPageSql = "SELECT COUNT(*) FROM board";
	PreparedStatement lastPageStmt = conn.prepareStatement(lastPageSql);
	ResultSet lastPageRs = lastPageStmt.executeQuery();
	int totalRow = 0;
	while (lastPageRs.next()) {
		totalRow = lastPageRs.getInt("COUNT(*)");
	}
	System.out.println(totalRow + " <-- totalRow(boardOne)");
	
	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	System.out.println(lastPage + " <-- lastPage(boardOne)"); */
	
	// board 페이징 - 첫 페이지, 마지막 페이지
	String startBoardNoSql = "SELECT MIN(board_no) FROM board";
	String lastBoardNoSql = "SELECT MAX(board_no) FROM board";
	PreparedStatement startBoardNoStmt = conn.prepareStatement(startBoardNoSql);
	PreparedStatement lastBoardNoStmt = conn.prepareStatement(lastBoardNoSql);
	ResultSet startBoardNoRs = startBoardNoStmt.executeQuery();
	ResultSet lastBoardNoRs = lastBoardNoStmt.executeQuery();
	int startBoardNo = 0;
	int lastBoardNo = 0;
	if (startBoardNoRs.next()) {
		startBoardNo = startBoardNoRs.getInt("MIN(board_no)");
	}
	if (lastBoardNoRs.next()) {
		lastBoardNo = lastBoardNoRs.getInt("MAX(board_no)");
	}
	System.out.println(startBoardNo + " <-- startBoardNo");
	System.out.println(lastBoardNo + " <-- lastBoardNo");
	
	System.out.println("====================================");
	
	// 3. 뷰 계층
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>boardOne</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<!-- 메인 메뉴(가로) -->
		<div>
			<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
		</div>
		
		<div class="text-center">
			<h1>상세 페이지</h1>
		</div>
		<%
			if (request.getParameter("msg2") != null) {
		%>
				<%=request.getParameter("msg2")%>
		<%
			}
		%>
		
		<!-- boardOne 결과셋  -->
		<table class="table table-bordered">
			<tr>
				<th class="table-primary text-center">boardNo</th>
				<td><%=board.getBoardNo()%><td>
			</tr>
			<tr>
				<th class="table-primary text-center">localName</th>
				<td><%=board.getLocalName()%><td>
			</tr>
			<tr>
				<th class="table-primary text-center">boardTitle</th>
				<td><%=board.getBoardTitle()%><td>
			</tr>
			<tr>
				<th class="table-primary text-center">boardContent</th>
				<td><%=board.getBoardContent()%><td>
			</tr>
			<tr>
				<th class="table-primary text-center">memberID</th>
				<td><%=board.getMemberID()%><td>
			</tr>
			<tr>
				<th class="table-primary text-center">createdate</th>
				<td><%=board.getCreatedate().substring(0, 10)%><td>
			</tr>
			<tr>
				<th class="table-primary text-center">updatedate</th>
				<td><%=board.getUpdatedate().substring(0, 10)%><td>
			</tr>
		</table>
		<div>
			<a href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=board.getBoardNo()%>&localName=<%=board.getLocalName()%>&boardTitle=<%=board.getBoardTitle()%>&boardContent=<%=board.getBoardContent()%>&memberID=<%=board.getMemberID()%>" class="btn btn-outline-primary">게시글 수정</a>
			<a href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%=board.getBoardNo()%>&localName=<%=board.getLocalName()%>&boardTitle=<%=board.getBoardTitle()%>&boardContent=<%=board.getBoardContent()%>&memberID=<%=board.getMemberID()%>" class="btn btn-outline-primary">삭제</a>
		</div>
		
		<br>
		
		<!-- 3-2) comment(댓글) 입력 : 세션유무에 따른 분기 -->
		<!-- comment 입력: 세션 유무 확인  -->
		<div class="text-center">
			<h2>댓글</h2>
		</div>
		
		<%
			if (request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>

		<%
			// 로그인한 사용자만 댓글 입력 허용
			if (session.getAttribute("loginMemberID") != null) {
				// 현재 로그인한 사용자의 ID
				String loginMemberID = (String) session.getAttribute("loginMemberID");
		%>
				<form action="<%=request.getContextPath()%>/board/insertCommentAction.jsp" method="post">
					<input type="hidden" name="boardNo" value="<%=board.getBoardNo()%>">
					<input type="text" name="memberID" value="<%=loginMemberID%>" readonly="readonly">
					<table class="table table-bordered mx-auto">
						<tr>
				<%-- 			<th>boardNo</th>
							<td>
								<input type="text" name="boardNo" value="<%=board.boardNo%>" readonly="readonly">
							</td> --%>
							<th class="table-primary text-center">commentContent</th>
							<td>
								<textarea rows="2" cols="80" name="commentContent"></textarea>
							</td>
						</tr>
					</table>
					<button type="submit" class="btn btn-outline-primary">댓글 입력</button>
				</form>
				<br>
		<%
			}
		%>
				
		<!-- comment list 결과셋  -->
		<!-- 댓글 출력 -->
		<table class="table table-bordered">
			<tr class="table-primary text-center">
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
			<tr class="text-center">	
				<td><%=c.getMemberID()%></td>
				<td><%=c.getCommentContent()%></td>
				<td><%=c.getCreatedate().substring(0, 10)%></td>
				<td><%=c.getUpdatedate().substring(0, 10)%></td>
				<td><a href="<%=request.getContextPath()%>/board/updateCommentForm.jsp?memberID=<%=c.getMemberID()%>&commentContent=<%=c.getCommentContent()%>&commentNo=<%=c.getCommentNo()%>&boardNo=<%=board.getBoardNo()%>" class="btn btn-outline-primary">수정</a></td>
				<td><a href="<%=request.getContextPath()%>/board/deleteCommentForm.jsp?memberID=<%=c.getMemberID()%>&commentContent=<%=c.getCommentContent()%>&commentNo=<%=c.getCommentNo()%>&boardNo=<%=board.getBoardNo()%>" class="btn btn-outline-primary">삭제</a></td>
			</tr>
		<% 		
			}
		%>
		</table>
		
			<br>
		
		<div class="text-center">
		<%
			if (board.getBoardNo() > startBoardNo) { // boardNo의 첫 번째 번호보다 클 때
		%>
				<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=boardNo - 1%>" class="btn btn-outline-primary">이전 글</a>
		<%
			}
		%>

		<%
			if (board.getBoardNo() < lastBoardNo) { // boardNo의 마지막 번호보다 작을 때
		%>
				<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=boardNo + 1%>" class="btn btn-outline-primary">다음 글</a>
		<%
			}
		%>
		</div>	
		<div>
			<!-- include 페이지 : Copyright &copy; 구디아카데미 -->
			<jsp:include page="/inc/copyright.jsp"></jsp:include>
		</div>	
	</body>
</html>