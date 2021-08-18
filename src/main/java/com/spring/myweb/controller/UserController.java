package com.spring.myweb.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.myweb.user.service.IUserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private IUserService service;

	@GetMapping("/userJoin")
	public String join() {
		System.out.println("/user/userJoin: GET");
		return "user/userJoin";
	}
	
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
	
}
