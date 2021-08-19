package com.spring.myweb.user.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.myweb.command.UserVO;
import com.spring.myweb.user.mapper.IUserMapper;

@Service
public class UserService implements IUserService {
	
	@Autowired
	private IUserMapper mapper;

	@Override
	public int idCheck(String id) {
		return mapper.idCheck(id);
	}

	@Override
	public void join(UserVO vo) {
		mapper.join(vo);
	}

	@Override
	public UserVO login(String id, String pw) {
		Map<String, String> data = new HashMap<>();
		data.put("id", id);
		data.put("pw", pw);
		
		return mapper.login(data);
	}

	@Override
	public UserVO getInfo(String id) {
		return mapper.getInfo(id);
	}
	
	@Override
	public void modify(UserVO vo) {
		mapper.modify(vo);
	}

}
