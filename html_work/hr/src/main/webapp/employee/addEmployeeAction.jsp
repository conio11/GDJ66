<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="vo.*"%>
<%
	// 직원 입력 실행파일
	
	// post 방식 인코딩 처리
	request.setCharacterEncoding("UTF-8");

	// 세션 유효성 확인 - 세션 없으면(로그인 상태가 아니면) home.jsp로 이동
	// loginAction.jsp 구현 후 주석 해제
 	String msg = "";
	/* if (session.getAttribute("loginEmployee") == null) {
		msg = URLEncoder.encode("잘못된 접근입니다. 로그인 후 이용 가능합니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/home.jsp?msg=" + msg);
		return;
	}  */
	
	// loginAction.jsp 구현 후 디버깅 코드 작성
	// int empID = 0;
	// String empFName = "";
	// empFName = (String) session.getAttribute(loginEmployee.getEmployee());
	// String empLName = "";
	
	// 요청값 유효성 확인
	// 넘어오는 값 중 공백 또는 null이 있는 경우 입력 폼으로 이동 (commission_pct 값은 null 허용)
	if (request.getParameter("employeeID") == null
	|| request.getParameter("firstName") == null
	|| request.getParameter("lastName") == null
	|| request.getParameter("email") == null
	|| request.getParameter("phoneNumber") == null
	|| request.getParameter("hireDate") == null
	|| request.getParameter("jobID") == null
	|| request.getParameter("salary") == null
	|| request.getParameter("managerID") == null
	|| request.getParameter("departmentID") == null
	|| request.getParameter("employeeID").equals("")
	|| request.getParameter("employeeID").equals("")
	|| request.getParameter("firstName").equals("")
	|| request.getParameter("lastName").equals("")
	|| request.getParameter("email").equals("")
	|| request.getParameter("phoneNumber").equals("")
	|| request.getParameter("hireDate").equals("")
	|| request.getParameter("jobID").equals("")
	|| request.getParameter("salary").equals("")
	|| request.getParameter("commissionPct").equals("")
	|| request.getParameter("managerID").equals("")
	|| request.getParameter("departmentID").equals("")) {
		msg = URLEncoder.encode("* 모든 값을 입력해주세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/employee/addEmployee.jsp?msg=" + msg);
		return; // 실행 종료
	}
	
	int employeeID = Integer.parseInt(request.getParameter("employeeID"));
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String email = request.getParameter("email");
	String phoneNumber = request.getParameter("phoneNumber");
	String hireDate = request.getParameter("hireDate");
	String jobID = request.getParameter("jobID");
	double salary = Double.parseDouble(request.getParameter("salary"));
	double commissionPct = Double.parseDouble(request.getParameter("commissionPct"));
	int managerID = Integer.parseInt(request.getParameter("managerID"));
	int departmentID = Integer.parseInt(request.getParameter("departmentID"));
	
	
	
	
%>