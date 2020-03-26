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
	private TBUserDao userDao;


	@Override
	public TBUserDto login(TBUserDto dto) {
		return userDao.login(dto);
	}


	@Override
	public List<TBJobDto> getWrittenBoard(int pageNum, int pageCount, String id) {
		return userDao.getWrittenBoard(pageNum, pageCount, id);
	}


	@Override
	public int countBoard(String id) {
		return userDao.countBoard(id);
	}


}
