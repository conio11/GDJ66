package vo;

public class Member {
	private int memberID;
	private String memberPW;
	private String memberName;
	private int memberBirth;
	
	public int getMemberID() {
		return memberID;
	}
	public void setMemberID(int memberID) {
		this.memberID = memberID;
	}
	public String getMemberPW() {
		return memberPW;
	}
	public void setMemberPW(String memberPW) {
		this.memberPW = memberPW;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public int getMemberBirth() {
		return memberBirth;
	}
	public void setMemberBirth(int memberBirth) {
		this.memberBirth = memberBirth;
	}
}