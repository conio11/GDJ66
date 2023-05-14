package vo;

// 정보은닉 + 캡슐화 적용
public class Board { // 게시글 테이블
	private int boardNo; // 게시글 번호 - 기본키
	private String localName; // 지역명(카테고리명) - 외래키(local 테이블)
	private String boardTitle; // 게시글 제목
	private String boardContent; // 게시글 내용
	private String memberID; // 게시글 작성자 - 외래키(member 테이블)
	private String createdate; // 게시글 생성일자
	private String updatedate; // 게시글 수정일자
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getLocalName() {
		return localName;
	}
	public void setLocalName(String localName) {
		this.localName = localName;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public String getMemberID() {
		return memberID;
	}
	public void setMemberID(String memberID) {
		this.memberID = memberID;
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
