<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	CateYearDao dao = new CateYearDao();
	ArrayList<Integer> list = dao.selectCateYearList();
%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>cateList</title>
		<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
	</head>
	<body>
		<select id="cateYear"> <!-- 대분류 -->
			<option value="">연도 대분류 선택</option>
			<%
				for (Integer i : list) {
			%>
					<option value="<%=i%>"><%=i%></option>
			<%		
				}
			%>		
		</select>
		
		<!-- 중분류 -->
		<select id="cateLang">
			<option value="">언어 중분류 선택</option>
		</select>
		
		<script>
			$('#cateYear').change(function() { // 대분류가 변경(change)되는 이벤트 발생 시 
				if ($('#cateYear').val() == "") {
					alert('대분류(년)를 선택하세요');
				} else {
					// alert($('#cateYear').val());
					$.ajax({
						url: './selectCateLangList.jsp',
						data: {y: $('#cateYear').val()},
						success: function(param) {
							console.log(param);
							// param을 cateLang 추가
							$(param).each(function(index, item)) {
								let str = '<option value="'+item+'">'+item+'</option>';
								$('#cateLang').append(str);
								
							});
						}
					});
				}
			});
		</script>
	
	</body>
</html>