package com.project.shuttle.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.shuttle.model.dao.TBApplyDao;
import com.project.shuttle.model.dao.TBUserDao;
import com.project.shuttle.model.dto.TBApplyDto;
import com.project.shuttle.model.dto.TBUserDto;

@Service
public class TBApplyBizImpl implements TBApplyBiz {

	@Autowired
	TBApplyDao applyDao;
	
	@Autowired
	TBUserDao userDao;
	
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

	@Override
	public int jobApplyGiveReward(int jobSeq, TBUserDto dto, TBUserDto writer) {
		
		int res = applyDao.jobApplyGiveReward(jobSeq);// 돈이 아니라 보드 정보를 바꿈 complete => Y(완료)
		System.out.println("res끝남");
		int res2 = userDao.kakaoUpdateBread(dto);
		System.out.println("res2끝남");
		int res3 = 0;
		
		if(res>0) {
			res3 = applyDao.jobApplyMinusReward(writer);
			System.out.println("res3끝남");
		}
		
		return res2;
	}

}
