<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>
<%
	// controller
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	if (request.getParameter("teacherNo") == null
	|| request.getParameter("teacherNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/teacher/teacherList.jsp");
		return;
	}
	
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	System.out.println(teacherNo + " <-- teacherNo(removeTeacherAction)");
	
	// model
	TeacherDao TDao = new TeacherDao();
	
	// Teacher teacher = new Teacher();
	// teacher.setTeacherNo(teacherNo);
	
	int row = TDao.deleteTeacher(teacherNo);
	System.out.println(row + " <-- row(removeTeacherAction)");
	
	String msg = "";
	if (row == 1) {
		System.out.println("삭제 성공");
		msg = URLEncoder.encode("강사 정보가 삭제되었습니다.", "UTF-8"); 
		
	} else {
		System.out.println("삭제 실패");
		msg = URLEncoder.encode("강사 정보 삭제에 실패했습니다.", "UTF-8"); 
	}
	
	// 삭제 성공 여부 관계없이 메시지와 함께 메인 페이지로 이동
	response.sendRedirect(request.getContextPath() + "/teacher/teacherList.jsp?msg=" + msg);
	
	System.out.println("=============removeTeacherAction=============");
%>