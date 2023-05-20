<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<%
	//DB 연결
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/fileupload";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(addBoardAction)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(addBoardAction)");
	
	/*  
	// 테이블 1:1 연결
	// board의 board_no, board_file의 board_no 비교하여 같으면 출력?
	SELECT 
		b.board_title boardTitle, 
		f.origin_filename originFilename,
		f.save_filename saveFilename,
		path
	FROM board b INNER JOIN board_file f
	ON b.board_no = f.board_no
	ORDER BY b.createdate DESC;
	*/
	
	String sql = "SELECT b.board_title boardTitle, f.origin_filename originFilename, f.save_filename saveFilename, path FROM board b INNER JOIN board_file f ON b.board_no = f.board_no ORDER BY b.createdate DESC";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	ArrayList<HashMap<String, Object>> list = new ArrayList<>();
	while (rs.next()) {
		HashMap<String, Object> m = new HashMap<>();
		m.put("boardTitle", rs.getString("boardTitle"));
		m.put("originFilename", rs.getString("originFilename"));
		m.put("saveFilename", rs.getString("saveFilename"));
		m.put("path", rs.getString("path"));
		list.add(m);
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
</head>
<body>
	<h1>PDF 자료 목록</h1>
	<table border="1">
		<tr>
			<td>boardTitle</td>
			<td>originFilename</td>
		</tr>
	<%
		for (HashMap<String, Object> m : list) {
	%>
		<tr>
			<td><%=(String)m.get("boardTitle")%></td>
			<td>
				<a href="<%=request.getContextPath()%>/<%=(String)m.get("path")%>/<%=(String)m.get("saveFilename")%>" download="<%=(String)m.get("saveFilename")%>">
					<%=(String)m.get("originFilename")%>
				</a>
			</td>
		</tr>
	<%
		}
	%>
	</table>
</body>
</html>