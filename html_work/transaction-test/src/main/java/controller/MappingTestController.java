package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/test")
public class MappingTestController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(request.getRequestURL() + " <-- 요청 URL"); // http://localhost:8084/transaction-test/a <-- 요청 URL
		// @WebServlet("/*") 설정 시 주소창 / 이후 내용 자유롭게 입력 가능	
	}
}