<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 	// 컴퓨터 언어 : 데이터(값) + 기능(연산, 함수)
	// 값 : 숫자(1, 3, 10, ...), 내부적으로 숫자 맵핑된 문자 하나('A', 'B', 가'), 맵핑 논리값(true, false)
	// 값 연산 (피연산자의 타입 동일) : +, -, *, /, %, >, <, &&, ||, ...
	// 변수 : 값을 저장했다 재사용하기 위해 할당연산자(=, +=)
	// 타입(자료형) : 변수와 값의 범위(모양) 일치
	// byte(1byte), short(2byte), int(4byte), long(8byte), float(4byte), double(8byte)
	// char(2byte), boolean(true, false) -> 변수에 데이터값 저장
	// wrapper 타입 : 기본타입과 동일한 참조타입
	
	// 기본타입(단일 데이터 값, 스칼라) vs 참조타입(복수 데이터 값, 집합, 벡터)
	// 배열 : 자료형 같은 여러 데이터값의 집합, 배열참조변수 -> 인덱스, []연산자 -> 개별값에 접근
	// String[] names = new String[3]; names[2] = "홍길동";
	// 클래스(1) : 사용자 정의 타입, 여러 자료형을 가진 데이터값의 집합, 객체참조변수 -> 필드(멤버변수) 이름, .연산자 -> 개별값에 접근
	// Person p = new Person(); p.name = "홍길동";
	// 클래스(2) : 메소드의 정의를 가지는 명세
	// 메소드 : 클래스 안에 정의된 함수, 입력값을 받아 기능을 실행하고 반환값을 남기는 표현식 -> 연산자
	// 일반 메소드 vs static 메소드
	// ex) 일반 메소드 A a = new A(); a.test();
	// ex) static 메소드 A.test();
	// 코드실행문장 위 -> 아래
	// 문장에서 제어문 가능 : 분기문(조건문, if, switch, try...catch), 루프문(반복문 - while, for, for-each)
	
	// 기본 라이브러리(API), 외부 라이브러리(API)
	System.out.println("hello");
%>