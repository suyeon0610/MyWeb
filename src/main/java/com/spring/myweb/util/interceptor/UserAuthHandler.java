package com.spring.myweb.util.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.spring.myweb.command.UserVO;

public class UserAuthHandler extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
	 	HttpSession session = request.getSession();
	 	UserVO user = (UserVO) session.getAttribute("login");
		
		if(user == null) {
			response.sendRedirect(request.getContextPath() + "/user/userLogin");
			return false;
		}
		
		return true;
		
	}

}
