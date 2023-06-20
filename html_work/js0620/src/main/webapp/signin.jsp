<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	</head>
	<body>
		<h1>회원가입</h1>
		<form>
			<div>
				id 중복체크: <input type="text" id="idck">
				<button type="button" id="ckbtn">중복체크</button>
			</div>
			<div>
				id: <input type="text" id="id" readonly="readonly">
			</div>
			<div>
				<button type="button">회원가입</button>
			</div>
		</form>
		<script>
			$('#ckbtn').click(function() {
				// alert('ckbtn click');
				if ($('#idck').val() == '') {
					alert('중복검사할 아이디를 입력하세요');	
				} else {
					// alert($('#idck').val());
					$.ajax({
						url: './selectMember.jsp',
						data: {idck : $('#idck').val()}, // 매개값 보내는 방식
						success: function(param) {
							console.log(param);
							if (param == 'N') {
								alert('이미 사용 중인 아이디 입니다.');
								$('#idck').focus();
							} else {
								$('#id').val($('#idck').val());
							}
						}, 
						error : function(err) {
							console.log(err);
						}
					});
				}
			});
		</script>
	</body>
</html>