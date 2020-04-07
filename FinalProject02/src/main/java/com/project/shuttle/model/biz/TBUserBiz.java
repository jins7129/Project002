package com.project.shuttle.model.biz;

import java.util.List;

import com.project.shuttle.model.dto.TBJobDto;
import com.project.shuttle.model.dto.TBReviewDto;
import com.project.shuttle.model.dto.TBUserDto;

public interface TBUserBiz {
	
	// 마이페이지 관련
	public List<TBJobDto> getWrittenBoard(int pageNum, int pageCount, String userId);
	public List<TBJobDto> getApplyBoard(int pageNum, int pageCount, String userId);
	public List<TBJobDto> getDoingBoard(int pageNum, int pageCount, String userId);
	public List<TBJobDto> getDoneBoard(int pageNum, int pageCount, String userId);
	public List<TBJobDto> getReviewBoard(int pageNum, int pageCount, String userId);
	
	public int countBoard(String userId);
	public int countApplyBoard(String userId);
	public int countDoingBoard(String userId);
	public int countDoneBoard(String userId);
	public int countReviewBoard(String userId);
	
	public int mypageUpdate(TBUserDto dto);
	public int mypagePhotoUpdate(TBUserDto dto);

	// 로그인, 회원가입 관련
	public TBUserDto login(TBUserDto dto);
	
	public int insertUser(TBUserDto dto);
	
	public String idchk(String id);
	
	// 글 상세보기에서 사용될 유저 정보(APPLY한 유저)
	public TBUserDto userDetail(String userId);
	public TBReviewDto countReview(String userId);
}
