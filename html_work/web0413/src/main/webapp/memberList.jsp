<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="good.Member" %>
<%@ page import="java.util.Calendar"%>
<%
	// 데이터 초기화
	Member[] list = new Member[25]; // null, null로 초기화
	list[0] = new Member();
	list[0].name = "구O혜";
	list[0].birthYear = 1993;
	list[0].gender = "여";
	list[0].major = false;
	
	
	list[1] = new Member();
	list[1].name = "권O중";
	list[1].birthYear = 2000;
	list[1].gender = "남";
	list[1].major = false;
	
	list[2] = new Member();
	list[2].name = "이O산";
	list[2].birthYear = 1997;
	list[2].gender = "남";
	list[2].major = false;
	
	list[3] = new Member();
	list[3].name = "하O진";
	list[3].birthYear = 1992;
	list[3].gender = "남";
	list[3].major = false;
	
	list[4] = new Member();
	list[4].name = "이O은";
	list[4].birthYear = 2000;
	list[4].gender = "여";
	list[4].major = true;
	
	list[5] = new Member();
	list[5].name = "송O지";
	list[5].birthYear = 1996;
	list[5].gender = "여";
	list[5].major = false;
	
	list[6] = new Member();
	list[6].name = "김O훈";
	list[6].birthYear = 1995;
	list[6].gender = "남";
	list[6].major = true;
	
	list[7] = new Member();
	list[7].name = "김O은";
	list[7].birthYear = 2000;
	list[7].gender = "여";
	list[7].major = false;
	
	list[8] = new Member();
	list[8].name = "송O정";
	list[8].birthYear = 1999;
	list[8].gender = "여";
	list[8].major = false;
	
	list[9] = new Member();
	list[9].name = "김O진";
	list[9].birthYear = 1997;
	list[9].gender = "여";
	list[9].major = false;
	
	list[10] = new Member();
	list[10].name = "조O욱";
	list[10].birthYear = 1999;
	list[10].gender = "남";
	list[10].major = true;
	
	list[11] = new Member();
	list[11].name = "오O빈";
	list[11].birthYear = 2000;
	list[11].gender = "여";
	list[11].major = false;
	
	list[12] = new Member();
	list[12].name = "안O나";
	list[12].birthYear = 1996;
	list[12].gender = "여";
	list[12].major = false;
	
	list[13] = new Member();
	list[13].name = "신O음";
	list[13].birthYear = 2000;
	list[13].gender = "여";
	list[13].major = false;
	
	list[14] = new Member();
	list[14].name = "김O선";
	list[14].birthYear = 1993;
	list[14].gender = "여";
	list[14].major = false;
	
	list[15] = new Member();
	list[15].name = "홍O표";
	list[15].birthYear = 1997;
	list[15].gender = "남";
	list[15].major = false;
	
	list[16] = new Member();
	list[16].name = "양O주";
	list[16].birthYear = 1996;
	list[16].gender = "여";
	list[16].major = false;
	
	list[17] = new Member();
	list[17].name = "장O정";
	list[17].birthYear = 1990;
	list[17].gender = "여";
	list[17].major = false;
	
	list[18] = new Member();
	list[18].name = "임O예";
	list[18].birthYear = 1999;
	list[18].gender = "여";
	list[18].major = false;
	
	list[19] = new Member();
	list[19].name = "정O현";
	list[19].birthYear = 1995;
	list[19].gender = "남";
	list[19].major = true;
	
	list[20] = new Member();
	list[20].name = "김O진";
	list[20].birthYear = 1993;
	list[20].gender = "여";
	list[20].major = false;
	
	list[21] = new Member();
	list[21].name = "이O성";
	list[21].birthYear = 1998;
	list[21].gender = "남";
	list[21].major = true;
	
	list[22] = new Member();
	list[22].name = "정O형";
	list[22].birthYear = 1994;
	list[22].gender = "여";
	list[22].major = false;
	
 	list[23] = new Member();
	list[23].name = "최O";
	list[23].birthYear = 1999;
	list[23].gender = "남";
	list[23].major = false;
	
	list[24] = new Member();
	list[24].name = "이O환";
	list[24].birthYear = 1994;
	list[24].gender = "남";
	list[24].major = false;
	
/*	list[25] = new Member();
	list[25].name = "";
	list[25].birthYear = ;
	list[25].gender = "";
	list[25].major = ; */
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList.jsp</title>
<style>
	table, td {
		text-align: center;
		border-collapse: collapse;
		}
	th {background-color: yellow;}
</style>
</head>
<body>
	<h1>학생 목록 </h1>
	<table border="1">
		<div>총 인원 : <%=list.length%>명</div> 
		<tr>
			<th>이름</th>
			<th>나이</th>
			<th>성별(아이콘)</th>
			<th>전공유무(전공/비전공)</th>
		</tr>
		<tr>
			
	<%
		for (Member m : list) {
	%>		
			<td><%=m.name%></td> 
	<%		
			// 오늘 날짜 정보를 반환(today) 하는 코드
			Calendar today = java.util.Calendar.getInstance();
			int todayYear = today.get(Calendar.YEAR);
			int age = todayYear - m.birthYear + 1;	
	%>	
			<td><%=age%></td>
	<%
			if (m.gender.equals("여")) {	
	%>
			<td>&#9792;</td>	
	<%	
			} else {
	%>	
			<td>&#9794;</td>
	<%		
			}
	
			if (m.major == false) {	
	%>		
			<td>비전공</td>
	<%	
			} else {
	%>	
			<td>전공</td>
	<%				
			}
	%>		
		</tr>
	<%
		}
	%>
	</table>
</body>
</html>