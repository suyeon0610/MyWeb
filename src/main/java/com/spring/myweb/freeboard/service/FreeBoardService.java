package com.spring.myweb.freeboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.myweb.command.FreeBoardVO;
import com.spring.myweb.freeboard.mapper.IFreeBoardMapper;
import com.spring.myweb.util.PageVO;

@Service
public class FreeBoardService implements IFreeBoardService {

	@Autowired
	private IFreeBoardMapper mapper;
	
	@Override
	public void regist(FreeBoardVO vo) {
		mapper.regist(vo);
	}

	@Override
	public List<FreeBoardVO> getList(PageVO page) {
		
		List<FreeBoardVO> list = mapper.getList(page);
		
		for(FreeBoardVO vo : list) {
			long today = System.currentTimeMillis();
			long regDate = vo.getRegdate().getTime();
			
			if ((today - regDate) <= 60 * 60 * 24 * 2 * 1000) {
				vo.setNewmark(true);
			} else {
				vo.setNewmark(false);
			}			
		}
		
		return list;
	}

	@Override
	public int getTotal(PageVO vo) {
		return mapper.getTotal(vo);
	}

	@Override
	public FreeBoardVO getContent(int bno) {
		return mapper.getContent(bno);
	}

	@Override
	public void update(FreeBoardVO vo) {
		mapper.update(vo);
	}

	@Override
	public void delete(int bno) {
		mapper.delete(bno);
	}

}
