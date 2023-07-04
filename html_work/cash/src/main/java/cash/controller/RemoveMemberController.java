package cash.controller;

import java.io.IOException;
import java.net.URLEncoder;

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
		String msg = "";
		if (session.getAttribute("loginMember") == null) {
			msg = URLEncoder.encode("로그인 후 이용 가능합니다.", "UTF-8"); 
			response.sendRedirect(request.getContextPath() + "/login?msg=" + msg);
			return;
		}
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		System.out.println(memberId + " <-- memberId(removeMemberGet)");
		
		
		request.getRequestDispatcher("/WEB-INF/view/removeMember.jsp").forward(request, response);
	}

	// 탈퇴 액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		String memberPw = request.getParameter("memberPw");
		System.out.println(memberId + " <-- memberId(removeMemberPost)");
		System.out.println(memberPw + " <-- memberPw(removeMemberPost)");
		
		// 모델값 구하기
		MemberDao memberDao = new MemberDao();
		
		int row = memberDao.deleteMember(memberId, memberPw);
		System.out.println(row + " <-- row(RemoveMemberController)");
		if (row == 1) { // 탈퇴 성공 -> 세션 삭제
			System.out.println("회원 탈퇴 성공");
			msg = URLEncoder.encode("회원 탈퇴가 완료되었습니다.", "UTF-8"); 
			session.invalidate();
			
			// 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath() + "/login?msg=" + msg);
			
		} else if (row == 0) { 
			System.out.println("회원 탈퇴 실패");
			msg = URLEncoder.encode("회원 탈퇴 실패. 정확한 비밀번호를 입력해주세요.", "UTF-8"); 
			response.sendRedirect(request.getContextPath() + "/removeMember?msg=" + msg);
		} else {
			System.out.println("remove member error!");
		}		
	}
}