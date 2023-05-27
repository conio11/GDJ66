<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%> 
<%@ page import="dao.*"%>
<%
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 요청값 유효성 확인
	if (request.getParameter("teacherNo") == null
	|| request.getParameter("teacherNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/teacher/teacherList.jsp");
		return;
	}
	
	// 요청값 디버깅
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	System.out.println(teacherNo + " <-- teacherNo(modifyTeacher)");
	
	// TeacherDao 클래스 객체 생성 -> SQL 메소드 이용 
	TeacherDao TDao = new TeacherDao();
	Teacher teacher = new Teacher(); 
	teacher = TDao.selectTeacherOne(teacherNo);
	
	System.out.println("=============removeTeacher=============");	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>removeTeacher</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div class="container mt-3">
		<a href="<%= request.getContextPath()%>/teacher/teacherList.jsp" class="btn btn-outline-secondary">메인 화면으로</a>
		<div class="text-center">
			<h1>강사 정보 삭제</h1>
		</div>
		<form action="<%=request.getContextPath()%>/teacher/removeTeacherAction.jsp" method="post">
			<table class="table table-hover text-center">
				<tr>
					<th>강사 번호</th>
					<td><input type="text" name="teacherNo" value="<%=teacher.getTeacherNo()%>" readonly="readonly"class="form-control w-50"></td>
				</tr>
				<tr>
					<th>강사 ID</th>
					<td><input type="text" name="teacherID" value="<%=teacher.getTeacherID()%>" readonly="readonly"class="form-control w-50"></td>
				</tr>
				<tr>
					<th>강사 이름</th>
					<td><input type="text" name="teacherName" value="<%=teacher.getTeacherName()%>" readonly="readonly"class="form-control w-50"></td>
				</tr>
			</table>
			<button type="submit" class="btn btn-outline-secondary">강사 정보 삭제</button>
		</form>
		</div>
	</body>
</html>