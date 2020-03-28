package com.project.shuttle;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.shuttle.model.biz.Paging;
import com.project.shuttle.model.biz.TBReportBiz;
import com.project.shuttle.model.dto.TBReportDto;

@Controller
public class TBReportController {

	private static final Logger logger = LoggerFactory.getLogger(TBReportController.class);
	
	
	
	@Autowired
	private TBReportBiz biz;
	
	@RequestMapping(value = "/report_admin.do", method = RequestMethod.GET)
	public String report_admin(HttpSession session, Paging paging, Model model
		, @RequestParam(value="nowPage", required=false)String nowPage
		, @RequestParam(value="cntPerPage", required=false)String cntPerPage){
		
		logger.info("report_admin 시작");
		
		int total = biz.countReport();
		
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "1";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "1";
		}
		
		paging = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		map.put("start", paging.getStart());
		map.put("end", paging.getEnd());
		
		model.addAttribute("paging", paging);
		model.addAttribute("viewAll", biz.selectPaging(map));
		
		return "report_admin";
	}
	
	@RequestMapping(value = "/report_search_admin.do", method = RequestMethod.GET)
	public String report_search_admin(Paging paging, Model model
		, @RequestParam(value = "nowPage", required = false)String nowPage
		, @RequestParam(value = "cntPerPage", required = false)String cntPerPage
		, @RequestParam(value = "type", required = false)String type
		, @RequestParam(value = "search_content", required = false)String content){
	
		logger.info("report_search_admin 시작");

		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "1";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "1";
		}
		
		int total = 0;
		Map<String, String> map = new HashMap<String, String>();
		
		if(type == "userId" || type.equals("userId")) {
			map.put("content_1", content);
			map.put("content_2", "%"+content);
			map.put("content_3", content+"%");
			map.put("content_4", "%"+content+"%");
			
			total = biz.countUserIdReport(map);
			paging = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			model.addAttribute("paging", paging);
			map.put("start", Integer.toString(paging.getStart()));
			map.put("end", Integer.toString(paging.getEnd()));
			
			model.addAttribute("type",type);
			model.addAttribute("content",content);
			model.addAttribute("viewAll", biz.selectUserIdPaging(map));
		}else if(type == "reportWriter" || type.equals("reportWriter")) {
			map.put("content_1", content);
			map.put("content_2", "%"+content);
			map.put("content_3", content+"%");
			map.put("content_4", "%"+content+"%");
			
			total = biz.countWriterReport(map);
			paging = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			model.addAttribute("paging", paging);
			map.put("start", Integer.toString(paging.getStart()));
			map.put("end", Integer.toString(paging.getEnd()));
			
			model.addAttribute("type",type);
			model.addAttribute("content",content);
			model.addAttribute("viewAll", biz.selectWriterPaging(map));
		} else {
			logger.info("report_search_admin 실패");
		}
		return "report_admin";
	}
	
	@RequestMapping(value = "/report_detail.do", method = RequestMethod.GET)
	public String report_detail(Model model, int seq) {
		logger.info("detail start");
		model.addAttribute("dto",biz.report_detail(seq));
		return "report_detail";
	}
	
	@RequestMapping(value = "/report_done.do", method = RequestMethod.GET)
	public String report_done(Model model, int day, int seq, String id) {
		
		logger.info("report_done 시작");
		
		int res_1st = biz.report_1st_done(seq);
		
		if(res_1st > 0) {
			int reportday = biz.search_Repory_Day(id);
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("day", Integer.toString(day + reportday));
			map.put("id", id);
			
			int res_2nd = biz.report_2nd_done(map);
			
			if(res_2nd > 0) {
				return "redirect:report_admin.do";
			} else {
				// 실패했을때
				System.out.println("report_done 2번째 실패");
				return "redirect:report_admin.do";
			}
		} else {
			// 실패했을때
			System.out.println("report_done 1번째 실패");
			return "redirect:report_admin.do";
		}	
	}
}
