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

import com.project.shuttle.model.biz.TBUserBiz;
import com.project.shuttle.model.dto.Criteria;
import com.project.shuttle.model.dto.PageMaker;
import com.project.shuttle.model.dto.TBJobDto;
import com.project.shuttle.model.dto.TBUserDto;

@Controller
public class MypageController {
	
	@Autowired
	private TBUserBiz userBiz ;
	
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
	
	@RequestMapping(value="/testBoard.do", method = RequestMethod.POST )
	@ResponseBody
	public Map<Object,Object> testBoard(HttpSession session, int pageNum){

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
		

		List<TBJobDto> list = userBiz.getWrittenBoard(userId);
		// 해당 아이디가 썼던 글을 불러옴(의뢰글)
		
		
//		map.put("test","dummy");
		map.put("list", list);	// 사용자가 작성했던 의뢰글(리스트) 맵에 넣어줌
		
		return map;	//값을 담고 있는 맵 객체 리턴
	}
	
	

}
