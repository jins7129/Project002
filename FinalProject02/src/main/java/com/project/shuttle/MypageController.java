package com.project.shuttle;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.project.shuttle.model.biz.TBUserBiz;
import com.project.shuttle.model.dto.Criteria;
import com.project.shuttle.model.dto.PageMaker;
import com.project.shuttle.model.dto.TBJobDto;
import com.project.shuttle.model.dto.TBUserDto;

@Controller
public class MypageController {
	
	@Autowired
	private TBUserBiz userBiz ;
	
	@RequestMapping("/testss.do")
	public String testtest() {
		return "toastTestJinsung";
	}
	
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
		cri.setPageCount(10);	// 해당 페이지에서 보여줄 게시글의 갯수
		
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
		cri.setPageCount(10);	// 해당 페이지에서 보여줄 게시글의 갯수
		
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
		cri.setPageCount(10);	// 해당 페이지에서 보여줄 게시글의 갯수
		
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
		cri.setPageCount(10);	
		
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
		cri.setPageCount(10);	
		
		PageMaker pageMaker = new PageMaker();	
		pageMaker.setCri(cri);	
		pageMaker.setTotalCount(userBiz.countReviewBoard(userId));	

		List<TBJobDto> boardList = userBiz.getReviewBoard(cri.getPage(),cri.getPageCount(),userId);
		
		map.put("list", boardList);	
		map.put("pageMaker", pageMaker);
		
		return map;
	}

}
