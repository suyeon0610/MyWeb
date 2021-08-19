package com.spring.myweb.util.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.spring.myweb.command.UserVO;

public class BoardAuthHandler extends HandlerInterceptorAdapter{
	
	//화면에서 변경, 수정, 삭제가 일어날 때, writer값을 넘겨주도록 처리
	//게시글 수정, 삭제에 대한 권한 처리 핸들러
	//세션값과 writer(작성자) 정보가 같다면 컨트롤러 실행
	//그렇지 않다면 '권한이 없습니다.' PrintWriter 객체 사용(response에서 받아옴)
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		UserVO vo = (UserVO)session.getAttribute("login");
		String writer = request.getParameter("writer");
		
		if(vo != null) {
			if(writer.equals(vo.getUserId())) {
				return true;
			}
		}
			
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print("<script> \r\n");
		out.print("alert('권한이 없습니다.');\r\n");
		out.print("history.back()");
		out.print("</script>");
		
		out.flush();
		
		return false;
	}

}
