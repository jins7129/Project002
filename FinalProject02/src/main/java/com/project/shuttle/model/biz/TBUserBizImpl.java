package com.project.shuttle.model.biz;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.shuttle.model.dao.TBUserDao;
import com.project.shuttle.model.dto.TBUserDto;



@Service
public class TBUserBizImpl implements TBUserBiz{
	
	@Autowired
	private TBUserDao dao;


	@Override
	public TBUserDto login(TBUserDto dto) {
		return dao.login(dto);
	}


}
