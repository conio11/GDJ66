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
import cash.vo.Cashbook;
import cash.vo.Member;

@WebServlet("/modifyCashbook")
public class ModifyCashbookController extends HttpServlet {
	// 가계부 수정 jsp 파일로 이동
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
		System.out.println(memberId + " <-- memberId(modifyCashbookGet)");
		
		CashbookDao cashbookDao = new CashbookDao();
		
		int targetYear = Integer.parseInt(request.getParameter("targetYear"));
		System.out.println(targetYear + " <-- targetYear(modifyCashbookGet)");
		
		int targetMonth = Integer.parseInt(request.getParameter("targetMonth"));
		System.out.println(targetMonth + " <-- targetMonth(modifyCashbookGet)");
		
		int targetDate = Integer.parseInt(request.getParameter("targetDate"));
		System.out.println(targetDate + " <-- targetDate(modifyCashbookGet)");
		
		int cashbookNo = Integer.parseInt(request.getParameter("cashbookNo"));
		System.out.println(cashbookNo + " <-- cashbookNo(modifyCashbookGet)");

		Cashbook cashbook = new Cashbook();
		cashbook = cashbookDao.selectCashbookOneByCashbookNo(cashbookNo);
		
		request.setAttribute("targetYear", targetYear);
		request.setAttribute("targetMonth", targetMonth);
		request.setAttribute("targetDate", targetDate);
		request.setAttribute("cashbook", cashbook);
		
		request.getRequestDispatcher("/WEB-INF/view/modifyCashbook.jsp").forward(request, response);
	
	}

	// 가계부 수정 액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// post 방식 인코딩 설정
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
		System.out.println(memberId + " <-- memberId(modifyCashbookGet)");
		
		int targetYear = Integer.parseInt(request.getParameter("targetYear"));
		int targetMonth = Integer.parseInt(request.getParameter("targetMonth"));
		int targetDate = Integer.parseInt(request.getParameter("targetDate"));
		
		System.out.println(targetMonth + " <-- targetMonth(modifyCashbookPost)");
		System.out.println(targetYear + " <-- targetYear(modifyCashbookPost)");
		System.out.println(targetDate + " <-- targetDate(modifyCashbookPost)");
		
		CashbookDao cashbookDao = new CashbookDao();
		
		int cashbookNo = Integer.parseInt(request.getParameter("cashbookNo"));
		String category = request.getParameter("category");
		int price = Integer.parseInt(request.getParameter("price"));
		
		System.out.println(cashbookNo + " <-- cashbookNo(modifyCashbookPost)");
		System.out.println(category + " <-- category(modifyCashbookPost)");
		System.out.println(price + " <-- price(modifyCashbookPost)");
		
		int row = cashbookDao.modifyCashbook(category, price, cashbookNo);
		System.out.println(row + " <-- row(modifyCashbookPost)");
		
		if (row == 1) {
			System.out.println("가계부 수정 성공");
			msg = URLEncoder.encode("수정이 완료되었습니다.", "UTF-8"); 
			response.sendRedirect(request.getContextPath() + "/cashbookListOne?targetYear=" + targetYear + "&targetMonth=" + targetMonth + "&targetDate=" + targetDate + "&msg=" + msg);
			
		} else if (row == 0) {
			System.out.println("가계부 수정 실패");
			msg = URLEncoder.encode("수정에 실패했습니다. 다시 시도해 주세요.", "UTF-8"); 
			response.sendRedirect(request.getContextPath() + "/cashbookListOne?targetYear=" + targetYear + "&targetMonth=" + targetMonth + "&targetDate=" + targetDate + "&msg=" + msg);
		} else {
			System.out.println("modify cashbook error!");
		}
		
		
	}

}
