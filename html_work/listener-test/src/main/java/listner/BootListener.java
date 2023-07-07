package listner;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;


@WebListener
public class BootListener implements ServletContextListener {
    public void contextDestroyed(ServletContextEvent sce)  { 

    }

    // 디폴트 메소드
    
    public void contextInitialized(ServletContextEvent sce)  {  // 애플리케이션 가져오는 부분
    	// 톰캣이 실행되면 켜짐 -> 다른 프로젝트 영향 가능성
    	// 다른 프로젝트 서버에서 지우고 실행
    	System.out.println("실행 확인: ServletContextListener.contextInitialized()"); // 서버 start -> 출력
    	
    	// application 속성 영역에 "currentCounter" 속성변수 초기화
    	ServletContext application = sce.getServletContext();
    	application.setAttribute("currentCounter", 0);
    	
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
    	} catch (ClassNotFoundException e) {
    		System.out.println("MariaDB 드라이버 로딩 실패");
    		e.printStackTrace();
    	}
    	System.out.println("드라이버 로딩 성공");
    	
    }	
}
