<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="onepiece.Pirate"%>

<%	
	// RDBMS(오라클, mySQL, MSSQL)에서 데이터를 불러와서
	// 코드상에서 사용가능한 형태로 (ArrayList<Pirate>) 변경
	
	ArrayList<Pirate> list = new ArrayList<Pirate>();

	// Pirate 객체를 20개 생성
	Pirate p1 = new Pirate();
	p1.name = "몽키 D.루피";
	p1.nickName = "밀짚모자";
	p1.gender = 'M';
	p1.birth = "5월 5일";
	p1.age = 19;
	p1.height = 174;
	p1.hobby = new ArrayList<String>();
	p1.hobby.add("모험");
	p1.hobby.add("잔치");
	p1.blood = "F형(B형)";
	p1.country = "이스트 블루 고아 왕국 후샤 마을";
	p1.money = 3000000000L;
	p1.group = "밀짚모자 일당";
	p1.isDevilFruit = true;
	list.add(p1);
	
	Pirate p2 = new Pirate();
	p2.name = "롤로노아 조로";
	p2.nickName = "해적 사냥꾼"; 
	p2.gender = 'M';
	p2.birth = "11월 11일";
	p2.age = 21;
	p2.height = 181;
	p2.hobby = new ArrayList<String>();
	p2.hobby.add("음주");
	p2.hobby.add("수행");
	p2.blood = "XF형(AB형)";
	p2.country = "이스트 블루 시모츠키 마을";
	p2.money = 1111000000L;
	p2.group = "밀짚모자 일당";
	p2.isDevilFruit = false;
	list.add(p2);
	
	Pirate p3 = new Pirate();
	p3.name = "나미";
	p3.nickName = "도둑고양이"; 
	p3.gender = 'F';
	p3.birth = "7월 3일";
	p3.age = 20;
	p3.height = 170;
	p3.hobby = new ArrayList<String>(); // null; 입력 가능
	p3.blood = "X형(A형)";
	p3.country = "이스트 블루 오이코트 왕국";
	p3.money = 366000000L;
	p3.group = "밀짚모자 일당";
	p3.isDevilFruit = false;
	list.add(p3);
	
	Pirate p4 = new Pirate();
	p4.name = "우솝";
	p4.nickName = "갓(GOD)"; 
	p4.gender = 'M';
	p4.birth = "4월 1일";
	p4.age = 19;
	p4.height = 176;
	p4.hobby = new ArrayList<String>();
	p4.blood = "S형(O형))";
	p4.country = "이스트 블루 시롭 마을";
	p4.money = 500000000L;
	p4.group = "밀짚모자 일당";
	p4.isDevilFruit = false;
	list.add(p4);
	
	Pirate p5 = new Pirate();
	p5.name = "토니토니 쵸파";
	p5.nickName = "솜사탕광"; 
	p5.gender = 'M';
	p5.birth = "12월 24일";
	p5.age = 17;
	p5.height = 90;
	p5.hobby = new ArrayList<String>();
	p5.blood = "X형(A형)";
	p5.country = "위대한 항로 사쿠라 왕국(구 드럼 왕국)";
	p5.money = 1000L;
	p5.group = "밀짚모자 일당";
	p5.isDevilFruit = true;
	list.add(p5);
	
	Pirate p6 = new Pirate();
	p6.name = "니코 로빈";
	p6.nickName = "악마의 아이"; 
	p6.gender = 'F';
	p6.birth = "2월 6일";
	p6.age = 30;
	p6.height = 188;
	p6.hobby = new ArrayList<String>();
	p6.blood = "S형(O형)";
	p6.country = "웨스트 블루 오하라";
	p6.money = 930000000L;
	p6.group = "밀짚모자 일당";
	p6.isDevilFruit = true;
	list.add(p6);
	
	Pirate p7 = new Pirate();
	p7.name = "커티 프람";
	p7.nickName = "프랑키"; 
	p7.gender = 'M';
	p7.birth = "3월 9일";
	p7.age = 36;
	p7.height = 240;
	p7.hobby = new ArrayList<String>();
	p7.blood = "XF형(AB형)";
	p7.country = "사우스 블루";
	p7.money = 394000000L;
	p7.group = "밀짚모자 일당";
	p7.isDevilFruit = false;
	list.add(p7);
	
	Pirate p8 = new Pirate();
	p8.name = "브룩";
	p8.nickName = "소울 킹"; 
	p8.gender = 'M';
	p8.birth = "4월 3일";
	p8.age = 90;
	p8.height = 277;
	p8.hobby = new ArrayList<String>();
	p8.blood = "형(형)";
	p8.country = "웨스트 블루";
	p8.money = 383000000L;
	p8.group = "밀짚모자 일당";
	p8.isDevilFruit = true;
	list.add(p8);
	
	Pirate p9 = new Pirate();
	p9.name = "징베";
	p9.nickName = "바다의 협객"; 
	p9.gender = 'F';
	p9.birth = "4월 2일";
	p9.age = 46;
	p9.height = 301;
	p9.hobby = new ArrayList<String>();
	p9.blood = "형(형)";
	p9.country = "용궁 왕국 어인가";
	p9.money = 1100000000L;
	p9.group = "밀짚모자 일당";
	p9.isDevilFruit = false;
	list.add(p9);
	
	Pirate p10 = new Pirate();
	p10.name = "샹크스";
	p10.nickName = "빨간 머리"; 
	p10.gender = 'M';
	p10.birth = "3월 9일";
	p10.age = 39;
	p10.height = 199;
	p10.hobby = new ArrayList<String>();
	p10.hobby.add("방랑");
	p10.blood = "XF형";
	p10.country = "웨스트 블루";
	p10.money = 4048900000L;
	p10.group = "빨간 머리 해적단";
	p10.isDevilFruit = false;
	list.add(p10);
	
	Pirate p11 = new Pirate();
	p11.name = "벤 베크맨";
	p11.nickName = null; 
	p11.gender = 'M';
	p11.birth = "11월 9일";
	p11.age = 50;
	p11.height = 206;
	p11.hobby = new ArrayList<String>();
	p11.blood = "X형";
	p11.country = "노스 브루";
	p11.money = 0;
	p11.group = "빨간 머리 해적단";
	p11.isDevilFruit = false;
	list.add(p11);
	
	Pirate p12 = new Pirate();
	p12.name = "럭키 루";
	p12.nickName = null; 
	p12.gender = 'M';
	p12.birth = "7월 6일";
	p12.age = 35;
	p12.height = 241;
	p12.hobby = new ArrayList<String>();
	p12.blood = "F형";
	p12.country = "사우스 블루";
	p12.money = 0;
	p12.group = "빨간 머리 해적단";
	p12.isDevilFruit = false;
	list.add(p12);
	
	Pirate p13 = new Pirate();
	p13.name = "야솝";
	p13.nickName = "추격자"; 
	p13.gender = 'M';
	p13.birth = "8월 2일";
	p13.age = 47;
	p13.height = 183;
	p13.hobby = new ArrayList<String>();
	p13.blood = "S형";
	p13.country = "이스트 블루 시롭 마을";
	p13.money = 0L;
	p13.group = "빨간 머리 해적단";
	p13.isDevilFruit = false;
	list.add(p13);
	
	Pirate p14 = new Pirate();
	p14.name = "에드워드 뉴게이트";
	p14.nickName = "흰 수염"; 
	p14.gender = 'M';
	p14.birth = "4월 6일";
	p14.age = 72;
	p14.height = 666;
	p14.hobby = new ArrayList<String>();
	p14.hobby.add("저금");
	p14.blood = "F형";
	p14.country = "신세계 스핑크스";
	p14.money = 5046000000L;
	p14.group = "흰 수염 해적단";
	p14.isDevilFruit = false;
	list.add(p14);
	
	Pirate p15 = new Pirate();
	p15.name = "샬롯 링링";
	p15.nickName = "빅 맘"; 
	p15.gender = 'F';
	p15.birth = "2월 15일";
	p15.age = 68;
	p15.height = 880;
	p15.hobby = new ArrayList<String>();
	p15.hobby.add("다과회");
	p15.hobby.add("진귀한 동물 수집");
	p15.blood = "X형";
	p15.country = "위대한 항로";
	p15.money = 4388000000L;
	p15.group = "빅 맘 해적단";
	p15.isDevilFruit = true;
	list.add(p15);
	
	Pirate p16 = new Pirate();
	p16.name = "카이도";
	p16.nickName = "백수"; 
	p16.gender = 'M';
	p16.birth = "5월 1일";
	p16.age = 59;
	p16.height = 710;
	p16.hobby = new ArrayList<String>();
	p16.blood = "F형";
	p16.country = "위대한 항로 보드카 왕국";
	p16.money = 4611100000L;
	p16.group = "백수 해적단";
	p16.isDevilFruit = true;
	list.add(p16);
	
	Pirate p17 = new Pirate();
	p17.name = "킹";
	p17.nickName = "화재"; 
	p17.gender = 'F';
	p17.birth = "12월 1일";
	p17.age = 47;
	p17.height = 613;
	p17.hobby = new ArrayList<String>();
	p17.blood = "S형";
	p17.country = "위대한 항로";
	p17.money = 1390000000L;
	p17.group = "백수 해적단";
	p17.isDevilFruit = true;
	list.add(p17);
	
	Pirate p18 = new Pirate();
	p18.name = "퀸";
	p18.nickName = "역재"; 
	p18.gender = 'M';
	p18.birth = "7월 13일";
	p18.age = 56;
	p18.height = 612;
	p18.hobby = new ArrayList<String>();
	p18.blood = "XF형";
	p18.country = "위대한 항로";
	p18.money = 132000000L;
	p18.group = "백수 해적단";
	p18.isDevilFruit = false;
	list.add(p18);
	
	Pirate p19 = new Pirate();
	p19.name = "잭";
	p19.nickName = "가뭄해"; 
	p19.gender = 'M';
	p19.birth = "9월 28일";
	p19.age = 28;
	p19.height = 830;
	p19.hobby = new ArrayList<String>();
	p19.hobby.add("풀베기");
	p19.blood = "F형";
	p19.country = "위대한 항로";
	p19.money = 100000000L;
	p19.group = "백수 해적단";
	p19.isDevilFruit = true;
	list.add(p19);
	
	Pirate p20 = new Pirate();
	p20.name = "버기";
	p20.nickName = "천냥광대"; 
	p20.gender = 'M';
	p20.birth = "8월 8일";
	p20.age = 39;
	p20.height = 192;
	p20.hobby = new ArrayList<String>();
	p20.hobby.add("보물 지도 모으기");
	p20.blood = "F형(B형)";
	p20.country = "위대한 항로";
	p20.money = 3189000000L;
	p20.group = "크로스 길드";
	p20.isDevilFruit = true;
	list.add(p20);
	
	// 디버깅 코드
	System.out.println(list.size() + " <-- list.size()" );
	
	// 검색조건에 따라 필터링된 list2 생성
	ArrayList<Pirate> list2 = new ArrayList<Pirate>();
	
	// 요청값 디버깅
	System.out.println(request.getParameter("gender"));
	
	char gender = ' '; // char은 한 글자이므로 '' 입력 불가 
	if (request.getParameter("gender") != null) 
			/* || !request.getParameter("gender").equals("")) */ {
		gender = request.getParameter("gender").charAt(0); // 첫 번째 문자만 출력
	}
			
	// gender ' ' or 'M' or 'F'
/* 	if (gender == ' ') {
		list2 = list;
	} else if (gender == 'M'){
		for (Pirate p : list){
			if (p.gender == 'M') {
				list2.add(p);
			}
		}
	} else { // gender = 'F'
		for (Pirate p : list){
			if (p.gender == 'F') {
				list2.add(p);
			}
		}
	} */
	
	if (gender == ' ') {
		list2 = list;
	} else {
		for (Pirate p : list) {
			if (p.gender == gender) {
				list2.add(p);
			}
		}
	}
	
	System.out.println(list2.size() + " <-- list.size()" );
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Pirate</title>
		<style>
			table, th, td {
				border-collapse: collapse;
				text-align: center;
			}
		</style>
	</head>
	<body>
		<h1>등장인물 리스트</h1>
		
		<form action="./onepiece.jsp" method="post">
			<select name="gender">
				<!-- <option value="">:::성별 선택:::</option> -->
				<option value="M">남자</option>
				<option value="F">여자</option>
			</select>
			<div>
				<button type="submit">검색</button>
			</div>
		
		
		<table border="1">
			<tr>
				<th>이름</th>
				<th>별명</th>
				<th>성별</th>
				<th>생일</th>
				<th width="45">나이</th>
				<th width="45">키</th>
				<th>취미</th>
				<th width="70">혈액형</th>
				<th>출신지</th>
				<th width="70">현상금</th>
				<th>소속 해적단</th>
				<th>악마의 열매</th>
			</tr>
		<%
			for (Pirate e : list2) { // 리스트 변경
		%>		
			<tr>
				<td><%=e.name%></td>
				<td><%=e.nickName%></td>	
		<% 
				if (e.gender == 'M') {
		%>			
				<td><img src="./img/man.jpg" width="100" height="100"></td>
		<% 		
				} else {
		%>
				<td><img src="./img/woman.jpg" width="100" height="100"></td>
		<%
				}
		%>		
				<td><%=e.birth%></td>
				<td><%=e.age%></td>
				<td><%=e.height%></td>
				<td>	
	 		<%	
				if (e.hobby != null) {
					int cnt = 1;
					for (String h : e.hobby) {
		%>				
						<%=h%>			
		<%				
					if (cnt < e.hobby.size()) {
		%>
								,
		<%					
						}
						cnt = cnt + 1;
					} 
				}	
		%> 		</td>
				<td><%=e.blood%></td>
				<td><%=e.country%></td>
				<td><%=e.money%>베리</td>
				<td><%=e.group%></td>	
			<%	
				if (e.isDevilFruit == true) {		
			%>
				<td><img src="./img/fruit.jpg" width="100" height="100"></td>
			<%	
				} else {
			%>		
				<td>&nbsp;</td>
			<%
				}
			%>
			</tr>	
		<%		
			}
		%>
		</table>
	</form>
	</body>
</html>