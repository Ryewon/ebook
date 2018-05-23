package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthenticationInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if(request.getSession().getAttribute("authInfo") == null ) { 
			//로그인페이지로 redirect 
			response.sendRedirect("/ebook/login");	
			return false; 
		} else {
			return true;
		}
	}
	
//	@Override
//	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
//			ModelAndView modelAndView) throws Exception {
//		System.out.println(request.getProtocol());
//		if("HTTP/1.1".equals(request.getProtocol())) {
//			response.setHeader ("Cache-Control", "no-cache, no-store, must-revalidate");
//		} else {
//			response.setHeader ("Pragma", "no-cache");
//		}
//		response.setDateHeader ("Expires", 0);
//	}
}
