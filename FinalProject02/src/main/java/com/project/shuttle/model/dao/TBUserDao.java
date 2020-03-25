package com.project.shuttle.model.dao;

import com.project.shuttle.model.dto.TBJobDto;
import com.project.shuttle.model.dto.TBUserDto;

public interface TBUserDao {
	
	public TBUserDto login(TBUserDto dto);
	
	public TBJobDto getWrittenBoard(String name);

}
