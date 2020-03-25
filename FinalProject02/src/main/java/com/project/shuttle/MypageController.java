package com.project.shuttle;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.shuttle.model.biz.TBUserBiz;
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
	public Map<Object,Object> testBoard(HttpSession session){
		
		TBUserDto loginInfo = (TBUserDto) session.getAttribute("loginInfo");
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		TBJobDto list = userBiz.getWrittenBoard(loginInfo.getUserId());
		
		map.put("list", list);
		
		return map;
	}
	
	

}
