package com.project.shuttle.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.shuttle.model.dao.TBJobDao;
import com.project.shuttle.model.dto.TBJobDto;

@Service
public class TBJobBizImpl implements TBJobBiz {

	@Autowired
	TBJobDao dao;
	
	@Override
	public int insert(TBJobDto dto) {
		return dao.insert(dto);
	}

	@Override
	public List<TBJobDto> selectList() {
		return dao.selectList();
	}

	@Override
	public TBJobDto selectOne(int jobSeq) {
		return dao.selectOne(jobSeq);
	}

	@Override
	public void addView(int jobSeq) {
		dao.addView(jobSeq);
	}

}
