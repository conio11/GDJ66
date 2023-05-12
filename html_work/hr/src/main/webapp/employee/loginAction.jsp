<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="vo.*" %>

<% 
	// 세션 유효성 확인 -> 요청값 유효성 확인
	// 세션 유효성 확인
	String msg = "";
	if (session.getAttribute("loginEmployee") != null) { // 세션에 값이 있으면 home.jsp로 이동 // 홈 말고 리스트로 가도 될거같은데
		System.out.println("세션값이 존재하므로 홈 화면으로 이동(loginAction))");
		msg = URLEncoder.encode("이미 로그인 상태입니다.", "UTF-8");
		response.sendRedirect(request.getContextPath()+ "/home.jsp?=msg" + msg);
		return; // 실행 종료
	}
	
	// 요청값 유효성 확인
	if (request.getParameter("empID") == null
	|| request.getParameter("empFName") == null
	|| request.getParameter("empLName") == null
	|| request.getParameter("empID").equals("")
	|| request.getParameter("empID").equals("")
	|| request.getParameter("empID").equals("")) { // 입력값이 하나라도 들어오지 않았을 경우 home.jsp로 이동
		msg = URLEncoder.encode("세 값을 모두 입력해주세요.", "UTF-8");
		response.sendRedirect(request.getContextPath()+ "/home.jsp?msg=" + msg);
		return; // 실행 종료
	}
	int empID = Integer.parseInt(request.getParameter("empID"));
	String empFName = request.getParameter("empFName");
	String empLName = request.getParameter("empLName");
	
	// 요청값 디버깅
	System.out.println(empID + " <-- empID");
	System.out.println(empFName + " <-- empFName");
	System.out.println(empLName + " <-- empLName");

	// 참조타입을 세션에 추가 / 가져오기
	// 세션에 추가할 때
	Employee loginEmployee = new Employee();
	loginEmployee.setEmployeeID(empID); 
	loginEmployee.setFirstName(empFName); 
	loginEmployee.setLastName(empLName); 
	session.setAttribute("loginEmployee", loginEmployee); // 세션에 클래스 저장
	
	// 세션에서 가져올 때
	Object o = session.getAttribute("loginEmployee"); // session은 Object 타입(모든 타입을 받을 수 있음)
	Employee sessionEmployee = (Employee) o; // 형변환
	// Employee sessionEmployee = null;
	
	if (o instanceof Employee) { // instanceof 연산자 (boolean) -> 왼쪽(객체)이 오른쪽(클래스)인스턴스이면 true (왼쪽이 오른쪽의 부모타입이면 true)											   
		sessionEmployee = (Employee) o; 
	}
	
	// Oracle DB 연결
	String driver = "oracle.jdbc.driver.OracleDriver";
	String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbUser = "hr";
	String dbPw = "1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(loginAction)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println(conn + " <-- conn(loginAction)");
	System.out.println("DB 접속 성공(loginAction)");
	
	String loginSql = "";

	
	// 마지막에 실행
	// 로그인 성공 여부 관계없이 
	// response.sendRedirect(request.getContextPath()+ "/home.jsp");
	
	
	
	System.out.println("==============================");
%>
