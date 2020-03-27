package com.project.shuttle.model.biz;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.shuttle.model.dao.TBReportDao;
import com.project.shuttle.model.dto.TBReportDto;

@Service
public class TBReportBizImpl implements TBReportBiz{

	@Autowired
	private TBReportDao dao;
	
	@Override
	public int countReport() {
		return dao.countReport();
	}
	
	@Override
	public int countUserIdReport(Map<String, String> map) {
		return dao.countUserIdReport(map);
	}

	@Override
	public int countWriterReport(Map<String, String> map) {
		return dao.countWriterReport(map);
	}

	@Override
	public List<TBReportDto> selectPaging(Map<String, Integer> map) {
		return dao.selectPaging(map);
	}

	@Override
	public List<TBReportDto> selectUserIdPaging(Map<String, String> map) {
		return dao.selectUserIdPaging(map);
	}

	@Override
	public List<TBReportDto> selectWriterPaging(Map<String, String> map) {
		return dao.selectWriterPaging(map);
	}

	@Override
	public TBReportDto report_detail(int seq) {
		return dao.report_detail(seq);
	}

	@Override
	public int report_1st_done(int seq) {
		return dao.report_1st_done(seq);
	}

	@Override
	public int report_2nd_done(Map<String, String> map) {
		return dao.report_2nd_done(map);
	}

	@Override
	public int search_Repory_Day(String id) {
		return dao.search_Repory_Day(id);
	}

}
