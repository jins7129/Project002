package com.project.shuttle.model.biz;

import java.util.List;
import java.util.Map;

import com.project.shuttle.model.dto.TBReportDto;

public interface TBReportBiz {

	public int countReport();
	
	public int countUserIdReport(Map<String, String> map);
	
	public int countWriterReport(Map<String, String> map);
	
	public List<TBReportDto> selectPaging(Map<String, Integer> map);
	
	public List<TBReportDto> selectUserIdPaging(Map<String, String> map);
	
	public List<TBReportDto> selectWriterPaging(Map<String, String> map);

	public TBReportDto report_detail(int seq);
	
	public int report_1st_done(int seq);
	
	public int report_2nd_done(Map<String, String> map);
	
	public int search_Repory_Day(String id);
}
