package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 로그인 상태가 아닌 경우  ex) if (session.getAttribute("id") != null) -> redirect
@WebServlet("/off/A")
public class A extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(this.getClass() + ", " + request.getRequestURL()); // class controller.A, http://localhost:8088/transaction-test/off/A
	}
}