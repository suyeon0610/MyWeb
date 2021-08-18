package com.spring.myweb.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.myweb.command.ReplyVO;
import com.spring.myweb.reply.service.IReplyService;
import com.spring.myweb.util.PageVO;

@RestController
@RequestMapping("/reply")
public class ReplyController {

	@Autowired
	private IReplyService service;
	
	//댓글 등록
	@PostMapping("/replyRegist")
	public String replyRegist(@RequestBody ReplyVO vo) {
		System.out.println("/reply/regist: POST");
		
		service.replyRegist(vo);
		return "success";
	}
	
	//일반 댓글 목록 (페이징x)
	/*
	@GetMapping("/getList/{bno}")
	public List<ReplyVO> getList(@PathVariable int bno) {
		System.out.println("/reply/getList: GET");
		
		List<ReplyVO> replyList = service.getList(bno);
		return replyList;
	}
	*/
	
	@GetMapping("/getList/{bno}/{pageNum}")
	public Map<String, Object> getList(@PathVariable int bno, @PathVariable int pageNum) {
		System.out.println("/reply/getList: GET");
		
		//1. 화면에 더보기 버튼 배치, 더보기 버튼 클릭 이벤트
		//2. getList 메서드가 (글 번호, 페이지번호)를 매개값으로 받음
		//3. Mapper 인터퍼이스의 각각 다른 값을 전달하기 위해 MAP or 아노테이션 사용
		//4. sql문을 페이징 쿼리로 변경
		//5. rest 방식은 화면에 필요한 값을 여러 개 보낼 때, 리턴에 Map or VO형식으로 필요한 데이터를 담아서 처리
		PageVO vo = new PageVO();
		vo.setPageNum(pageNum); //화면에서 전달되는 페이지 번호
		vo.setCountPerPage(10); 
		service.getList(vo, bno); //댓글 데이터
		
		List<ReplyVO> list = service.getList(vo, bno);
		int total = service.getTotal(bno); //전체 댓글 개수
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("total", total);
		
		return map;
	}
	
	//댓글 수정
	@PostMapping("/update")
	public String update(@RequestBody ReplyVO vo) {
		System.out.println("/reply/update: POST");
		
		if(service.pwCheck(vo) != 1) {
			return "pwFail";
		} else {
			service.update(vo);
			return "pwSuccess";
		}
		
	}
	
	//댓글 삭제
	@PostMapping("/delete")
	public String delete(@RequestBody ReplyVO vo) {
		System.out.println("/reply/delete: POST");
		
		if(service.pwCheck(vo) == 1) {
			service.delete(vo.getRno());
			return "success";
		} else {
			return "fail";
		}
	}
}
