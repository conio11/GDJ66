package cash.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cash.model.CashbookDao;
import cash.vo.Cashbook;
import cash.vo.Member;

@WebServlet("/cashbookListOne")
public class CashbookListOneController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// session 유효성 검사
		String msg = "";
		HttpSession session = request.getSession();
		if (session.getAttribute("loginMember") == null) {
			msg = URLEncoder.encode("로그인 후 이용 가능합니다.", "UTF-8"); 
			response.sendRedirect(request.getContextPath() + "/login?msg=" + msg);
			return;
		}
		Member loginMember = (Member) session.getAttribute("loginMember");
		String loginMemberId = loginMember.getMemberId();
		System.out.println(loginMemberId + " <-- loginMemberId(CashbookListOneGet)");

		// targetYear, targetMonth, targetDate 중 하나라도 넘어오지 않았을 경우 calendar 컨트롤러로 리다이렉트
		if (request.getParameter("targetYear") == null
		|| request.getParameter("targetMonth") == null
		|| request.getParameter("targetDate") == null) {
			response.sendRedirect(request.getContextPath() + "/calendar");
			return; 
		}
		
		int targetYear = Integer.parseInt(request.getParameter("targetYear"));
		int targetMonth = Integer.parseInt(request.getParameter("targetMonth"));
		int targetDate = Integer.parseInt(request.getParameter("targetDate"));
		
		System.out.println(targetYear + " <-- targetYear(CashbookListOneGet)");
		System.out.println(targetMonth + " <-- targetMonth(CashbookListOneGet)");
		System.out.println(targetDate + " <-- targetDate(CashbookListOneGet)");
		
		// 모델값 구하기
		CashbookDao cashbookDao = new CashbookDao();
		List<Cashbook> list = cashbookDao.selectCashbookListByCashbookDate(loginMemberId, targetYear, targetMonth + 1, targetDate);
		
		// 날짜별 수입, 지출 내역을 출력하는 view
		// view에 넘길 값들을 request 속성에 저장
		request.setAttribute("targetYear", targetYear);
		request.setAttribute("targetMonth", targetMonth);
		request.setAttribute("targetDate", targetDate);
		request.setAttribute("list", list);
		
		// cashbookListOne.jsp 포워딩
		request.getRequestDispatcher("/WEB-INF/view/cashbookListOne.jsp").forward(request, response);
	}
}