<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addCashbook</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				$("#addCashbookBtn").click(function() {
					var checkedRadio = $('input[name="category"]:checked').length; // 버튼 클릭 함수 위에 위치할 경우 항상 0이 되는 현상
					if (checkedRadio === 0) {
						alert("수입/지출을 선택해주세요.");
					} else if ($("#price").val() == "") {
						alert("금액을 입력해주세요.");
						$("#price").focus();
					} else if ($("#price").val() < 1) {
						alert("유효한 금액을 입력해주세요.");
						$("#price").val("");
					} else if ($("#memo").val() == "") {
						alert("메모를 입력해주세요.");
						$("#memo").focus();
					} else {
						$("#addCashbook").submit();
					}
				});
			});
		</script>
	</head>
	<body>
		<h1>가계부 입력</h1>
		<form method="post" action="${pageContext.request.contextPath}/addCashbook" id="addCashbook">
			<input type="hidden" name="targetYear" value="${targetYear}">
			<input type="hidden" name="targetMonth" value="${targetMonth}">
			<input type="hidden" name="targetDate" value="${targetDate}">
			<table border="1">
				<tr>
					<td>날짜</td>
					<td>${targetYear}년 ${targetMonth + 1}월 ${targetDate}일</td>
				</tr>
				<tr>
					<td>카테고리</td>
					<td>
						<input type="radio" name="category" value="수입"><span>수입</span>
						<input type="radio" name="category" value="지출"><span>지출</span>
					</td>
				</tr>
				<tr>
					<td>금액</td>
					<td><input type="number" name="price" id="price"></td>
				</tr>
				<tr>
					<td>메모</td> <!-- 해시태그 -->
					<td><textarea name="memo" cols="50" rows="5" id="memo"></textarea>
				</tr>
			</table>
			<button type="button" id="addCashbookBtn">입력</button>
		</form>
	</body>
</html>