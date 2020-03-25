package com.project.shuttle.model.dao;

import java.util.List;
import java.util.Map;

import com.project.shuttle.model.dto.TBReportDto;

public interface TBReportDao {

	public int countReport();
	
	public int countUserIdReport(String userId);
	
	public int countWriterReport(String writer);
	
	public List<TBReportDto> selectPaging(Map<String, Integer> map);
	
	public List<TBReportDto> selectUserIdPaging(Map<String, String> map);
	
	public List<TBReportDto> selectWriterPaging(Map<String, String> map);

	public TBReportDto detail(int seq);








}
