package com.project.shuttle.model.dao;

import java.util.List;

import com.project.shuttle.model.dto.TBApplyDto;
import com.project.shuttle.model.dto.TBUserDto;

public interface TBApplyDao {
	
	public List<TBUserDto> selectApply(int applySeq);
	
	public int boardApplyUpdate(TBApplyDto dto);
	
	public int boardApplyCancel(TBApplyDto dto);

	public int jobApplyChoiceUpdateBoard(int jobSeq);
	public int jobApplyChoiceUpdateApply(int applySeq);
	public int jobApplyGiveReward(int jobSeq);
	public int jobApplyMinusReward(TBUserDto dto);

}
