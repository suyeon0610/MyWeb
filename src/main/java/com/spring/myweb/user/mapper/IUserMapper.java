package com.spring.myweb.user.mapper;

import java.util.Map;

import com.spring.myweb.command.UserVO;

public interface IUserMapper {

	// 아이디 중복 확인
	int idCheck(String id);

	// 화원 가입
	void join(UserVO vo);

	// 로그인
	UserVO login(Map<String, String> data);

	// 회원 정보 얻어오기
	UserVO getInfo(String id);
	
	// 회원 정보 수정
	void modify(UserVO vo);
}
