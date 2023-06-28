package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/hello.goodee")
public class MyServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { // protected: 톰캣만 요청 가능
		// super.doGet(req, resp);
		// System.out.println("hello MyServlet!");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter(); // out에 들어가는 내용 -> html
		String title = "Goodee";
		String html = "<html><head><body><h1>hello " + title + "</h1></body></head></html>";
		out.print(html);
		
		HttpSession s = request.getSession();
	}
}


// 톰캣 안에 servlet