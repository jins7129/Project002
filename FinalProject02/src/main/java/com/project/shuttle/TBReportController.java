package com.project.shuttle;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public String report_admin(Paging paging, Model model
		, @RequestParam(value="nowPage", required=false)String nowPage
		, @RequestParam(value="cntPerPage", required=false)String cntPerPage){
		
		logger.info("report_admin start");
		
		int total = biz.countReport();
		
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}
		
		paging = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		map.put("start", paging.getStart());
		map.put("end", paging.getEnd());
		
		model.addAttribute("paging", paging);
		model.addAttribute("viewAll", biz.selectPaging(map));

		return "report_admin";
	}
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String report_search_admin(Paging paging, Model model
		, @RequestParam(value = "nowPage", required = false)String nowPage
		, @RequestParam(value = "cntPerPage", required = false)String cntPerPage
		, @RequestParam(value = "type", required = false)String type
		, @RequestParam(value = "search", required = false)String search){
	
		logger.info("report_search_admin start");
		
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}
		
		int total = 0;
		Map<String, String> map = new HashMap<String, String>();
		
		if(type == "신고받은 사람") {
			total = biz.countUserIdReport(search);
			paging = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			model.addAttribute("paging", paging);
			map.put("start", Integer.toString(paging.getStart()));
			map.put("end", Integer.toString(paging.getEnd()));
			map.put("content", search);
			model.addAttribute("viewAll", biz.selectUserIdPaging(map));
			
		}else if(type == "신고 한 사람") {
			total = biz.countWriterReport(search);
			paging = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			model.addAttribute("paging", paging);
			map.put("start", Integer.toString(paging.getStart()));
			map.put("end", Integer.toString(paging.getEnd()));
			map.put("content", search);
			model.addAttribute("viewAll", biz.selectUserIdPaging(map));
		}
		return "report_admin";
	}
	
	@RequestMapping(value = "/report_detail.do", method = RequestMethod.GET)
	public String detail(Model model, int seq) {
		logger.info("detail start");
		
		model.addAttribute("dto",biz.detail(seq));
		return "report_detail";
	}
	
}
