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

@WebFilter("/*") // 가장 먼저 실행되는 필터 // 클래스 파일이 실행될 때마다 실행?
public class EncodingFilter extends HttpFilter implements Filter {
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.out.println("전"); // 모든 요청 전에 실행 // 필터링 전에 실행되는 부분
		
		request.setCharacterEncoding("UTF-8");
		
		chain.doFilter(request, response); // 필터링 // request는 doFilter 이전에 처리 -> 여기서 doFilter 실행과 함께 흐름이 서블릿으로 넘어감
		
		System.out.println("후"); // 필터링 이후 서블릿을 거친 뒤 브라우저로 response 전달되기 전에 실행되는 부분
	}
}