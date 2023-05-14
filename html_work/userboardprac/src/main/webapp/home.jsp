<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="vo.*" %>

<%
	// 홈 페이지
	// 회원가입 (회원정보/로그인) 메뉴
	// 전체 메뉴?
	// 로그인 창
	// localName(카테고리명/지역명), boardTitle(게시글 제목), createdate(생성일자)
	// 게시글 리스트 페이징(10페이지)
	
	// 인코딩 설정
	response.setCharacterEncoding("UTF-8");

	// 현재 페이지 설정
	// 넘어오는 값(이전, 다음 버튼 등)이 있을 경우 해당 페이지 번호, 없을 경우 기본 1
	int currentPage = 1;
	if (request.getParameter("currentPage") != null && !request.getParameter("currentPage").equals("")) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));	
	}
	
	// 현재 페이지 디버깅
	System.out.println(currentPage + " <-- currentPage(home)");

	// LIMIT(startRow, rowPerPage)
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * rowPerPage; // currentPage = 1 -> startRow = 0
	
	// 시작 행 디버깅
	System.out.println(startRow + " <-- startRow(home2)");
	
	// 요청 전 localName 파라미터값 확인
	System.out.println(request.getParameter("localName") + " <- param localName(home)");
	String localName = "전체"; // 특정 localName 선택되지 않은 경우 또는 null -> 전체
	if (request.getParameter("localName") != null) {
		localName = request.getParameter("localName");
	}
	
	// 선택된 지역명(카테고리명) 디버깅
	System.out.println(localName + " <-- localName(home)");
	
	// DB 연결
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/userboard";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(home)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(home)");
	
	// 1) 서브메뉴 (전체 행 수/지역별 행 수) 출력
	// 전체 게시글 개수와 지역명(카테고리)별 게시글 개수를 구하는 쿼리
	String subMenuSql = "SELECT '전체' localName, COUNT(local_name) cnt FROM board UNION ALL SELECT local_name, COUNT(local_name) FROM board GROUP BY local_name";
	PreparedStatement subMenuStmt = conn.prepareStatement(subMenuSql);
	ResultSet subMenuRs = subMenuStmt.executeQuery();
	
	// subMenuList -> 모델 데이터
	ArrayList<HashMap<String, Object>> subMenuList = new ArrayList<HashMap<String, Object>>();
	while (subMenuRs.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("localName", subMenuRs.getString("localName"));
		m.put("cnt", subMenuRs.getInt("cnt"));
		subMenuList.add(m);
	}
	
	// 디버깅
	System.out.println(subMenuList + " <-- subMenuList(home)");
	
	// 2) 게시판 목록 결과셋 (모델)
	// localName이 '전체'인 경우, 지역명이 입력된 경우 분기
	String boardSql = "";
	PreparedStatement boardStmt = null;
	ResultSet boardRs = null;
	
	if (localName.equals("전체")) {
		boardSql = "SELECT board_no boardNo, local_name localName, board_title boardTitle, createdate FROM board ORDER BY createdate DESC LIMIT ?, ?";
		boardStmt = conn.prepareStatement(boardSql);
		boardStmt.setInt(1, startRow);
		boardStmt.setInt(2, rowPerPage);
	} else {
		boardSql = "SELECT board_no boardNo, local_name localName, board_title boardTitle, createdate FROM board WHERE local_name=? ORDER BY createdate DESC LIMIT ?, ?";
		boardStmt = conn.prepareStatement(boardSql);
		boardStmt.setString(1, localName);
		boardStmt.setInt(2, startRow);
		boardStmt.setInt(3, rowPerPage);
	}
	
	boardRs = boardStmt.executeQuery(); // DB 쿼리 결과셋 포함
	// boardRs -> boardList 변환
	ArrayList<Board> boardList = new ArrayList<Board>(); // 애플리케이션에서 사용할 모델 (현재 사이즈 0)
	while (boardRs.next()) {
		Board b = new Board();
		b.setBoardNo(boardRs.getInt("boardNo"));
		b.setLocalName(boardRs.getString("localName"));
		b.setBoardTitle(boardRs.getString("boardTitle"));
		b.setCreatedate(boardRs.getString("createdate"));
		boardList.add(b);
	}
	
	// 게시글 리스트, 해당 페이지 게시글 수 디버깅
	System.out.println(boardList + " <--boardList(home)");
	System.out.println(boardList.size() + " <--boardList.size()(home)");
	
	// 3) 마지막 페이지 모델링
	String pageSql = "SELECT COUNT(*) cnt FROM board";
	PreparedStatement pageStmt = conn.prepareStatement(pageSql);
	ResultSet pageRs = pageStmt.executeQuery();
	int totalRow = 0;
	if (pageRs.next()) { 
		totalRow = pageRs.getInt("cnt");
	}
	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	
	// 전체 게시글 수, 마지막 페이지 번호 디버깅
	System.out.println(totalRow + " <-- totalRow(home)");
	System.out.println(lastPage + " <-- lastPage(home)");
	
	System.out.println("========================================");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>home</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div>
			<jsp:include page="/inc/mainmenu.jsp"></jsp:include> <!-- mainmenu.jsp 의 결과를 현재 페이지에서 사용 가능 -->
		</div>
		
		<div> <!-- subMenuList 모델 출력  -->
			<ul>
				<%
					for (HashMap<String, Object> m : subMenuList) {
				%>
					<li>
						<a href="<%=request.getContextPath()%>/home.jsp?localName=<%=(String)m.get("localName")%>" class="btn">
							<%=(String)m.get("localName")%>(<%=(Integer)m.get("cnt")%>)
						</a>
					</li>
				<%
					}
				%>
			</ul>
		</div>
		
		<div>
			<!-- 로그인 폼  -->
		<%
			if (session.getAttribute("loginMemberID") == null) { // 로그인 상태가 아닌 경우만 로그인 폼 출력
		%>
				<form action="<%=request.getContextPath()%>/member/loginAction.jsp" method="post"> 
			<%
				if (request.getParameter("msg") != null) { // 액션 페이지에서 넘어올 때 msg에 값이 있으면 출력
			%>
					<%=request.getParameter("msg")%>
			<%	
				}
			%>
					<table class="table table-bordered">
						<tr>
							<th class="table-warning text-center">아이디</th>
							<td><input type="text" name="memberID"></td>
						</tr>
						<tr>
							<th class="table-warning text-center">패스워드</th>
							<td><input type="password" name="memberPW"></td>
						</tr>
					</table>
					<button type="submit" class="btn btn-outline-warning">로그인</button>
				</form>
				<br>
		<%
			} else { // 로그인된 경우
		%>
				<%=(String) session.getAttribute("loginMemberID")%>님, 반갑습니다.
		<% 		
			}
		%>
		</div>
		
		<table class="table table-bordered text-center">
			<tr class="table-warning">
				<th>카테고리명(지역)</th>
				<th>게시글 제목</th>
				<th>작성일자</th>
			</tr>
			<!-- <c:foreach var="b" items="boardList"></c:foreach> -->
		<%
			for (Board b : boardList) {
		%>
			<tr>
				<td><%=b.getLocalName()%></td> 
				<td>
					<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>" class="btn btn-outline-light text-dark">
						<%=b.getBoardTitle()%>
					</a>
				</td>
				<td ><%=b.getCreatedate().substring(0, 10)%></td>
			</tr>	
		<%
			}
		%>
		</table>
		
		<div class="text-center">
		<%
			if (currentPage > 1) {
		%>
				<a href="./home.jsp?currentPage=<%=currentPage - 1%>&localName=<%=localName%>" class="btn btn-outline-warning">이전</a>
		<%
			}
		%>
				<%=currentPage%>페이지
		<%
			if (currentPage < lastPage) {
		%>
				<a href="./home.jsp?currentPage=<%=currentPage + 1%>&localName=<%=localName%>" class="btn btn-outline-warning">다음</a>
		<%
			}
		%>
		</div>
		
		<div>
			<jsp:include page="/inc/copyright.jsp"></jsp:include>
		</div>
	</body>
</html>