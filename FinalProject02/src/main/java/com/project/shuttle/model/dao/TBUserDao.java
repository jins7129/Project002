package com.project.shuttle.model.dao;

import java.util.List;

import com.project.shuttle.model.dto.TBJobDto;
import com.project.shuttle.model.dto.TBUserDto;

public interface TBUserDao {
	
	public TBUserDto login(TBUserDto dto);
	
	public List<TBJobDto> getWrittenBoard(int pageNum, int pageCount, String userId);
	
	public int countBoard(String id);
	
	public int insertUser(TBUserDto dto);

	public String idchk(String id);

}
