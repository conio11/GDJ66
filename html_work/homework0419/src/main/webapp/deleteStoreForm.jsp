<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// storeNo 값 넘어오지 않으면 storeList로 리다이렉트
	// 요청값 유효 확인
	if (request.getParameter("storeNo") == null) {
		response.sendRedirect("./storeList.jsp");
		return;
	}

	int storeNo = Integer.parseInt(request.getParameter("storeNo"));
	System.out.println(storeNo + " <-- deleteStoreForm param storeNo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>deleteStoreForm.jsp</title>
</head>
<body>
	<div class="container mt-3 d-flex justify-content-center">
	<h1>맛집 삭제</h1>
	</div>
	<form action="./deleteStoreAction.jsp" method="post">
	<table class="table table-bordered">
		<tr>
			<td class="text-bg-dark text-center">맛집 번호</td>
			<td>
				<input type="text" name="storeNo" value="<%=storeNo%>" readonly="readonly">
			</td>
		</tr>	
		<tr>
			<td class="text-bg-dark text-center">직원 수</td>
			<td>
				<input type="text" name="storeEmpCnt">
			</td>
		</tr>
			<tr>
			<td colspan="2">
				<button type="submit">삭제</button>
			</td>
			<!-- <td></td> -->
		</tr>
	</table>
	</form>
</body>
</html>