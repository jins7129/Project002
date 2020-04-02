package com.project.shuttle.model.biz;

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

}
