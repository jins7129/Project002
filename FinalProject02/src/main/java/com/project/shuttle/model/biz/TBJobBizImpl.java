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
	public int update(TBJobDto dto) {
		return dao.update(dto);
	}
	
	@Override
	public int delete(int jobSeq) {	// 보드 지우는 비즈 job테이블, apply테이블 지움
		int applyDeleteRes = dao.applyDelete(jobSeq);
		int res = 0;
		
		if(applyDeleteRes > 0) {
			res = dao.delete(jobSeq);
		}
		return res;
	}
	
	@Override
	public TBJobDto selectOne(int jobSeq) {
		return dao.selectOne(jobSeq);
	}

	@Override
	public List<TBJobDto> selectList() {
		return dao.selectList();
	}

	@Override
	public void addView(int jobSeq) {
		dao.addView(jobSeq);
	}



}
