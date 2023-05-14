package vo;

// 정보은닉 + 캡슐화 적용
public class Comment { // 댓글 테이블
	private int commentNo; // 댓글 번호 - 기본키
	private int boardNo; // 게시글 번호 - 외래키(board 테이블)
	private String commentContent; // 댓글 내용
	private String memberID; // 댓글 작성자 - 외래키(member 테이블)
	private String createdate; // 댓글 생성일자
	private String updatedate; // 댓글 작성일자
	
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
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
