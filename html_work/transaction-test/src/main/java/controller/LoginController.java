package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.MemberDao;
import vo.Member;

@WebServlet("/login")
public class LoginController extends HttpServlet {
	// 로그인 폼
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/login.jsp");
		
		// 쿠키에 저장된 아이디가 있다면 request 속성에 저장
		Cookie[] cookies = request.getCookies();
		
		if (cookies != null) {
			for (Cookie c : cookies) {
				if (c.getName().equals("loginId") == true) {
					request.setAttribute("loginId", c.getValue());
				}
			}
		}
		
		rd.forward(request, response);
	}

	// 로그인 액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 호출: LoginService.login() -> LoginDao.login()
		// 반환 모델값 <- LoginService.login() <- LoginDao.login()
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/home.jsp");
		
		// final String loginId = "admin";
		// final String loginPw = "1234";

		String id = request.getParameter("id"); 
		String pw = request.getParameter("pw"); 
		
		Member member = new Member();
		member.setMemberId(id);
		member.setMemberPw(pw);
		
		MemberDao memberDao = new MemberDao();
		
		Member loginMember = memberDao.selectByMemberId(member);
		
		/*
		if ((id.equals(loginId) && pw.equals(loginPw)) == false) { // () 사용 주의 // 또는 전체 조건에 !
			// 로그인 실패
			
			// redirect보다 forward보다 좋음. 실패 정보(메시지 등)를 넘기기 용이 (request)
			response.sendRedirect(request.getContextPath() + "/login"); // request.getContextPath() 생략될 경우 root 경로 
			return; 
		} 
		
		*/
		
		// 로그인 실패
		if (loginMember == null) {
			System.out.println("로그인 실패(LoginPost)");
			response.sendRedirect(request.getContextPath() + "/login");  
			return; 
		}
		
		// 로그인 성공
		// 로그인 정보 세션 저장
		HttpSession session = request.getSession();
		System.out.println("로그인 성공(LoginPost)");
		session.setAttribute("loginMember", loginMember);
		
		//로그인 id를 쿠키(만료기간 설정)에 저장 -> name: loginId
		// idSave 체크 값이 넘어왔다면 
		if (request.getParameter("idSave") != null) {
			Cookie loginIdCookie = new Cookie("loginId", id); // 쿠키 하나가 Map // 매개변수 없는 디폴트 생성자 사용 불가 -> new Cookie(String, String) 형태 -> properties
			loginIdCookie.setMaxAge(10); // 초단위 (ms X) // 60 * 60 * 24 -> 24시간
			response.addCookie(loginIdCookie);
		}
		
		// 로그인 성공 페이지로 redirect
		// response.sendRedirect(request.getContextPath() + "/home");
		rd.forward(request, response);
	}
}