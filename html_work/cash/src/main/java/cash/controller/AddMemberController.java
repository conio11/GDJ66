package cash.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cash.model.MemberDao;
import cash.vo.Member;
import java.net.*;

@WebServlet("/addMember")
public class AddMemberController extends HttpServlet {
	// addMember.jsp (회원가입 폼)으로 이동
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet");
		// session 유효성 검사 
		HttpSession session = request.getSession();
		// 로그인 상태이면 cashbook.jsp로 이동
		if (session.getAttribute("loginMember") != null) {
			response.sendRedirect(request.getContextPath() + "/cashbook");
			return;
		}
	
		// jsp 페이지로 포워드(디스패치)
		request.getRequestDispatcher("/WEB-INF/view/addMember.jsp").forward(request, response);
	}

	// 회원가입 액션
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		// session 유효성 검사 
		HttpSession session = request.getSession();
		// 로그인 상태이면 cashbook.jsp로 이동
		if (session.getAttribute("loginMember") != null) { 
			response.sendRedirect(request.getContextPath() + "/cashbook");
			return;
		}
		
		// request.getParameter()
		Member member = new Member();
		String memberId = request.getParameter("memberId");
		String memberPw = request.getParameter("memberPw");
		member.setMemberId(memberId);
		member.setMemberPw(memberPw);
		
		// 회원가입 DAO 호출
		MemberDao memberDao = new MemberDao(); 
		String msg = "";
		int check = memberDao.checkId(memberId);
		System.out.println(check + " <-- check(AddMemberController)");
		if (check == 1) {
			System.out.println("중복된 ID");
			msg = URLEncoder.encode("사용 중인 ID입니다. 다시 입력해주세요.", "UTF-8"); 
			response.sendRedirect(request.getContextPath() + "/addMember?msg=" + msg);
			return;
		}
		
		int row = memberDao.insertMember(member);
		System.out.println(row + " <-- row(AddMemberController)");
		if (row == 0) { // 회원가입 실패 시 
			// addMember.jsp view 이동
			response.sendRedirect(request.getContextPath() + "/addMember");
			return;
		} else if (row == 1) {
			System.out.println("회원가입 성공");
			// 회원가입 성공 시 login.jsp로 이동 -> controller 리다이렉트
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		} else {
			System.out.println("add member error!");
		}
	}
}