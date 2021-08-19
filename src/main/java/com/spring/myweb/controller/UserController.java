package com.spring.myweb.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.myweb.command.UserVO;
import com.spring.myweb.user.service.IUserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private IUserService service;
	
	//회원가입 화면
	@GetMapping("/userJoin")
	public String join() {
		System.out.println("/user/userJoin: GET");
		return "user/userJoin";
	}
	
	//아이디 중복 체크
	@ResponseBody
	@PostMapping("/userIdCheck")
	public String idCheck(@RequestBody String id) {
		System.out.println("/user/userIdCheck: POST");
		
		if(service.idCheck(id) == 1) {
			return "duplication";
		} else {
			return "available";
		}
	
	}
	
	//회원가입 요청
	@PostMapping("/join")
	public String join(UserVO vo, RedirectAttributes ra) {
		System.out.println("/user/join: POST");
		
		service.join(vo);
		ra.addFlashAttribute("msg", "joinSuccess");
		
		return "redirect:/user/userLogin";
	}
	
	//로그인 화면
	@GetMapping("/userLogin")
	public void userLogin() {
		System.out.println("/user/userLogin: GET");
	}
	
	//로그인 요청
	@PostMapping("/userLogin")
	public String login(String id, String pw, Model model,
						RedirectAttributes ra) {
		System.out.println("/user/userLogin: POST");
		
		System.out.println("controller user: " + service.login(id, pw));
		model.addAttribute("user", service.login(id, pw));
		
		return"user/userMypage"; //redirect 안됨
		
		/*
		if(service.login(id, pw) != null) {
			model.addAttribute("user", service.login(id, pw));
			return "redirect:/";
		} else {
			ra.addFlashAttribute("msg", "loginFail");
			return "redirect:/user/userLogin";
		}
		*/
		
	}
	
	//마이페이지 화면
	@GetMapping("/userMypage")
	public void mypage(HttpSession session, Model model) {
		System.out.println("/user/userMypage: GET");
		
		UserVO vo = (UserVO)session.getAttribute("login");
		String id = vo.getUserId();
		
		model.addAttribute("userInfo", service.getInfo(id));
	
	}
	
	@PostMapping("/userModify")
	public String modify(UserVO vo) {
		System.out.println("/user/userModify: POST");
		
		service.modify(vo);
		return "redirect:/user/userMypage";
		
	}
	
	@GetMapping("/userLogout")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "";
	}
	
}
