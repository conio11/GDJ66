<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>   
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="util.*"%>
    
<%
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 요청값 유효성 확인
	if (request.getParameter("subjectNo") == null
	|| request.getParameter("subjectNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp");
		return;
	}
	
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	System.out.println(subjectNo + " <-- subjectNo(removeSubject)");
	
	// DBUtil dbUtil = new DBUtil();
	SubjectDao subDao = new SubjectDao();

	// Connection conn = dbUtil.getConnection(); 
	
	Subject sub = new Subject();
	sub = subDao.selectSubjectOne(subjectNo);
	
	System.out.println("=============removeSubject=============");	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>removeSubject</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div class="container mt-3">
		<a href="<%= request.getContextPath()%>/subject/subjectList.jsp" class="btn btn-outline-secondary">메인 화면으로</a>
		<div class="text-center">
			<h1>과목 정보 삭제</h1>
		</div>
		<form action="<%=request.getContextPath()%>/subject/removeSubjectAction.jsp" method="post">
			<table class="table table-hover text-center">
				<tr> 
					<th>subjectName</th>
					<td><input type="text" name="subjectName" value="<%=sub.getSubjectName()%>" readonly="readonly" class="form-control w-50"></td>
				</tr>
				<tr>
					<th>subjectTime</th>
					<td><input type="text" name="subjectTime"  value="<%=sub.getSubjectTime()%>" readonly="readonly" class="form-control w-50"></td>
				</tr>
			</table>
			<button type="submit" class="btn btn-outline-secondary">과목 정보 삭제</button>
		</form>
		</div>
	</body>
</html>