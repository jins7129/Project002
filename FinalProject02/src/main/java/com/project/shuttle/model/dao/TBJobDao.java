package com.project.shuttle.model.dao;

import java.util.List;

import com.project.shuttle.model.dto.TBJobDto;

public interface TBJobDao {
	// Job Insert 기능
	public int insert(TBJobDto dto);
	
	public int update(TBJobDto dto);
	
	public int delete(int jobSeq);
	
	public int applyDelete(int jobSeq);
	
	public List<TBJobDto> selectList();
	
	public TBJobDto selectOne(int jobSeq);

	public void addView(int jobSeq);
	
}
