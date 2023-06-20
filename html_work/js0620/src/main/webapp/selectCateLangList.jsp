<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="dao.*"%>
<%@ page import = "java.util.*"%>
<%
	Integer y = Integer.parseInt(request.getParameter("y"));
	CateYearDao dao = new CateYearDao();
	ArrayList<String> list = dao.selectCateLangList(y);
	
	// 자바 객체인 list 변수를 json 문자열로 변경
	Gson gson = new Gson();
	String jsonStr = gson.toJson(list);
	out.print(jsonStr);


%>


