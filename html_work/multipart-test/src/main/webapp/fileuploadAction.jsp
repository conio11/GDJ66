<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--  request -->
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
	// 업로드 폴더 정적 지정
	// String dir = "c:\\upload"; 
	// 업로드 폴더 동적 지정
	String dir = request.getServletContext().getRealPath("/upload");
	System.out.println(dir);

	int max = 10 * 1024 * 1024; // 1024byte -> 1kbyte, 1024kbyte -> 1mbyte
	// MultipartRequest는 request를 매개변수로 받아 request를 랩핑한 랩핑 타입
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "UTF-8", new DefaultFileRenamePolicy());
	String imgTitle = mRequest.getParameter("imgTitle");
	String imgPw = mRequest.getParameter("imgPw");
	
	String contentType = mRequest.getContentType("imgFile");
	String originalFilename = mRequest.getOriginalFileName("imgFile");
	String systemFilename = mRequest.getFilesystemName("imgFile");
	
	System.out.println(contentType +" <-- 마임타입"); // 마임(MIME)타입: Multipurpose Internet Mail Extensions" -> 웹에서 데이터 형식 지정 -> 이미지: "image/jpeg" 와 같은 방식
	System.out.println(originalFilename +" <-- 원본 파일 이름");
	System.out.println(systemFilename +" <-- 새로 만들어진 파일 이름");
%>