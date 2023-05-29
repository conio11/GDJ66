<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>이미지파일 업로드</h1>
	<form action="<%=request.getContextPath()%>/fileuploadAction.jsp"
			method="post" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<td>이미지 제목</td>
				<td><input type="text" name="imgTitle"></td>
			</tr>
			<tr>
				<td>이미지 파일</td>
				<td><input type="file" name="imgFile"></td>
			</tr>
			<tr>
				<td>이미지 비밀번호</td>
				<td><input type="password" name="imgPw"></td>
			</tr>
		</table>
		<button type="submit">이미지 파일 업로드</button>	
	</form>
</body>
</html>