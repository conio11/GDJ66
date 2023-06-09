<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*" %>

<%
	// * 요청분석(컨트롤러 계층) 후 모델 계층 생성
	
	//인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 1)) session - JSP내장(기본) 객체

	// 2)) request / response JSP내장(기본) - 객체
	int currentPage = 1;
	if (request.getParameter("currentPage") != null && !request.getParameter("currentPage").equals("")) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + " <-- currenetPage(home2)");
		
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * rowPerPage;
	System.out.println(startRow + " <-- startRow(home2)");
	
	System.out.println(request.getParameter("localName") + " <- param localName(home2)");
	String localName = "전체";
	if (request.getParameter("localName") != null) {
		localName = request.getParameter("localName");
	}
	System.out.println(localName + " <-- localName(home2)");
	
	//DB 연결
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/userboard";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(home2)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(home2)");
	
	// 1) 서브메뉴 출력 쿼리
	// 전체 행 수, 지역별 행 수 구하는 쿼리
	/*
	SELECT '전체' localName, COUNT(local_name) cnt FROM board
	UNION ALL
	SELECT local_name, COUNT(local_name) FROM board GROUP BY local_name
	*/

	// 전체 개수와 지역명별 컬럼 개수를 구하는 쿼리
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
	System.out.println(subMenuList + " <-- subMenuList(home2)");
	
	// 2) 게시판 목록 결과셋(모델)
	String boardSql = "";
	PreparedStatement boardStmt = null;
	ResultSet boardRs = null;
	
	/*
		SELECT board_no boardNo, local_name localName, board_title boardTitle, createdate, updatedate
		FROM board where local_name=?
		ORDER BY createdate DESC
		LIMIT ?, ?
	*/
	
	if (localName.equals("전체")) {
		boardSql = "SELECT board_no boardNo, local_name localName, board_title boardTitle, createdate FROM board ORDER BY createdate DESC LIMIT ?, ?";
		boardStmt = conn.prepareStatement(boardSql);
		boardStmt.setInt(1, startRow);
		boardStmt.setInt(2, rowPerPage);
	} else {
		boardSql = "SELECT board_no boardNo, local_name localName, board_title boardTitle, createdate FROM board where local_name=? ORDER BY createdate DESC LIMIT ?, ?";
		boardStmt = conn.prepareStatement(boardSql);
		boardStmt.setString(1, localName);
		boardStmt.setInt(2, startRow);
		boardStmt.setInt(3, rowPerPage);
	}
	
	boardRs = boardStmt.executeQuery(); // DB 쿼리 결과셋 포함
	// boardRs -> boardList 이동
	ArrayList<Board> boardList = new ArrayList<Board>(); // 애플리케이션에서 사용할 모델 (현재 사이즈 0)
	while (boardRs.next()) {
		Board b = new Board();
		b.setBoardNo(boardRs.getInt("boardNo"));
		b.setLocalName(boardRs.getString("localName"));
		b.setBoardTitle(boardRs.getString("boardTitle"));
		b.setCreatedate(boardRs.getString("createdate"));
		boardList.add(b);
	}
	
	System.out.println(boardList + " <--boardList(home2)");
	System.out.println(boardList.size() + " <--boardList.size()(home2)");
	
	// 마지막 페이지 모델링
	String pageSql = "SELECT COUNT(*) FROM board";
	PreparedStatement pageStmt = conn.prepareStatement(pageSql);
	ResultSet pageRs = pageStmt.executeQuery();
	int totalRow = 0;
	if (pageRs.next()) {
		totalRow = pageRs.getInt("COUNT(*)");
	}
	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	
	// 전체 게시글 수, 마지막 페이지 번호 디버깅
	System.out.println(totalRow + " <-- totalRow(home2)");
	System.out.println(lastPage + " <-- lastPage(home2)");
	
	System.out.println("====================================");
%>
<!-- View Layer -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>home2</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<!-- 메인 메뉴(가로) -->
		<div>
			<jsp:include page="/inc/mainmenu.jsp"></jsp:include> <!-- mainmenu.jsp 의 결과를 현재 페이지에서 사용 가능 -->
			<h1 class="text-center">userboard</h1>
		</div>
		
	<table> <!-- 외부 테이블 -->
	<tr class="row"> <!-- 외부 테이블 <tr> -->
	 	<td class="col"> 외부 테이블 <td>
		&nbsp; &nbsp;  &nbsp; &nbsp;  
	</td> 외부 테이블 <td> 
	<td> 
	
		<div> <!-- 서브 메뉴(세로) subMenuList 모델 출력 -->
			<ul class="list-group">
				<%
					for (HashMap<String, Object> m : subMenuList) {
				%>
						<li>
							<a href="<%=request.getContextPath()%>/home2.jsp?localName=<%=(String)m.get("localName")%>" class="btn">
								<%=(String)m.get("localName")%>(<%=(Integer)m.get("cnt")%>) <!-- Object 타입이므로 형변환 -->
							</a>
						</li>
				<% 
					}
				%>
			</ul>
		</div>
	</td> <!-- 외부 테이블 <td>1  -->
	
	<td class="col"> <!-- 외부 테이블 <td> -->
		&nbsp; &nbsp;  &nbsp; &nbsp;  
	</td> <!-- 외부 테이블 <td>  -->
	<td class="col"> <!-- 외부 테이블 <td> -->
		&nbsp; &nbsp;  &nbsp; &nbsp; 
	</td> <!-- 외부 테이블 <td>  -->
	
	<td class="col"> <!-- 외부 테이블 <td>2  -->

			<%
				if (request.getParameter("msg") != null) { // 액션 페이지에서 넘어올 때 msg에 값이 있으면 출력
			%>
					<%=request.getParameter("msg")%>
			<%	
				}
			%>
		<div>
			<!-- 로그인 폼  -->
		<%
			if (session.getAttribute("loginMemberID") == null) { // 로그인 전이면 로그인 폼 출력
		%>
				<form action="<%=request.getContextPath()%>/member/loginAction.jsp" method="post"> <!-- 절대 주소로 작성 - "/web0502/loginAction.jsp"  -->

					<table class="table table-bordered">
						<tr>
							<th class="table-primary text-center">아이디</th>
							<td><input type="text" name="memberID"></td>
						</tr>
						<tr>
							<th class="table-primary text-center">패스워드</th>
							<td><input type="password" name="memberPW"></td>
						</tr>
					</table>
					<button type="submit" class="btn btn-outline-primary">로그인</button>
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
	</td> <!-- 외부 테이블 <td>2  -->
	<td class="col"> <!-- 외부 테이블 <td> -->
		&nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; 
	</td> <!-- 외부 테이블 <td>  -->
	<td class="col"> <!-- 외부 테이블 <td> -->
		&nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; 
	</td> <!-- 외부 테이블 <td>  -->
	
	<td class="col"> <!--class="text-bg-primary"  -->
		<!-- <h5>새 메시지 입력</h5> -->
		css + 페이징 추후 수정
	</td>
	
	</tr> <!-- 외부 테이블 tr -->
	</table> <!-- 외부 테이블 -->
		<table class="table table-bordered text-center">
			<tr class="table-primary">
				<th>localName</th>
				<th>boardTitle</th>
				<th>createdate</th>
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
		<a href="<%=request.getContextPath()%>/board/insertBoardForm.jsp" class="btn btn-outline-primary">게시글 작성</a>
		<%
			// request.getRequestDispatcher(request.getContextPath()+ "/inc/copyright.jsp").include(request, response);
			// 위 코드를 액션 태그로 변경하면 아래와 같음
		%>
		 
		<div class="text-center">
		<%
			if (currentPage > 1) {
		%>
				<a href="./home2.jsp?currentPage=<%=currentPage - 1%>&localName=<%=localName%>" class="btn btn-outline-primary">이전</a>
		<%
			}
		%>
				<%=currentPage%>페이지
		<%
			if (currentPage < lastPage) {
		%>
				<a href="./home2.jsp?currentPage=<%=currentPage + 1%>&localName=<%=localName%>" class="btn btn-outline-primary">다음</a>
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