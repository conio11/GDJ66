package vo;
// notice 테이블의 한 행(레코드)을 저장하기 위한 목적
// * 여러 레코드의 모음: 레코드셋
// VO - Value Object (값 객체)
// DTO - Data Transfer object or Domain (데이터 전송 객체)
// Domain
public class Notice {	
	public int noticeNo; // SQL 내 데이터와 변수명 호환되지 않는 문제(대소문자 구분 관련) -> alias, 카멜 표기법 사용 등
	public String noticeTitle;
	public String noticeContent;
	public String noticeWriter;
	public String createdate;
	public String updatedate;
	public String noiticePw;
}
