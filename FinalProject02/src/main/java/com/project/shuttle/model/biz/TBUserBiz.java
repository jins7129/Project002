package com.project.shuttle.model.biz;

import com.project.shuttle.model.dto.TBJobDto;
import com.project.shuttle.model.dto.TBUserDto;

public interface TBUserBiz {
	
	public TBUserDto login(TBUserDto dto);
	
	public TBJobDto getWrittenBoard(String name);

}
