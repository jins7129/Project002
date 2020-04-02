package com.project.shuttle.model.dto;

import org.springframework.web.multipart.MultipartFile;

public class UploadDto {
	
	private String name;
	private MultipartFile mpfile;
	// 폼태그에서 멀티파트 타입으로 보낸 파일을 저장해줄 객체 타입
	
	public UploadDto() {}
	
	public UploadDto(String name, String desc, MultipartFile mpfile) {
		super();
		this.name = name;
		this.mpfile = mpfile;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public MultipartFile getMpfile() {
		return mpfile;
	}

	public void setMpfile(MultipartFile mpfile) {
		this.mpfile = mpfile;
	}
	
	

}
