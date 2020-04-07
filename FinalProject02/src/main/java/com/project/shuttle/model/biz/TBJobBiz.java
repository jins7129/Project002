package com.project.shuttle.model.biz;

import java.util.List;

import com.project.shuttle.model.dto.TBJobDto;

public interface TBJobBiz {
	public int insert(TBJobDto dto);

	public List<TBJobDto> selectList();

	public TBJobDto selectOne(int jobSeq);

	public void addView(int jobSeq);
	
}
