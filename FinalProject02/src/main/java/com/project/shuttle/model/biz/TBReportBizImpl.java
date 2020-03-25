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
	public int countUserIdReport(String userId) {
		return dao.countUserIdReport(userId);
	}

	@Override
	public int countWriterReport(String writer) {
		return dao.countWriterReport(writer);
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
	public TBReportDto detail(int seq) {
		return dao.detail(seq);
	}

}
