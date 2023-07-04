package cash.controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cash.model.CashbookDao;
import cash.model.HashtagDao;
import cash.vo.Cashbook;
import cash.vo.Hashtag;
import cash.vo.Member;

@WebServlet("/addCashbook")
public class AddCashbookController extends HttpServlet {
	// 입력폼
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// session 유효성 검사
		HttpSession session = request.getSession();
		String msg = "";
		if (session.getAttribute("loginMember") == null) {
			msg = URLEncoder.encode("로그인 후 이용 가능합니다.", "UTF-8"); 
			response.sendRedirect(request.getContextPath() + "/login?msg=" + msg);
			return;
		}
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		System.out.println(memberId + " <-- memberId(AddCashbookGet)");
		
		// request 매개값 - 날짜
		int targetYear = Integer.parseInt(request.getParameter("targetYear"));
		int targetMonth = Integer.parseInt(request.getParameter("targetMonth"));
		int targetDate = Integer.parseInt(request.getParameter("targetDate"));
		
		System.out.println(targetYear + " <-- targetYear(AddCashbookGet)");
		System.out.println(targetMonth + " <-- targetMonth(AddCashbookGet)");
		System.out.println(targetDate + " <-- targetDate(AddCashbookGet)");
		
		request.setAttribute("targetYear", targetYear);
		request.setAttribute("targetMonth", targetMonth);
		request.setAttribute("targetDate", targetDate);
		
		// 나머지 데이터는 입력 폼에서 사용자가 입력
		request.getRequestDispatcher("/WEB-INF/view/addCashbook.jsp").forward(request, response);
	}

	// 입력 액션
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// session 유효성 검사
		HttpSession session = request.getSession();
		String msg = "";
		if (session.getAttribute("loginMember") == null) {
			msg = URLEncoder.encode("로그인 후 이용 가능합니다.", "UTF-8"); 
			response.sendRedirect(request.getContextPath() + "/login?msg=" + msg);
			return;
		}
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		System.out.println(memberId + " <-- memberId(AddCashbookPost)");
		
		Cashbook cashbook = new Cashbook();
		CashbookDao cashbookDao = new CashbookDao();
		
		// request 매개값
		String category = request.getParameter("category");
		int price = Integer.parseInt(request.getParameter("price"));
		String memo = request.getParameter("memo");
		
		System.out.println(category + " <-- category(AddCashbookPost)");
		System.out.println(price + " <-- price(AddCashbookPost)");
		System.out.println(memo + " <-- memo(AddCashbookPost)");
		
		int targetYear = Integer.parseInt(request.getParameter("targetYear"));
		int targetMonth = Integer.parseInt(request.getParameter("targetMonth")) + 1;
		int targetDate = Integer.parseInt(request.getParameter("targetDate"));
		
		System.out.println(targetYear + " <-- targetYear(AddCashbookPost)");
		System.out.println(targetMonth + " <-- targetMonth(AddCashbookPost)");
		System.out.println(targetDate + " <-- targetDate(AddCashbookPost)");
		
		String strTargetYear = "" + targetYear;
		String strTargetMonth = "" + targetMonth; 
		String strTargetDate = "" + targetDate; 
		
		if (targetMonth < 10) {
			strTargetMonth = "0" + strTargetMonth;
		}
		
		if (targetDate < 10) {
			strTargetDate = "0" + strTargetDate;
		}
		
		System.out.println(strTargetYear + " <-- strTargetYear(AddCashbookPost)");
		System.out.println(strTargetMonth + " <-- strTargetMonth(AddCashbookPost)");
		System.out.println(strTargetDate + " <-- strTargetDate(AddCashbookPost)");
		
		String cashbookDate = strTargetYear + "-" + strTargetMonth + "-" + strTargetDate;
		System.out.println(cashbookDate + " <-- cashbookDate(AddCashbookPost)");
		
		cashbook.setMemberId(memberId);
		cashbook.setCategory(category);
		cashbook.setCashbookDate(cashbookDate);
		cashbook.setPrice(price);
		cashbook.setMemo(memo);
		
		int cashbookNo = cashbookDao.insertCashbook(cashbook); // 키값 반환 
		System.out.println(cashbookNo + " <-- cashbookNo(AddCashbookPost)");
		
		if (cashbookNo == 0) { // 0 반환 시 입력 실패
			System.out.println("입력 실패");
			response.sendRedirect(request.getContextPath() + "/addCashbook");
			return;
		}
		
		// 입력 성공 -> 해시태그가 있다면 -> 해시태그 추출 -> 해시태그 입력(반복)
		// 해시태그 추출 알고리즘
		// # # 구디 #구디 #자바
		HashtagDao hashtagDao = new HashtagDao(); 
		
		String memo1 = cashbook.getMemo();
		System.out.println(memo1 + " <-- memo1(AddCashbookPost)");
		
		String memo2 = memo1.replace("#", " #"); // "#구디#아카데미" -> " #구디 #아카데미"
		System.out.println(memo2 + " <-- memo2(AddCashbookPost)");
		// 해시태그가 여러 개이면 반복해서 입력
		for (String ht : memo2.split(" ")) {
			if (ht.contains("#")) {
				String ht2 = ht.replace("#", ""); // # 삭제
				if (ht2.length() > 0) {
					Hashtag hashtag = new Hashtag();
					hashtag.setCashbookNo(cashbookNo);
					hashtag.setWord(ht2);
					hashtagDao.insertHashtag(hashtag);
					System.out.println("해시태그 입력 성공(AddCashbookPost)");
				}
			}
		}
		
		// redirect -> cashbookListOneListController
		response.sendRedirect(request.getContextPath() + "/cashbookListOne?targetYear=" + targetYear + "&targetMonth=" + (targetMonth - 1) + "&targetDate=" + targetDate);
	}
}