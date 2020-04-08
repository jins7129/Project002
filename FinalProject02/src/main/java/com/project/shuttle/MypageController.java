package com.project.shuttle;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.project.shuttle.model.biz.KakaoPayBiz;
import com.project.shuttle.model.biz.TBApplyBiz;
import com.project.shuttle.model.biz.TBJobBiz;
import com.project.shuttle.model.biz.TBUserBiz;
import com.project.shuttle.model.dao.TBUserDao;
import com.project.shuttle.model.dto.Criteria;
import com.project.shuttle.model.dto.PageMaker;
import com.project.shuttle.model.dto.TBApplyDto;
import com.project.shuttle.model.dto.TBJobDto;
import com.project.shuttle.model.dto.TBReviewDto;
import com.project.shuttle.model.dto.TBUserDto;
import com.project.shuttle.model.dto.UploadDto;

@Controller
public class MypageController {
	
	@Autowired
	private TBUserBiz userBiz;
	
	@Autowired
	private TBJobBiz jobBiz;
	
	@Autowired
	private TBApplyBiz applyBiz;
	
	@Autowired
	private KakaoPayBiz kakaopay;
	
	@RequestMapping("/mypage_main.do")
	public ModelAndView mypageMain(ModelAndView mav) {
		
		mav.setViewName("user_mypage_main");
		
		return mav;
	}
	
	@RequestMapping("/mypage_update.do")
	public ModelAndView mypage(ModelAndView mav) {
		mav.setViewName("user_mypage_updateform");
		
		return mav;
	}
	
	@RequestMapping(value = "/mypage_updateres.do", method= RequestMethod.POST)
	public RedirectView mypage_updateRes(HttpSession session,String userPhone,String userPw, String addr1, String addr2) {
		TBUserDto loginInfo = (TBUserDto)session.getAttribute("loginInfo");
		System.out.println(loginInfo.getUserId());
		String userAddr = addr1+" "+addr2;	// 도로명 주소로 입력된 주소값을 하나로 합친 것
		loginInfo.setUserAddr(userAddr);
		loginInfo.setUserPhone(userPhone);
		loginInfo.setUserPw(userPw);
		
		int res = userBiz.mypageUpdate(loginInfo);
		
		RedirectView reView ;
		
		if(res>0) {
			reView = new RedirectView("/mypage_main.do");
		} else {
			reView = new RedirectView("/mypage_main.do");
		}
		
		
		
		return reView;
	}
	
	@RequestMapping(value="/getWrittenBoard.do", method = RequestMethod.POST )
	@ResponseBody
	public Map<Object,Object> getWrittenBoard(HttpSession session, int pageNum){
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		// 리턴 값으로 보낼 맵 객체 선언
		TBUserDto loginInfo = (TBUserDto) session.getAttribute("loginInfo");
		String userId = loginInfo.getUserId();
		// session에 담겨 있는 로그인 정보를 갖고 옴(아이디)
		
		Criteria cri = new Criteria();	// 넘겨 받은 페이지 번호로 페이지를 설정할 객체
		cri.setPage(pageNum);	// 보여줄 페이지 번호(넘겨 받은 pageNum 값)
		cri.setPageCount(9);	// 해당 페이지에서 보여줄 게시글의 갯수
		
		PageMaker pageMaker = new PageMaker();	// 페이지 번호를 생성해줄 객체
		pageMaker.setCri(cri);	// 위의 페이지 번호를 설정해줌
		pageMaker.setTotalCount(userBiz.countBoard(userId));	// 해당 아이디로 작성한 글들의 총 갯수를 반환

		List<TBJobDto> boardList = userBiz.getWrittenBoard(cri.getPage(),cri.getPageCount(),userId);
		// 해당 아이디가 썼던 글을 불러옴(의뢰글)	(보여질 페이지수, 전체게시글 갯수, 유저아이디)
		
		map.put("list", boardList);	// 사용자가 작성했던 의뢰글(리스트) 맵에 넣어줌
		map.put("pageMaker", pageMaker);
		return map;	//값을 담고 있는 맵 객체 리턴
	}
	
	@RequestMapping(value="/getApplyBoard.do", method = RequestMethod.POST )
	@ResponseBody
	public Map<Object, Object>  getApplyBoard(HttpSession session, int pageNum){
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		TBUserDto loginInfo = (TBUserDto) session.getAttribute("loginInfo");
		String userId = loginInfo.getUserId();
		// session에 담겨 있는 로그인 정보를 갖고 옴(아이디)
		
		Criteria cri = new Criteria();	// 넘겨 받은 페이지 번호로 페이지를 설정할 객체
		cri.setPage(pageNum);	// 보여줄 페이지 번호(넘겨 받은 pageNum 값)
		cri.setPageCount(9);	// 해당 페이지에서 보여줄 게시글의 갯수
		
		PageMaker pageMaker = new PageMaker();	// 페이지 번호를 생성해줄 객체
		pageMaker.setCri(cri);	// 위의 페이지 번호를 설정해줌
		pageMaker.setTotalCount(userBiz.countApplyBoard(userId));	// 해당 아이디로 신청한 글 들의 총 갯수를 반환

		List<TBJobDto> boardList = userBiz.getApplyBoard(cri.getPage(),cri.getPageCount(),userId);
		// 해당 아이디가 신청한 글들을 불러옴(의뢰글)	(보여질 페이지수, 전체게시글 갯수, 유저아이디)
		
		map.put("list", boardList);	// 사용자가 신청한 의뢰글(리스트) 맵에 넣어줌
		map.put("pageMaker", pageMaker);
		return map;	//값을 담고 있는 맵 객체 리턴
	}
	
	@RequestMapping(value="/getDoingBoard.do", method = RequestMethod.POST )
	@ResponseBody
	public Map<Object, Object> getDoingBoard(HttpSession session, int pageNum){
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		TBUserDto loginInfo = (TBUserDto) session.getAttribute("loginInfo");
		String userId = loginInfo.getUserId();
		// session에 담겨 있는 로그인 정보를 갖고 옴(아이디)
		
		Criteria cri = new Criteria();	// 넘겨 받은 페이지 번호로 페이지를 설정할 객체
		cri.setPage(pageNum);	// 보여줄 페이지 번호(넘겨 받은 pageNum 값)
		cri.setPageCount(9);	// 해당 페이지에서 보여줄 게시글의 갯수
		
		PageMaker pageMaker = new PageMaker();	// 페이지 번호를 생성해줄 객체
		pageMaker.setCri(cri);	// 위의 페이지 번호를 설정해줌
		pageMaker.setTotalCount(userBiz.countDoingBoard(userId));	// 해당 아이디로 신청한 글 들의 총 갯수를 반환

		List<TBJobDto> boardList = userBiz.getDoingBoard(cri.getPage(),cri.getPageCount(),userId);
		// 해당 아이디가 신청한 글들을 불러옴(의뢰글)	(보여질 페이지수, 전체게시글 갯수, 유저아이디)
		
		map.put("list", boardList);	// 사용자가 신청한 의뢰글(리스트) 맵에 넣어줌
		map.put("pageMaker", pageMaker);
		
		return map;
	}
	
	@RequestMapping(value="/getDoneBoard.do", method = RequestMethod.POST )
	@ResponseBody
	public Map<Object, Object> getDoneBoard(HttpSession session, int pageNum){
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		TBUserDto loginInfo = (TBUserDto) session.getAttribute("loginInfo");
		String userId = loginInfo.getUserId();
		
		Criteria cri = new Criteria();	
		cri.setPage(pageNum);	
		cri.setPageCount(9);	
		
		PageMaker pageMaker = new PageMaker();	
		pageMaker.setCri(cri);	
		pageMaker.setTotalCount(userBiz.countDoneBoard(userId));	

		List<TBJobDto> boardList = userBiz.getDoneBoard(cri.getPage(),cri.getPageCount(),userId);
		
		map.put("list", boardList);	
		map.put("pageMaker", pageMaker);
		
		return map;
	}
	
	@RequestMapping(value="/getReviewBoard.do", method = RequestMethod.POST )
	@ResponseBody
	public Map<Object, Object> getReviewBoard(HttpSession session, int pageNum){
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		TBUserDto loginInfo = (TBUserDto) session.getAttribute("loginInfo");
		String userId = loginInfo.getUserId();
		
		Criteria cri = new Criteria();	
		cri.setPage(pageNum);	
		cri.setPageCount(9);	
		
		PageMaker pageMaker = new PageMaker();	
		pageMaker.setCri(cri);	
		pageMaker.setTotalCount(userBiz.countReviewBoard(userId));	

		List<TBJobDto> boardList = userBiz.getReviewBoard(cri.getPage(),cri.getPageCount(),userId);
		
		map.put("list", boardList);	
		map.put("pageMaker", pageMaker);
		
		return map;
	}
	/////////// 카카오 페이 컨트롤러 부분
	
//	@Autowired
//	private KakaoPayBiz kakaopay;	// 해당 카카오비즈 사용함
	
	@RequestMapping("/main_pay_main.do")
	public ModelAndView kakaoPayMain(ModelAndView mav) {
		
		mav.setViewName("main_pay_first");
		
		return mav;
	}
	
	@RequestMapping(value="/main_pay_first.do", method = RequestMethod.POST)
	public String kakaoPayFirst(HttpSession session, int quantity) {
													// 선택한 수량 , int quantity
		TBUserDto loginInfo = (TBUserDto)session.getAttribute("loginInfo");	// 유저 정보
		String userId = loginInfo.getUserId();	// 아이디
		
		return "redirect:" + kakaopay.kakaoPayReady(userId, quantity);
		// 아이디와 수량을 보내줌
	}
	
	@RequestMapping(value="/main_pay_success.do", method = RequestMethod.GET)
	public ModelAndView kakaoPaySuccess(HttpSession session, ModelAndView mav, String pg_token) {
//		System.out.println("kakao pg_token : " + pg_token); 응답으로 pg_token이 넘어오면 성공이다 이말이야
		TBUserDto loginInfo = (TBUserDto)session.getAttribute("loginInfo");	// 유저 정보
//		String userId = loginInfo.getUserId();	// 아이디
		
		mav.setViewName("main_pay_success");
		mav.addObject("kakaoInfo", kakaopay.kakaoPayInfo(pg_token, loginInfo,session));	// 토큰을 통해 각 값들을 불러옴(카카오비즈확인요망)
		
		return mav;
		
	}
	
	@RequestMapping("mypage_update_img.do")
	public String imgUpload(HttpSession session, HttpServletRequest request, UploadDto uploadFile ) {
		
		MultipartFile file = uploadFile.getMpfile();
		TBUserDto loginInfo = (TBUserDto)session.getAttribute("loginInfo");
		String userId = loginInfo.getUserId();
		
		String name = file.getOriginalFilename();
		String[] fileName = name.split("\\.");
		// split 자체가 정규식으로 작동하는데 .(온점) 하나는 무작위 한글자를 의미한다고 함.
		// 그렇기에 .(온점)을 찾아 자르고 싶으면 [.]이나 \\.으로 .이라는걸 명시하는 이스케이프 문자를 사용해야함
		
		String userImgpath = userId+"."+fileName[1];
		
		InputStream inStream = null;
		OutputStream outStream = null;
		
		loginInfo.setUserImgpath(userImgpath);
		userBiz.mypagePhotoUpdate(loginInfo);// 사진경로 바꾸는 biz
		
		
		try {
			inStream = file.getInputStream();
			String path = request.getSession().getServletContext().getRealPath("/resources/file/profilePhoto");
			System.out.println("upload path: " +path);
		
			File storage = new File(path);
			if(!storage.exists()) {
				storage.mkdir();
			}
			
			File newFile = new File(path+"/"+userImgpath);
			newFile.createNewFile();
			
			outStream = new FileOutputStream(newFile);
			
			int read = 0;
			byte[] b = new byte[(int)file.getSize()];
			
			while((read=inStream.read(b))!= -1) {
				outStream.write(b,0,read);
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				inStream.close();
				outStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return "user_mypage_main";
	}
	
	
	// 해당 부분은 summernote 콜백으로 들어오는 아작스 부분,
	// 어째서 @RequestBodt와 @ResponseBody나 @RestController를 사용하지 않았는데 되는지는 의문.. 
	
	@RequestMapping("/insertTest.do")
	public void profileUpload(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		// 업로드할 폴더 경로
		String realFolder = request.getSession().getServletContext().getRealPath("/resources/file/boardPhoto");
		UUID uuid = UUID.randomUUID();
		//범용 고유 식별자 UUID

		// 업로드할 파일 이름
		String org_filename = file.getOriginalFilename();
		String str_filename = uuid.toString() + org_filename;

//		System.out.println("원본 파일명 : " + org_filename);
//		System.out.println("저장할 파일명 : " + str_filename);

		String filepath = realFolder + "\\" + str_filename;
//		System.out.println("파일경로 : " + filepath);

		File f = new File(filepath);
		if (!f.exists()) {
			f.mkdirs();
		}
		file.transferTo(f);
		out.println("resources\\file\\boardPhoto\\"+str_filename);
		// 아작스로 보내줄 사진경로값
		out.close();
	}

	@RequestMapping("/main_jobDetail.do")
	public ModelAndView boardDetail(ModelAndView mav, int jobSeq, HttpSession session) {
		
		TBUserDto userInfo = (TBUserDto)session.getAttribute("loginInfo");
		// 로그인유저정보
		TBJobDto dto = jobBiz.selectOne(jobSeq);
		// 게시글 정보
		List<TBUserDto> applyInfo = applyBiz.selectApply(jobSeq);
		// 해당 게시글의 지원자 정보
		jobBiz.addView(jobSeq);
		// 조회수 증가
		TBUserDto writerInfo = userBiz.userDetail(dto.getUserId());
		// 게시글 작성자 정보
		TBReviewDto reviewDto = userBiz.countReview(dto.getUserId());
		// 게시글 작성자 별점
		String userScore = "평가가 없습니다.";
		
		if(reviewDto != null) {
			userScore = reviewDto.getReviewScore();
		}
		Map<String,String> map = new HashMap<String, String>();
		String apply = "false";
		String writer = "false";
		
		for(int i = 0; i < applyInfo.size(); i++) {
			if(userInfo.getUserId().equals(applyInfo.get(i).getUserId())) {
				// 유저아이디와 지원자 정보 중의 아이디가 같다면
				apply = "true";
			}
		}
		
		if(userInfo.getUserId().equals(dto.getUserId())) {
			writer = "true";
		}
		
		map.put("apply", apply);
		map.put("writer", writer);
		map.put("userScore", userScore);
		
		
		mav.addObject("check",map);
		mav.addObject("applyInfo",applyInfo);
		mav.addObject("jobInfo",dto);
		mav.addObject("writerInfo",writerInfo);
		
		mav.setViewName("main_jobDetail");
		
		return mav;
	}
	
	// 비동기 통신, 유저 정보
	@RequestMapping(value="/userDetail.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object,Object> userDetail(String userId) {
		TBUserDto userInfo = userBiz.userDetail(userId);
		TBReviewDto reviewInfo = userBiz.countReview(userId);
		String userScore = "평가가 없습니다.";
		
		if(reviewInfo != null) {
			userScore = reviewInfo.getReviewScore();
		}
		
		Map<Object,Object> map = new HashMap<Object, Object>();
		map.put("userInfo", userInfo);
		map.put("userScore", userScore);
		
		return map;
	}

	// 아르바이트 신청, 취소
	@RequestMapping("/jobApplyUpdate.do")
	public RedirectView jobApplyUpdate(int jobSeq, String userId, String jobUserId) {
		
		TBApplyDto dto = new TBApplyDto();
		dto.setApplySeq(jobSeq);
		dto.setApplyWoker(userId);
		dto.setApplyOwner(jobUserId);
		applyBiz.boardApplyUpdate(dto);
		RedirectView review = new RedirectView("/main_jobDetail.do?jobSeq="+jobSeq);
		
		return review;
	}
	
	@RequestMapping("/jobApplyCancel.do")
	public RedirectView jobApplyCancelUpdate(int jobSeq, String userId) {
		
		TBApplyDto dto = new TBApplyDto();
		dto.setApplySeq(jobSeq);
		dto.setApplyWoker(userId);
		applyBiz.boardApplyCancel(dto);
		RedirectView review = new RedirectView("/main_jobDetail.do?jobSeq="+jobSeq);
		
		return review;
	}
	
	// 글삭제, 수정
	@RequestMapping("/jobDelete.do")
	public RedirectView jobDelete(int jobSeq, String userId) {
		
		jobBiz.delete(jobSeq);
		
		RedirectView review = new RedirectView("/main.do");
		
		return review;
	}
	@RequestMapping("/jobUpdate.do")
	public ModelAndView jobUpdate(ModelAndView mav, int jobSeq, String userId) {
		
		TBJobDto dto = jobBiz.selectOne(jobSeq);
		// 게시글 정보
		
		mav.addObject("jobInfo",dto);
		mav.setViewName("main_jobUpdate");
		
		return mav;
	}
	
	@RequestMapping("/main_updateres.do")
	public RedirectView jobUpdateRes(TBJobDto dto) {
		
		int res = jobBiz.update(dto);
//		System.out.println("updateres.do : update 성공 여부"+ res);
		RedirectView reView = new RedirectView("/main_jobDetail.do?jobSeq="+dto.getJobSeq());
		
		return reView;
	}
	
	@RequestMapping("/jobApplyChoice.do")
	public RedirectView jobApplyChoice(TBApplyDto dto) {
		
		int res = applyBiz.jobApplyChoiceUpdateBoard(dto);
		System.out.println("jobAPplyChoiceUpdateBoard 결과 값"+res);
		
		RedirectView reView = new RedirectView("/main_jobDetail.do?jobSeq="+dto.getApplySeq());
		
		return reView;
	}
	
	@RequestMapping("/jobGiveReward.do")
	public RedirectView jobApplyReward(int jobSeq, int jobReward, String applyWoker, String applyOwner) {
		
		TBUserDto dto = new TBUserDto();
		dto.setUserCoin(jobReward);
		dto.setUserId(applyWoker);
		// 일한 사람 돈주기 dto
		
		TBUserDto writer = new TBUserDto();
		writer.setUserId(applyOwner);
		writer.setUserCoin(jobReward);
		// 줄사람 돈 뺐기
		
		System.out.println("applyOwner : "+writer.getUserId()+"// jobReward : "+writer.getUserCoin());
		
		applyBiz.jobApplyGiveReward(jobSeq, dto, writer);
		
		RedirectView reView = new RedirectView("/main_jobDetail.do?jobSeq="+jobSeq);
		
		return reView;
	}
}
