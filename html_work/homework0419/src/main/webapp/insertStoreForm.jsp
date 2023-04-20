<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
 		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div><!-- 메인메뉴 -->
			<a href="./storeList.jsp">맛집 리스트</a>			
		</div>
		<div class="container mt-3 d-flex justify-content-center">
			<h1>맛집 입력</h1>
		</div>
		<form action="./insertStoreAction.jsp" method="post">
			<table class="table table-bordered">
				<tr>
					<td class="text-bg-dark text-center">store_name</td>
					<td>
						<input type="text" name="storeName">
					</td>
				</tr>
				<tr>
					<td class="text-bg-dark text-center">store_category</td>
					<td>
						<input type=radio name="storeCategory" value="한식">한식 <!-- 라디오 타입의 값은 value로 저장 -->
						<input type=radio name="storeCategory" value="중식">중식
						<input type=radio name="storeCategory" value="일식">일식
					</td>
				</tr>
				<tr>
					<td class="text-bg-dark text-center">store_address</td>
					<td>
						<textarea rows="3" cols="50" name="storeAddress"></textarea>
					</td>
				</tr>
				<tr>
					<td class="text-bg-dark text-center">store_emp_cnt</td>
					<td>
						<input type=radio name="storeEmpCnt" value="1">1
						<input type=radio name="storeEmpCnt" value="2">2
						<input type=radio name="storeEmpCnt" value="3">3
						<input type=radio name="storeEmpCnt" value="4">4
						<input type=radio name="storeEmpCnt" value="5">5
						<input type=radio name="storeEmpCnt" value="6">6
						<input type=radio name="storeEmpCnt" value="7">7
						<input type=radio name="storeEmpCnt" value="8">8
						<input type=radio name="storeEmpCnt" value="9">9
						<input type=radio name="storeEmpCnt" value="10">10
					</td>
				</tr>
				<tr>
					<td class="text-bg-dark text-center">store_begin</td>
					<td>
						<input type="date" name="storeBegin">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">입력</button>
					</td>
					<!-- <td></td> -->
				</tr>	
			</table>
		</form>
	</body>
</html>