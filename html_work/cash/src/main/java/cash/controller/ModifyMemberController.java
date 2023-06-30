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

@WebServlet("/modifyMember")
public class ModifyMemberController extends HttpServlet {
	// 회원정보수정 폼으로 이동
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// session 유효성 검사
		HttpSession session = request.getSession();
		// 로그인 상태가 아니면 로그인 컨트롤러(-> login.jsp)로 이동
		if (session.getAttribute("loginMember") == null ) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		// 로그인 상태이면 modifyMember.jsp로 이동
		request.getRequestDispatcher("/WEB-INF/view/modifyMember.jsp").forward(request, response);
	}
	
	// 회원정보수정 액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// session 유효성 검사
		HttpSession session = request.getSession();
		// 로그인 상태가 아니면 로그인 컨트롤러(-> login.jsp)로 이동
		if (session.getAttribute("loginMember") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		String memberPw = request.getParameter("memberPw");
		
		String newPw1 = request.getParameter("newPw1");
		String newPw2 = request.getParameter("newPw2");
		
		String newPw = null;
		String msg = "";
		if (newPw1.equals(newPw2)) {
			newPw = newPw1;
		} else {
			System.out.println("새 비밀번호 일치하지 않음");
			msg = URLEncoder.encode("비밀번호 변경 실패. 현재 비밀번호를 확인해주세요.", "UTF-8"); 
			response.sendRedirect(request.getContextPath() + "/modifyMember?msg=" + msg);
			return;
		}
		
		// 모델값 구하기
		MemberDao memberDao = new MemberDao();
		
		int row = memberDao.modifyMember(memberId, memberPw, newPw);
		System.out.println(row + " <-- row(ModifyMemberController)");
		
		if (row == 1) {
			System.out.println("비밀번호 변경 성공");
			// 페이지 이동
			msg = URLEncoder.encode("비밀번호가 변경되었습니다.", "UTF-8"); 
			response.sendRedirect(request.getContextPath() + "/cashbook?msg=" + msg);
		} else if (row == 0) {
			System.out.println("비밀번호 변경 실패. 현재 비밀번호 확인");
			msg = URLEncoder.encode("비밀번호 변경 실패. 현재 비밀번호를 확인해주세요.", "UTF-8"); 
			response.sendRedirect(request.getContextPath() + "/modifyMember?msg=" + msg);
		} else {
			System.out.println("modify member error!");
		}
	}
}