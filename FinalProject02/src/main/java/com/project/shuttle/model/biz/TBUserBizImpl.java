package com.project.shuttle.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.shuttle.model.dao.TBUserDao;
import com.project.shuttle.model.dto.TBJobDto;
import com.project.shuttle.model.dto.TBUserDto;



@Service
public class TBUserBizImpl implements TBUserBiz{
	
	@Autowired
	private TBUserDao userDao;


	@Override
	public TBUserDto login(TBUserDto dto) {
		return userDao.login(dto);
	}


	@Override
	public List<TBJobDto> getWrittenBoard(int pageNum, int pageCount, String userId) {
		
		int page = 0;
		int pageCountAfter = 0;

		pageCountAfter = pageNum*pageCount; 
		page = ((pageNum-1)*10)+1;
		
		System.out.println(pageCountAfter+"pageCountAfter//"+page+"page");
		return  userDao.getWrittenBoard(page, pageCountAfter, userId);
//		select *
//		from (SELECT *
//		        FROM (
//		            SELECT rownum rnum, id, title, content
//		            FROM page_table
//		            ) pagetable
//		        where rnum <= 10
//		    )
//		where rnum >= 1;
				// ((page-1)*10)+1
//		-- 2페이지
//		select *
//		from (SELECT *
//		        FROM (
//		            SELECT rownum rnum, id, title, content
//		            FROM page_table
//		            ) pagetable
//		        where rnum <= 20 30 40 50
//		    )
//		where rnum >= 11; 21 31 41
		
		
	}


	@Override
	public int countBoard(String id) {
		return userDao.countBoard(id);
	}


	@Override
	public int insertUser(TBUserDto dto) {
		// TODO Auto-generated method stub
		return userDao.insertUser(dto);
	}


	@Override
	public String idchk(String id) {
		return userDao.idchk(id);
	}


}
