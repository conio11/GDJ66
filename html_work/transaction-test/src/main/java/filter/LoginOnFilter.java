package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


// servlet C, D -> 로그인 된 상태에서만 접근 가능  ex) session.getAttribute("id") == null -> redirect
@WebFilter("/on/*")
public class LoginOnFilter extends HttpFilter implements Filter {
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.out.println("/on/* 전");
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session = req.getSession();
		
		if (session.getAttribute("id") == null) {
			HttpServletResponse rep = (HttpServletResponse) response;
			rep.sendRedirect(req.getContextPath() + "/home");
			return;
		}
		
		chain.doFilter(request, response);
	}
}