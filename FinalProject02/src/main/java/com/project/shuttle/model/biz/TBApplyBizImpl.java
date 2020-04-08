package com.project.shuttle.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.shuttle.model.dao.TBApplyDao;
import com.project.shuttle.model.dto.TBApplyDto;
import com.project.shuttle.model.dto.TBUserDto;

@Service
public class TBApplyBizImpl implements TBApplyBiz {

	@Autowired
	TBApplyDao applyDao;
	
	@Override
	public List<TBUserDto> selectApply(int applySeq) {
		return applyDao.selectApply(applySeq);
	}

	@Override
	public int boardApplyUpdate(TBApplyDto dto) {
		return applyDao.boardApplyUpdate(dto);
	}

	@Override
	public int boardApplyCancel(TBApplyDto dto) {
		return applyDao.boardApplyCancel(dto);
	}

	@Override
	public int jobApplyChoiceUpdateBoard(TBApplyDto dto) {
		int res = 0;
		int boardRes = applyDao.jobApplyChoiceUpdateBoard(dto.getApplySeq());
		int applyRes = applyDao.jobApplyChoiceUpdateApply(dto.getApplySeq());
		int applyUpdateRes = applyDao.boardApplyUpdate(dto);
		
		res = boardRes+applyRes+applyUpdateRes;
		
		return res;
	}

}
