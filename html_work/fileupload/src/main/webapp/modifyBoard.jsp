<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
    
<%
 	// post 방식 인코딩 설정
 	// request.setCharacterEncoding("UTF-8");
 	
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int boardFileNo = Integer.parseInt(request.getParameter("boardFileNo"));

	System.out.println(boardNo + " <-- boardNo(modifyBoard)");
	System.out.println(boardFileNo + " <-- boardFileNo(modifyBoard)");
	
	
	// DB 연결
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/fileupload";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(modifyBoard)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(modifyBoard)");
	
	/*  
	// 테이블 1:1 연결
	// board의 board_no, board_file의 board_no 비교하여 같으면 출력
	SELECT 
		b.board_title boardTitle, 
		f.origin_filename originFilename,
		f.save_filename saveFilename,
	FROM board b INNER JOIN board_file f
	ON b.board_no = f.board_no
	WHERE b.board_no=? AND f.board_file_no=?
	*/
	
	String boardSql = "SELECT b.board_no boardNo, b.board_title boardTitle, f.board_file_no boardFileNo, f.origin_filename originFilename, f.save_filename saveFilename FROM board b INNER JOIN board_file f ON b.board_no = f.board_no WHERE b.board_no=? AND f.board_file_no=?";
	PreparedStatement boardStmt = conn.prepareStatement(boardSql);
	boardStmt.setInt(1, boardNo);
	boardStmt.setInt(2, boardFileNo);
	
	ResultSet boardRs = boardStmt.executeQuery();
	HashMap<String, Object> map = null;
	if (boardRs.next()) { // 한 행만 출력
		map = new HashMap<>();
		map.put("boardNo", boardRs.getInt("boardNo"));
		map.put("boardTitle", boardRs.getString("boardTitle"));
		map.put("boardFileNo", boardRs.getInt("boardFileNo"));
		map.put("originFilename", boardRs.getString("originFilename"));
	}

	System.out.println("=====================================");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>modifyBoard</title>
<!-- 		<style type="text/css">
			table, th, td {
				border: 1px solid #FF0000;
			}
		</style> -->
	</head>
	<body>
		<h1>boardTitle & boardFile 수정</h1>
		<form action="<%=request.getContextPath()%>/modifyBoardAction.jsp" method="post" enctype="multipart/form-data">
			<!-- 테이블에 출력은 하지 않지만 action 파일에 boardNo, boardFileNo값 넘김 -->
			<input type="hidden" name="boardNo" value="<%=map.get("boardNo")%>">
			<input type="hidden" name="boardFileNo" value="<%=map.get("boardFileNo")%>">
			<table border="1">
				<tr>
					<th>boardTitle</th>
					<td>
						<textarea rows="3" cols="50" name="boardTitle" required="required"><%=map.get("boardTitle")%></textarea>
					</td>
				</tr>
				<tr>
					<th>boardFile (수정 전 파일 : <%=map.get("originFilename")%>)</th>
					<td>
						<input type="file" name="boardFile" required="required">
					</td>
				</tr>
			</table>
			<button type="submit">수정</button>
		</form>
	</body>
</html>