package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// C, D -> 로그인 된 상태에서만 접근 가능..  ex) session.getAttribute("id") == null -> redirect
@WebServlet("/on/D")
public class D extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(this.getClass() + ", " + request.getRequestURL());
	}
}