<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>rspAction</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String userRsp = request.getParameter("userRsp"); // "가위" or "바위" or "보"
	
	int r = (int)(Math.random() * 3); // 0, 1, 2
	
	String comRsp = null; 
	if (r == 0) {
		comRsp = "가위";
	} else if (r == 1) {
		comRsp = "바위";
	} else {
		comRsp = "보";
	}
	
	String result = null;
	if (userRsp.equals(comRsp)) { // 참조 타입 간 == : 주소값 비교
		result = "비겼다";
	} else if ((userRsp.equals("가위")&&comRsp.equals("보")) 
			|| (userRsp.equals("바위")&&comRsp.equals("가위"))
			|| (userRsp.equals("보")&&comRsp.equals("바위"))) {
		result = "이겼다";
	} else {
		result = "졌다";
	}
%>

<div>사용자: <%=userRsp%></div>
<div>컴퓨터: <%=comRsp%></div>
<div>결과 : <%=result%></div>
</body>
</html>