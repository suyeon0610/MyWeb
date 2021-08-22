package com.spring.myweb.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping("/fileupload")
public class UploadController {

	@GetMapping("/upload")
	public void form() {}
	
	@PostMapping("/upload_ok")
	public String upload(@RequestParam("file") MultipartFile file) {
		
		try {
			String fileRealName = file.getOriginalFilename(); //파일 정보
			Long size = file.getSize();
			
			System.out.println("파일명: " + fileRealName);
			System.out.println("사이즈: " + size);
			
			//서버에서 저장할 파일 이름
			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."), fileRealName.length());
			String uploadFolder = "D:\\test\\upload";
			
			//파일 업로드 시 파일명이 동일한 파일이 존재할 수도 있고,
			//사용자가 업로드하는 파일명일 한글인 경우도 있음
			//한글을 지원하지 않는 환경일 수도 있음 (리눅스)
			//고유한 랜덤 문자를 통해 DB와 서버에 저장할 파일명을 새로 만들어 줌
			UUID uuid = UUID.randomUUID();
			String[] uuids = uuid.toString().split("-");
			String uniqueName = uuids[0];
			System.out.println("생성된 고유 문자열: " + uniqueName);
			System.out.println("확장자명: " + fileExtension);
			
			File saveFile = new File(uploadFolder + "\\" + uniqueName + fileExtension);
			file.transferTo(saveFile); //실제 파일 저장 메서드 (fileWriter 작업을 손쉽게 한번에 처리)
			
		} catch (Exception e) {
			System.out.println("업로드 중 문제 발생!" + e.getMessage());
		}
		
		return "fileupload/upload_ok";
	}
	
	@PostMapping("/upload_ok2")
	public String upload2(MultipartHttpServletRequest files) {
		
		//서버에서 저장할 파일 이름
		String uploadFolder = "D:\\test\\upload";
		
		try {
			List<MultipartFile> list = files.getFiles("files");
			
			for(int i=0; i<list.size(); i++) {
				String fileRealName = list.get(i).getOriginalFilename();
				Long size = list.get(i).getSize();
				
				System.out.println("파일명: " + fileRealName);
				System.out.println("사이즈: " + size);
				
				File saveFile = new File(uploadFolder + "\\" + fileRealName);
				list.get(i).transferTo(saveFile);
			}
			
		} catch (Exception e) {
			System.out.println("업로드 중 문제 발생!" + e.getMessage());
		}

		
		return "/fileupload/upload_ok2";
	}
	
	@PostMapping("/upload_ok3")
	public String upload3(@RequestParam("file") List<MultipartFile> list) {
		return "";
	}
	
}
