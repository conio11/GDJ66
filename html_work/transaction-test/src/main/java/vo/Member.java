package vo;

public class Member {
	private String memberId;
	private String memberPw;
	private String updatedate;
	private String createdate;

	public Member() { // 다른 생성자가 존재할 경우 디폴트 생성자를 따로 만들지 않으면 디폴트 생성자 사용 불가
		super();
	}
	
	public Member(String memberId, String memberPw, String createdate, String updatedate) {
		super();
		this.memberId = memberId;
		this.memberPw = memberPw;
		this.createdate = createdate;
		this.updatedate = updatedate;
	}

	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", memberPw=" + memberPw + ", createdate=" + createdate
				+ ", updatedate=" + updatedate + "]";
	}

	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPw() {
		return memberPw;
	}
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
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
