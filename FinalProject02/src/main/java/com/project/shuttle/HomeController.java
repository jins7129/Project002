package com.project.shuttle;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.project.shuttle.model.biz.TBJobBiz;
import com.project.shuttle.model.biz.TBUserBiz;
import com.project.shuttle.model.dto.TBJobDto;
import com.project.shuttle.model.dto.TBUserDto;

@Controller
public class HomeController {

	@Autowired
	public JavaMailSender emailSender;

	@Autowired
	private TBUserBiz biz;

	@Autowired
	private TBJobBiz JobBiz;

	@RequestMapping("/")
	public ModelAndView ScheduleManagementRoot() {
		ModelAndView mav = new ModelAndView("redirect:main.do");
		return mav;
	}

	@RequestMapping(value = "/main.do")
	public ModelAndView Main(ModelAndView mav) {
		mav.setViewName("main");
		return mav;
	}

	@RequestMapping("/signUp.do")
	public ModelAndView SignUp(ModelAndView mav) {
		mav.setViewName("user_registration");
		return mav;
	}

	@RequestMapping(value = "/jusoPopup.do")
	public ModelAndView jusoPopup(ModelAndView mav) {
		mav.setViewName("jusoPopup");
		return mav;
	}

	@RequestMapping(value = "/logins.do", method = RequestMethod.POST)
	public void logins() {

	}

	// 로그아웃 기능
	@RequestMapping("/logout.do")
	public RedirectView logout(ModelAndView mav, HttpSession session) {
//		session.invalidate();
		// 세션에 존재하는 모든 정보 삭제
		session.removeAttribute("loginInfo");
		// 원하는 세션 정보만 삭제
		RedirectView review = new RedirectView("/main.do");
		// redirectView 타입이 있길래 써봄

		return review;
	}

	// 로그인 AJAX
	@RequestMapping(value = "/loginajax.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> loginAjax(HttpSession session, @RequestBody TBUserDto dto) {
		/*
		 * @RequestBody : request객체를 통해 넘어오는 데이터를 java 객체에 binding
		 * 
		 * @ResponseBody : java 객체를 response 객체에 binding해서 보내줌
		 */
		/*
		 * 1. 최초 json형태의 값이 들어오면 이를 jackson이 json형태로 변환해주고 이를 @RequestBody가 받아서 작업을 해줌
		 * 작업은 key:value중 key를 읽어서 해당 dto에 있는 setter를 찾아서 value를 setter해주는 것
		 * 
		 * 이 일련의 과정을 어노테이션만 쓰면 알아서 해줌
		 * 
		 * {"memberid":"김진성","memberpw":"1234"}
		 * 
		 * @RequestBody MemberDto dto dto에는 밑의 setter가 존재함 setMemberid(String id)
		 * setMemberpw(String pw)
		 * 
		 * dto.setMemberid("김진성"); dto.setMemberpw("1234");
		 */

		TBUserDto res = biz.login(dto);
		boolean check = false;
		if (res != null) {// 로그인 정보가 있다면
			session.setAttribute("loginInfo", res);
			System.out.println(res.getUserImgpath() + "imgPath");
			check = true;
		}
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("check", check);
		System.out.println(check + "check상태");
		return map;
	}

	// 이메일 인증기능
	@RequestMapping(value = "/sendMail.do", method = RequestMethod.POST)
	@ResponseBody
	public String sendMail(String to) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo("<" + to + ">");
		System.out.println("<" + to + ">");
		message.setTo(to);
		message.setSubject("Shuttle Email Verify");
		int[] ranV = new int[6];
		String verifyNum = "";
		for (int i = 0; i < ranV.length; i++) {
			ranV[i] = (int) (Math.random() * 9);
			verifyNum += ranV[i] + "";
		}
		message.setText("회원가입을 위한 이메일 인증 메일입니다.\n인증번호 : " + verifyNum);
		emailSender.send(message);

		return verifyNum;
	}

	// 회원가입 기능
	@RequestMapping(value = "/insert.do")
	public String insertBoard(String userId, String userId2, String userId3, String userId4, String pw, String name,
			String phone, String addr1, String addr2) {
		TBUserDto dto = new TBUserDto(userId, pw, name, phone, addr1 + " " + addr2, "1");

		if (biz.insertUser(dto) > 0) {
			return "redirect:main.do";
		} else {
			return "redirect:signUp.do";
		}
	}

	// 아이디 중복체크 기능
	@RequestMapping(value = "/idchk.do")
	@ResponseBody
	public Boolean idChk(String Email_id) {
		boolean chkRes;
		chkRes = false;
		try {
			if (biz.idchk(Email_id).equals(Email_id)) {
				chkRes = true;
			}
		} catch (Exception e) {
		}
		return chkRes;
	}

	// 이미지 에디터
	@RequestMapping(value = "/editor.do")
	public String toastTest() {
		return "main_imageEditor";
	}

	// 의뢰하기 폼으로 이동
	@RequestMapping(value = "/main_insert.do")
	public String main_boardinsert() {
		return "main_boardinsert";
	}

	// 의뢰하기 글 작성 기능
	@RequestMapping(value = "/main_insertRes.do")
	public String main_boardInsertRes(String userId, String jobTitle, int jobReward, Date jobStart, Date jobDone,
			String jobAddr, String editordata, String jobCategory) {
		TBJobDto dto = new TBJobDto(userId, jobTitle, editordata, jobReward, jobAddr, jobCategory, jobStart, jobDone);
		if (JobBiz.insert(dto) > 0) {
			return "redirect:main.do";
		} else {
			return "redirect:main_insert.do";
		}
	}

	// Job 게시판 전체출력(헤더-모아보기)
	@RequestMapping(value = "/main_jobList.do")
	public String jobList(Model model) {
		List<TBJobDto> list = new ArrayList<TBJobDto>();
		list = JobBiz.selectList();
		model.addAttribute("list", list);
		return "main_jobList";
	}

	// Job 게시판 내 글 클릭 시, 상세보기 (모아보기 - 글 클릭)
	@RequestMapping(value = "/main_jobDetail.do")
	public String jobDetail(Model model, int jobSeq) {
		JobBiz.addView(jobSeq);
		model.addAttribute("dto", JobBiz.selectOne(jobSeq));
		return "main_jobDetail";
	}

}
