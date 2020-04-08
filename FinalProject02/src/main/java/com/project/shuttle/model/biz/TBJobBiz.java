package com.project.shuttle.model.biz;

import java.util.List;

import com.project.shuttle.model.dto.TBJobDto;

public interface TBJobBiz {
	public int insert(TBJobDto dto);

	public List<TBJobDto> selectList();

	public TBJobDto selectOne(int jobSeq);

	public void addView(int jobSeq);
	
<<<<<<< HEAD
	
=======
>>>>>>> 97b8b48a38ebf729d694fd766d3965841023f9ea
}
