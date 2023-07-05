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
import cash.vo.Member;

@WebServlet("/removeCashbook")
public class RemoveCashbookController extends HttpServlet {
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
		System.out.println(memberId + " <-- memberId(removeCashbookGet)");
		
		CashbookDao cashbookDao = new CashbookDao();
		
		int targetYear = Integer.parseInt(request.getParameter("targetYear"));
		int targetMonth = Integer.parseInt(request.getParameter("targetMonth"));
		int targetDate = Integer.parseInt(request.getParameter("targetDate"));
		
		System.out.println(targetYear + " <-- targetYear(RemoveCashbookPost)");
		System.out.println(targetMonth + " <-- targetMonth(RemoveCashbookPost)");
		System.out.println(targetDate + " <-- targetDate(RemoveCashbookPost)");
		
		int cashbookNo = Integer.parseInt(request.getParameter("cashbookNo"));
		System.out.println(cashbookNo + " <-- cashbookNo(RemoveCashbookPost)");
		
		int row = cashbookDao.removeCashbook(cashbookNo);
		System.out.println(row + " <-- row(RemoveCashbookPost)");
		
		if (row == 1) {
			System.out.println("가계부 삭제 성공");
			msg = URLEncoder.encode("삭제되었습니다.", "UTF-8"); 
			response.sendRedirect(request.getContextPath() + "/cashbookListOne?targetYear=" + targetYear + "&targetMonth=" + targetMonth + "&targetDate=" + targetDate + "&msg=" + msg);
		} else if (row == 0) {
			System.out.println("가계부 삭제 실패");
			msg = URLEncoder.encode("삭제에 실패했습니다.", "UTF-8");
			response.sendRedirect(request.getContextPath() + "/cashbookListOne?targetYear=" + targetYear + "&targetMonth=" + targetMonth + "&targetDate=" + targetDate + "&msg=" + msg);
		} else {
			System.out.println("remove cashbook error!");
		}
	}
}