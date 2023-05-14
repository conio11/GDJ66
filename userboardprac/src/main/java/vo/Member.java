package vo;

// 정보은닉 + 캡슐화 적용
public class Member { // 회원 테이블
	private String memberID; // 회원 아이디
	private String memberPW; // 회원 비밀번호
	private String createdate; // 회원정보 생성일자
	private String updatedate; // 회원정보 수정일자
	
	public String getMemberID() {
		return memberID;
	}
	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}
	public String getMemberPW() {
		return memberPW;
	}
	public void setMemberPW(String memberPW) {
		this.memberPW = memberPW;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
}
