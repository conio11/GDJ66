<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="onepiece.Person" %>
<%
	// 데이터 생성
	ArrayList<Person> list = new ArrayList<Person>();
	// data 1
	Person kcs = new Person();
	kcs.name = "김철수";
	kcs.gender = "남";
	kcs.age = 17;
	list.add(kcs);
	
	// data 2
	Person lsh = new Person();
	lsh.name = "이순희";
	lsh.gender = "여";
	lsh.age = 20;
	list.add(lsh);
		
	// data 3
	Person hkd = new Person();
	hkd.name = "홍길동";
	hkd.gender = "남";
	hkd.age = 21;
	list.add(hkd);
		
	// data 4
	Person kha = new Person();
	kha.name = "김현아";
	kha.gender = "여";
	kha.age = 16;
	list.add(kha);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<!--<link rel="stylesheet" href="./myStyle.css">  외부 링크(소스) 사용 가능  -->
		
		<!-- Latest compiled and minified CSS / .min 지우고 검색 -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
	<div class="container-fluid">
		<table class="table table-striped table-dark">
			<thead>
				<tr>
					<th class="x">이름</th>
					<th class="x">성별</th>
					<th class="x">나이</th>
				</tr>
			<thead>
			
			<tbody>
		<%
			for (Person p : list) { // list.size() 만큼 반복
		%>
			<tr>
				<td><%=p.name%></td>
				<td><%=p.gender%></td>
				<td><%=p.age%></td>
			</tr>
		<%
			}
		%>
			</tbody>
		</table>
	
	<div class="row">
		<div class="col-sm-6">
			<h1>첫 번째 제목</h1>
		</div>
		<div class="col-sm-6">
			<h1>두 번째 제목</h1>
		</div>
	</div>
	</div>
	</body>
</html>