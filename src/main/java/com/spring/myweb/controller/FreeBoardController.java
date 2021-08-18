package com.spring.myweb.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.myweb.command.FreeBoardVO;
import com.spring.myweb.freeboard.service.IFreeBoardService;
import com.spring.myweb.util.PageCreator;
import com.spring.myweb.util.PageVO;

@Controller
@RequestMapping("/freeBoard")
public class FreeBoardController {

	@Autowired
	private IFreeBoardService service;
	
	//목록 화면
	@GetMapping("/freeList")
	public void freeList(Model model, PageVO page) {
		System.out.println("/freeBoard/freeList: GET");
		
		PageCreator pc = new PageCreator();
		pc.setPage(page);
		pc.setPageTotalCount(service.getTotal(page));
		
		model.addAttribute("pc", pc);
		model.addAttribute("boardList", service.getList(page));
		
	}
	
	//글쓰기 화면
	@GetMapping("/freeRegist")
	public void freeRegist() {
		System.out.println("/freeBoard/freeRegist: GET");
	}
	
	//글등록 요청
	@PostMapping("/freeRegist")
	public String Regist(FreeBoardVO vo) {
		System.out.println("/freeBoard/freeRegist: POST");
		service.regist(vo);
		
		return "redirect:/freeBoard/freeList";
	}
	
	//글 상세보기 요청
	@GetMapping("/freeDetail")
	public void freeDetail(@RequestParam("bno") int bno, Model model,
							@ModelAttribute("p") PageVO vo) {
		System.out.println("/freeBoard/freeDetail: GET");
		model.addAttribute("article", service.getContent(bno));
	}
	
	//글 수정 화면
	@GetMapping("/freeModify")
	public String freeModify(@RequestParam int bno, Model model) {
		System.out.println("/freeBoard/freeModify: GET");
		model.addAttribute("article", service.getContent(bno));
		return "freeBoard/freeModify";
	}
	
	//글 수정 요청
	@GetMapping("/freeUpdate")
	public String freeUpdate(FreeBoardVO vo, RedirectAttributes ra) {
		System.out.println("/freeBoard/freeUpdate: GET");
		
		service.update(vo);
		ra.addFlashAttribute("msg", "modify");
		
		return "redirect:/freeBoard/freeDetail?bno=" + vo.getBno();
	}
	
	//글 삭제 요청
	@PostMapping("/freeDelete")
	public String freeDelete(@RequestParam int bno, RedirectAttributes ra) {
		System.out.println("/freeBoard/freeDelete: POST");
		
		service.delete(bno);
		ra.addFlashAttribute("msg", "delete");
		
		return "redirect:/freeBoard/freeList";
	}
	
}
