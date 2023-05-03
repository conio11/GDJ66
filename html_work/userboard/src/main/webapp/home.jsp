<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*" %>

<%
	//인코딩 설정
	response.setCharacterEncoding("UTF-8");
	
	//DB 연결
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/userboard";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(home)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(home)");
	
	String sql = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	// 1) 서브메뉴 출력 쿼리
	// 전체 행 수, 지역별 행 수 구하는 쿼리
	/*
	SELECT '전체' localName, COUNT(local_name) cnt FROM board
	UNION ALL
	SELECT local_name, COUNT(local_name) FROM board GROUP BY local_name
	*/

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
	
	// 카테고리별 게시글 10개씩 출력
	// localName
	System.out.println(request.getParameter("localName") + " <- localName(home)");
	String localName = null;
	if (request.getParameter("localName") != null 
	&& !request.getParameter("localName").equals("")) { // localName에 값이 있는 경우 
		localName = request.getParameter("localName");
	} else {
		localName = "전체";
	}
	System.out.println(localName + " <-- localName(home)");
	
	// localName 전체 여부에 따라 쿼리문 분기
	if (localName.equals("전체")) {
		sql = "SELECT board_no boardNo, local_name localName, board_title boardTitle FROM board LIMIT 0, 10";
		stmt = conn.prepareStatement(sql);
	} else { // localName 값이 전체가 아닌 경우
		sql = "SELECT board_no boardNo, local_name localName, board_title boardTitle FROM board WHERE local_name=? LIMIT 0, 10";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, localName); // ?에 localName 대입
	}
	System.out.println(stmt + " <-- stmt(home)");
	rs = stmt.executeQuery();
	
	// localNameList
	ArrayList<Board> localNameList = new ArrayList<Board>();
	while (rs.next()) {
		Board b = new Board();
		b.boardNo = rs.getInt("boardNo");
		b.localName = rs.getString("localName");
		b.boardTitle = rs.getString("boardTitle");
		localNameList.add(b);
	}
	
	System.out.println(localNameList.size() + " <-- localNameList.size()(home)");
	
	System.out.println("====================================");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>home</title>
	</head>
	<body>
		<!-- 메인 메뉴(가로) -->
		<div>
			<jsp:include page="./inc/mainmenu.jsp"></jsp:include> <!-- mainmenu.jsp 의 결과를 현재 페이지에서 사용 가능 -->
		</div>
		

		<div> <!-- 서브 메뉴(세로) subMenuList 모델 출력 -->
			<ul>
				<%
					for (HashMap<String, Object> m : subMenuList) {
				%>
						<li>
							<a href="<%=request.getContextPath()%>/home.jsp?localName=<%=(String)m.get("localName")%>">
								<%=(String)m.get("localName")%>(<%=(Integer)m.get("cnt")%>) <!-- Object 타입이므로 형변환 -->
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
			if (session.getAttribute("loginMemberID") == null) { // 로그인 전이면 로그인 폼 출력
		%>
				<form action="<%=request.getContextPath()%>/member/loginAction.jsp" method="post"> <!-- 절대 주소로 작성 - "/web0502/loginAction.jsp"  -->
					<table border="1">
						<tr>
							<td>아이디</td>
							<td><input type="text" name="memberID"></td>
						</tr>
						<tr>
							<td>패스워드</td>
							<td><input type="password" name="memberPW"></td>
						</tr>
					</table>
					<button type="submit">로그인</button>
				</form>
		<%
			}
		%>
	
		</div>
		
		<table border="1">
			<tr>
				<th>boardNo</th>
				<th>localName</th>
				<th>boardTitle</th>
			</tr>
			
		<%
			for (Board b : localNameList) {
		%>
			<tr>
				<td><%=b.boardNo%></td> 
				<td><%=b.localName%></td>
				<td><%=b.boardTitle%></td>
			</tr>
				
		<%
			}
		%>
		</table>
		<%
			// request.getRequestDispatcher(request.getContextPath()+ "/inc/copyright.jsp").include(request, response);
			// 위 코드를 액션 태그로 변경하면 아래와 같음
		%>
		<div>
			<!-- include 페이지 : Copyright &copy; 구디아카데미 -->
			<jsp:include page="./inc/copyright.jsp"></jsp:include>
		</div>
	</body>
</html>