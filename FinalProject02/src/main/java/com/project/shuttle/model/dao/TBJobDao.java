package com.project.shuttle.model.dao;

import java.util.List;

import com.project.shuttle.model.dto.TBJobDto;

public interface TBJobDao {
	// Job Insert 기능
	public int insert(TBJobDto dto);
	
	public List<TBJobDto> selectList();
	
	public TBJobDto selectOne(int jobSeq);
}
