package vo;

// 정보은닉 + 캡슐화 적용
public class Local { // 지역(카테고리) 테이블
	private String localName; // 지역명
	private String createdate; // 지역명 생성일자
	private String updatedate; // 지역명 수정일자

	public String getLocalName() {
		return localName;
	}
	public void setLocalName(String localName) {
		this.localName = localName;
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