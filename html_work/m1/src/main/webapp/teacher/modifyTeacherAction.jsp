<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>

<%
	// controller

	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// update 유효성 관련 내용 추가

	if (request.getParameter("teacherNo") == null
	|| request.getParameter("teacherNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/teacher/teacherList.jsp");
		return;
	}
	
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	String teacherID = request.getParameter("teacherID");
	String teacherName = request.getParameter("teacherName");
	String teacherHistory = request.getParameter("teacherHistory");
	
	System.out.println(teacherNo + " <-- teacherNo(modifyTeacherAction)");

	// model
	TeacherDao TDao = new TeacherDao();
	
	Teacher teacher = new Teacher();
	teacher.setTeacherNo(teacherNo); // update문에서 teacher_no? 조건으로 변경하므로 teacherNo값 필수
	teacher.setTeacherID(teacherID);
	teacher.setTeacherName(teacherName);
	teacher.setTeacherHistory(teacherHistory);
	
	int row = TDao.updateTeacher(teacher);
	System.out.println(row + " <-- row(modifyTeacherAction)");
	
	String msg = "";
	if (row == 1) {
		System.out.println("수정 성공");
		msg = URLEncoder.encode("강사 정보가 변경되었습니다.", "UTF-8"); 
		
	} else {
		System.out.println("수정 실패");
		msg = URLEncoder.encode("강사 정보 변경에 실패했습니다.", "UTF-8"); 
	}
	
	// 수정 성공 여부 관계없이 메시지와 함께 메인 페이지로 이동
	response.sendRedirect(request.getContextPath() + "/teacher/teacherList.jsp?msg=" + msg);
	
	System.out.println("=============modifyTeacherAction=============");
%>
