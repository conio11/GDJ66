package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.CounterService;


@WebServlet("/home")
public class HomeController extends HttpServlet {
	private CounterService counterService = null; 
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.counterService = new CounterService();
		int counter = counterService.getCounter(); 
		int totalCounter = counterService.getCounterAll();
		
		request.setAttribute("counter", counter);
		request.setAttribute("totalCounter", totalCounter);
		 
		request.getRequestDispatcher("/WEB-INF/view/home.jsp").forward(request, response);
	}
}