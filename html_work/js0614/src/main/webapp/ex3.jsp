<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>0614 ex3</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
		<script>
			$(document).ready(function() { // 문서가 준비되었을 때 실행 (script 태그를 head에 사용하기 위함)
				const MAX_COUNT = 50; // const 상수선언 사용하는 키워드 -> 자바의 final과 유사
				$('#comment').keyup(function() { // 키를 누른 후 놓았을 때의 이벤트
					let len = $('#comment').val().length; // id가 comment 인 value의 길이
					if (len > MAX_COUNT) { // 입력값이 50자를 넘으면
						let str = $('#comment').val().substring(0, MAX_COUNT);
						$('#comment').val(str);
						alert(MAX_COUNT + '자 까지만 입력 가능');
					} else { // 50자를 넘지 않으면
						$('#count').text(len);
					}
				});
			});
		</script>
	</head>
	<body>
		<div>
			<div>댓글(50자 이하) 현재: <span id="count">0</span> 자</div>
			<div>
				<textarea id="comment" rows="2" cols="80"></textarea>
			</div>
		</div>
	</body>
</html>