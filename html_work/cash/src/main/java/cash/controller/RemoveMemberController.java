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

@WebServlet("/removeMember")
public class RemoveMemberController extends HttpServlet {
	// 회원 탈퇴 폼으로 이동
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// session 유효성 검사
		HttpSession session = request.getSession();
		if (session.getAttribute("loginMember") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		request.getRequestDispatcher("/WEB-INF/view/removeMember.jsp").forward(request, response);
	}

	// 탈퇴 액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// session 유효성 검사
		HttpSession session = request.getSession();
		if (session.getAttribute("loginMember") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		String memberPw = request.getParameter("memberPw");
		
		// 모델값 구하기
		MemberDao memberDao = new MemberDao();
		
		int row = memberDao.deleteMember(memberId, memberPw);
		System.out.println(row + " <-- row(RemoveMemberController)");
		if (row == 1) { // 탈퇴 성공 -> 세션 삭제
			System.out.println("회원 탈퇴 성공");
			session.invalidate();
			
			// 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath() + "/login");
			
		} else if (row == 0) { // 
			System.out.println("회원 탈퇴 실패");
		} else {
			System.out.println("remove member error!");
		}		
	}
}