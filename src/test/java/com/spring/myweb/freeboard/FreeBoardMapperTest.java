package com.spring.myweb.freeboard;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.myweb.command.FreeBoardVO;
import com.spring.myweb.freeboard.mapper.IFreeBoardMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/config/db-config.xml")
public class FreeBoardMapperTest {
	
	@Autowired
	private IFreeBoardMapper mapper;

	@Test
	public void registTest() {
		for(int i=1; i<=320; i++) {
			FreeBoardVO vo = new FreeBoardVO();
			vo.setTitle("테스트 글쓰기" + i);
			vo.setWriter("김테스트" + i);
			vo.setContent("테스트 글쓰기 내용입니다" + i);
			mapper.regist(vo);
		}
	}
	
	@Test
	public void getListTest() {
		
		for(FreeBoardVO b : mapper.getList(null)) {
			System.out.println(b);
		}
		
	}
	
	@Test
	public void getTotalTest() {
		System.out.println("총 게시물 수: " + mapper.getTotal(null));
	}
	
	@Test
	public void getContentTest() {
		System.out.println("250번 게시물: " + mapper.getContent(250));
	}
	
	@Test
	public void updateTest() {
		FreeBoardVO article = new FreeBoardVO();
		article.setTitle("수정된 제목");
		article.setContent("수정된 내용~~~~~");
		article.setBno(2);
		mapper.update(article);
		System.out.println(mapper.getContent(2));
	}
	
	@Test
	public void deleteTest() {
		mapper.delete(4);
		
		if(mapper.getContent(4) == null) {
			System.out.println("4번 게시물이 삭제되었습니다.");
		} else {
			System.out.println("삭제 실패!");
		}
	}
}
