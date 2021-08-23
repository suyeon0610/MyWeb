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

import com.spring.myweb.command.MultiUploadVO;
import com.spring.myweb.command.UploadVO;

@Controller
@RequestMapping("/fileupload")
public class UploadController {

	@GetMapping("/upload")
	public void form() {}
	
	@PostMapping("/upload_ok")
	public String upload(@RequestParam("file") MultipartFile file) {
		
		try {
			String fileRealName = file.getOriginalFilename(); //파일 정보
			long size = file.getSize(); //파일 사이즈
			
			System.out.println("파일명: " + fileRealName);
			System.out.println("파일크기: " + size);
			
			//서버에 저장할 파일 이름
			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."), fileRealName.length()); //파일 확장자
			String uploadFolder = "D:\\test\\upload";
			
			//파일 업로드 시 파일명이 동일한 파일이 존재할 수 있음
			//사용자가 업로드하는 파일명이 한들인 경우도 있음 -> 한글 지원하지 않는 환경 때문
			//고유한 랜덤 문자를 통해 DB와 서버에 저장할 파일명을 새로 만듦
			UUID uuid = UUID.randomUUID();
			String[] uuids = uuid.toString().split("-");
			String uniqueName = uuids[0];
			System.out.println("생성된 고유 문자열: " + uniqueName);
			System.out.println("확장자명: " + fileExtension);
			
			File saveFile = new File(uploadFolder + "\\" + uniqueName + fileExtension);
			System.out.println("파일 경로: " + saveFile);
			file.transferTo(saveFile); //실제 파일 저장 메서드 (fileWriter 작업을 손쉽게 저장)
			
		} catch (Exception e) {
			System.out.println("업로드 중 문제 발생!" + e.getMessage());
		}
		
		return "fileupload/upload_ok";
	}
		
	
	@PostMapping("/upload_ok2")
	public String upload2(MultipartHttpServletRequest files) {
		
		try {
			
			List<MultipartFile> list = files.getFiles("files");
			
			for(MultipartFile file : list) {
				
				String fileRealName = file.getOriginalFilename();
				String uploadPath = "D:\\test\\upload";
				
				File saveFile = new File(uploadPath + "\\" + fileRealName);
				file.transferTo(saveFile);
				
			}
			
			
		} catch (Exception e) {
			System.out.println("업로드 중 문제 발생!" + e.getMessage());
		}
		
		return "fileupload/upload_ok";
	}
	
	@PostMapping("/upload_ok3")
	public String upload3(@RequestParam("file") List<MultipartFile> list) {
		
		String uploadFolder = "D:\\test\\upload";
		
		try {
			for(MultipartFile file : list) {
				String fileRealName = file.getOriginalFilename();
				
				File saveFile = new File(uploadFolder + "\\" + fileRealName);
				
				file.transferTo(saveFile);
			}
			
		} catch (Exception e) {
			System.out.println("업로드 중 문제 발생!" + e.getMessage());
		}
		
		return "fileupload/upload_ok";
	}
	
	@PostMapping("/upload_ok4")
	public String upload4(MultiUploadVO vo) {
		
		List<UploadVO> list = vo.getList();
		String uploadFolder = "D:\\test\\upload";
		
		try {
			for(UploadVO up : list) {
				String fileRealName = up.getFile().getOriginalFilename();
				
			File saveFile = new File(uploadFolder + "\\" + fileRealName);
			up.getFile().transferTo(saveFile);
			}
			
		} catch (Exception e) {
			System.out.println("업로드 중 문제 발생!" + e.getMessage());
		}
		
		return "fileupload/upload_ok";
	}
	
}
