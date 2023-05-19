<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.io.*"%>
<%
	// 업로드 위치
	String dir = request.getServletContext().getRealPath("/upload");
	System.out.println(dir + " <-- dir(addBoardAction)");
	
	// 최대 용량 (100Mb)
	int max = 10 * 1024 * 1024;
	
	// request 객체를 MultipartRequest의 API를 사용할 수 있도록 래핑
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "UTF-8", new DefaultFileRenamePolicy()); // new DefaultFileRenamePolicy(): 중복값 방지
	
	// MultipartRequest API를 사용하여 스트림 내에서 문자값을 반환받을 수 있음
	
	// 업로드 파일이 pdf 파일이 아니면
	if (mRequest.getContentType("boardFile").equals("application/pdf") == false) {
		// 위에서 저장된 파일을 삭제
		System.out.println("PDF 파일이 아닙니다.");
		String saveFilename = mRequest.getFilesystemName("boardFile");
		File f = new File(dir + "\\" + saveFilename); // 경로(dir) 없으면 파일 찾을 수 없음
		if (f.exists()) {
			f.delete();
			System.out.println(saveFilename + " 파일 삭제");
		}
		return; // 실행 종료
	}
	
	// 1) input type="text" 반환 API -> board 테이블 저장
	String boardTitle = mRequest.getParameter("boardTitle");
	String memberID = mRequest.getParameter("memberID");
	
	System.out.println(boardTitle + " <-- boardTitle(addBoardAction)");
	System.out.println(memberID + " <-- memberID(addBoardAction)");
	
	Board board = new Board();
	board.setBoardTitle(boardTitle);
	board.setMemberID(memberID);
	
	// 2) input type="file" 값(파일 메타 정보) 반환 API (원본 파일 이름, 저장된 파일 이름, 컨텐츠 타입)
	// -> board_file 테이블 저장
	// 파일(바이너리)은 이미 MultipartRequest 객체 생성 시 (request 랩핑 시, 16라인) 먼저 저장
	String type = mRequest.getContentType("boardFile");
	String originFilename = mRequest.getOriginalFileName("boardFile");
	String saveFilename = mRequest.getFilesystemName("boardFile");
	
	System.out.println(type + " <-- type(addBoardAction)");
	System.out.println(originFilename + " <-- originFilename(addBoardAction)");
	System.out.println(saveFilename + " <-- saveFilename(addBoardAction)");
	
	BoardFile boardFile = new BoardFile();
	// boardFile.setBoardNo(boardNo)
	boardFile.setType(type);
	boardFile.setOriginFilename(originFilename);
	boardFile.setSaveFilename(saveFilename);
	
	System.out.println("================================================");	
%>