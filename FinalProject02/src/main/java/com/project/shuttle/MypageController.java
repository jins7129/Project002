package com.project.shuttle;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MypageController {
	
	
	@RequestMapping("/mypage_main.do")
	public ModelAndView mypageMain(ModelAndView mav) {
		
		mav.setViewName("user_main_mypage");
		
		return mav;
	}

}
