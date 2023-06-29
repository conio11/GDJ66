package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("name", "goodee"); // name이라는 이름으로 goodee라는 값을 요청의 속성에 설정 -> 다른 서블릿이나 JSP에서 해당 속성에 접근 가능
		
		// response.sendRedirect(request.getContextPath() + "/HomeServlet.jsp");
	
		// forward
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/HomeServlet.jsp"); // 포워드 수행 ->  현재의 서블릿 제어를 "/WEB-INF/view/HomeServlet.jsp"로 전달, 해당 JSP 페이지의 실행 결과를 클라이언트에게 반환
		// rd.include(request, response); // servlet도 같이 넘어온 형태
		rd.forward(request, response); // servlet은 걸러짐?, jsp 파일만	
	}
}