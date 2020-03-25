package com.project.shuttle.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.shuttle.model.dao.TBUserDao;
import com.project.shuttle.model.dto.TBJobDto;
import com.project.shuttle.model.dto.TBUserDto;



@Service
public class TBUserBizImpl implements TBUserBiz{
	
	@Autowired
	private TBUserDao dao;


	@Override
	public TBUserDto login(TBUserDto dto) {
		return dao.login(dto);
	}


	@Override
	public List<TBJobDto> getWrittenBoard(String name) {
		return dao.getWrittenBoard(name);
	}


}
