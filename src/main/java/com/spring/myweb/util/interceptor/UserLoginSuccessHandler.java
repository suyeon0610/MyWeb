package com.spring.myweb.util.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.spring.myweb.command.UserVO;

public class UserLoginSuccessHandler extends HandlerInterceptorAdapter {
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		System.out.println(request.getMethod());
		
		if(!(request.getMethod().equals("POST"))) {
			return;
		} else {
			System.out.println("로그인 인터셉터 발동");
			
			UserVO vo = (UserVO)modelAndView.getModel().get("user");
			
			System.out.println("인터셉터 로그인 정보: " + vo);
			
			if(vo != null) {
				HttpSession session = request.getSession();
				session.setAttribute("login", vo);
				response.sendRedirect(request.getContextPath());
			} else {
				System.out.println("로그인 실패!");
				modelAndView.addObject("msg", "loginFail"); //질문
				modelAndView.setViewName("/user/userLogin");
			}
			
		}
		
		
		
	}

}
