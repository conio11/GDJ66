<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	// DB 연결
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/userboard";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(localListByMap)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(localListByMap)");

	// 한 행 가져오기
	// SELECT local_name localName, '대한민국' country, '박성환' worker FROM local LIMIT 0, 1;
	
	String sql = "SELECT local_name localName, '대한민국' country, '박성환' worker FROM local LIMIT 0, 1";
	PreparedStatement stmt = conn.prepareStatement(sql);
	System.out.println(stmt + " <-- stmt(localListByMap)");
	ResultSet rs = stmt.executeQuery();
	
	// VO 대신 HashMap 타입을 사용
	HashMap<String, Object> map = null; // value가 Object 타입 -> 어떤 데이터 값이든 저장 가능
	
	if (rs.next()) {
		map = new HashMap<String, Object>();
		// map.put(key 이름, 값)
		map.put("localName", rs.getString("localName")); 
		map.put("country", rs.getString("country"));
		map.put("worker", rs.getString("worker"));
		
		System.out.println(rs.getString("localName") + " <-- localName(map)");
		System.out.println(rs.getString("country") + " <-- country(map)");
		System.out.println(rs.getString("worker") + " <-- worker(map)");
	}
	
	System.out.println((String)map.get("localName") + " <-- localName(1행)");
	System.out.println((String)map.get("country") + " <-- country(1행)");
	System.out.println((String)map.get("worker") + " <-- worker(1행)");
	
	String sql2 = "SELECT local_name localName, '대한민국' country, '박성환' worker FROM local";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	System.out.println(stmt2 + " <-- stmt2(localListByMap)");
	ResultSet rs2 = stmt2.executeQuery();
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();	
	while(rs2.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("localName", rs2.getString("localName")); 
		m.put("country", rs2.getString("country"));
		m.put("worker", rs2.getString("worker"));
		list.add(m);
	}
	
	String sql3 = "SELECT local_name localName, COUNT(local_name) cnt FROM board GROUP BY local_name";
	PreparedStatement stmt3 = conn.prepareStatement(sql3);
	System.out.println(stmt3 + " <-- stmt3(localListByMap)");
	ResultSet rs3 = stmt3.executeQuery();
	ArrayList<HashMap<String, Object>> list3 = new ArrayList<HashMap<String, Object>>();	
	while(rs3.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("localName", rs3.getString("localName")); 
		m.put("cnt", rs3.getInt("cnt"));
	    list3.add(m);
	}
	
	System.out.println("============================");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>localListByMap</title>
	</head>
	<body>
		<div>
			<h2>rs 결과셋</h2>
			<%=map.get("localName")%>
			<%=map.get("country")%>
			<%=map.get("worker")%>
		</div>
		
		<hr> <!-- 수평선 -->
		<h2>rs2 결과셋</h2>
		<table border="1">
			<tr>
				<th>localName</th>
				<th>country</th>
				<th>worker</th>
			</tr>
	<%
		for (HashMap<String, Object> m : list) { // 해시맵 타입의 m 변수로 list 순회하며 출력
	%>
			<tr>
				<td><%=(String)m.get("localName")%></td>
				<td><%=(String)m.get("country")%></td>
				<td><%=(String)m.get("worker")%></td>
			</tr>
	<%
		}
	%>
		</table>
		
		<hr> 
		<h2>rs3 결과셋</h2>
		<ul>
			<li>
				<a href="">전체</a>	
			</li>
			<%
				for (HashMap<String, Object> m : list3) {
			%>
					<li>
						<a href=""><%=(String)m.get("localName")%>(<%=(Integer)m.get("cnt")%>)</a>
					</li>
			<% 
				}
			%>
		</ul>
	</body>
</html>