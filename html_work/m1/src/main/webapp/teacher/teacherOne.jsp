<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>

<%
	// post 방식 인코딩
	request.setCharacterEncoding("UTF-8");

	// 요청값 유효성 확인
	if (request.getParameter("teacherNo") == null
	|| request.getParameter("teacherNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/teacher/teacherList.jsp");
		return;
	}
	
	// 요청값 디버깅
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	System.out.println(teacherNo + " <-- teacherNo(teacherOne)");
	
	// TDao 
	TeacherDao TDao = new TeacherDao();
	
	Teacher teacher = new Teacher();
	teacher = TDao.selectTeacherOne(teacherNo);
	
	System.out.println("=============teacherOne=============");	
%>

<!DOCTYPE html>
	<html>
		<head>
		<meta charset="UTF-8">
		<title>teacherOne</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div class="container mt-3">
		<a href="<%= request.getContextPath()%>/teacher/teacherList.jsp" class="btn btn-outline-secondary">메인 화면으로</a>
		<div class="text-center">
			<h1>강사 상세 정보</h1>
		</div>
		<table class="table table-hover text-center">
			<tr>
				<th>강사 번호</th>
				<td><input type="text" name="subjectName" value="<%=teacher.getTeacherNo()%>" readonly="readonly" class="form-control w-50"></td>
			</tr>
			<tr>
				<th>강사 ID</th>
				<td>
					<%=teacher.getTeacherID()%>
					<%-- <input type="text" name="subjectName" value="<%=teacher.getTeacherID()%>" readonly="readonly" class="form-control w-50"> --%>
				</td>
			</tr>
			<tr>
				<th>강사 이름</th>
				<td><input type="text" name="subjectName" value="<%=teacher.getTeacherName()%>" readonly="readonly" class="form-control w-50"></td>
			</tr>
			<tr>
				<th>강사 이력</th>
				<td><input type="text" name="subjectName" value="<%=teacher.getTeacherHistory()%>" readonly="readonly" class="form-control w-50"></td>
			</tr>
			<tr>
				<th>생성일자</th>
				<td><input type="text" name="subjectName" value="<%=teacher.getCreatedate()%>" readonly="readonly" class="form-control w-50"></td>
			</tr>
			<tr>
				<th>수정일자</th>
				<td><input type="text" name="subjectName" value="<%=teacher.getUpdatedate()%>" readonly="readonly" class="form-control w-50"></td>
			</tr>
		</table>
		<a href="<%=request.getContextPath()%>/teacher/modifyTeacher.jsp?teacherNo=<%=teacher.getTeacherNo()%>" class="btn btn-outline-secondary">수정</a>
		<a href="<%=request.getContextPath()%>/teacher/removeTeacher.jsp?teacherNo=<%=teacher.getTeacherNo()%>" class="btn btn-outline-secondary">삭제</a>
		</div>
		
	</body>
</html>