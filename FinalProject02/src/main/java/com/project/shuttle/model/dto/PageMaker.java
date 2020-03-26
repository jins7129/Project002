package com.project.shuttle.model.dto;

public class PageMaker {
	    
	    private Criteria cri;
	    private int totalCount;
	    private int startPage;
	    private int endPage;
	    private boolean prev;
	    private boolean next;
	    private int displayPageNum = 5;
	    
	    private int tempEndPage;
	    
	    public Criteria getCri() {
	        return cri;
	    }
	    public void setCri(Criteria cri) {
	        this.cri = cri;
	    }
	    public int getTotalCount() {
	        return totalCount;
	    }
	    public void setTotalCount(int totalCount) {
	        this.totalCount = totalCount;
	        calcData();
	    }
	    
	    private void calcData() {
	        
	        endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
	        // endPage(보여질 페이지에서의 페이징끝번호)
	        // = 버림(보고자 하는 페이지 번호 / 보여질 페이징번호 갯수 * 보여질페이징번호 갯수) 
	        startPage = (endPage - displayPageNum) + 1;
	        if(startPage <= 0) startPage = 1;
	        
	        tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPageCount()));
	        
	        if (endPage > tempEndPage) {
	            endPage = tempEndPage;
	        }
	        
	        prev = startPage == 1 ? false : true;
	        next = endPage * cri.getPageCount() < totalCount ? true : false;
	        
	        
//	        System.out.println("startPage : "+startPage);
//	        System.out.println("endPage : "+endPage);
//	        System.out.println("totalCount : "+totalCount);
//	        System.out.println("cri.getPageCount : "+cri.getPageCount());
//	        System.out.println("tempEndPage : "+tempEndPage);
//	        System.out.println(prev);
//	        System.out.println(next);
	        
	    }
	    
	    public int getStartPage() {
	        return startPage;
	    }
	    public void setStartPage(int startPage) {
	        this.startPage = startPage;
	    }
	    public int getEndPage() {
	        return endPage;
	    }
	    public void setEndPage(int endPage) {
	        this.endPage = endPage;
	    }
	    public boolean isPrev() {
	        return prev;
	    }
	    public void setPrev(boolean prev) {
	        this.prev = prev;
	    }
	    public boolean isNext() {
	        return next;
	    }
	    public void setNext(boolean next) {
	        this.next = next;
	    }
	    public int getDisplayPageNum() {
	        return displayPageNum;
	    }
	    public void setDisplayPageNum(int displayPageNum) {
	        this.displayPageNum = displayPageNum;
	    }
		public int getTempEndPage() {
			return tempEndPage;
		}
		public void setTempEndPage(int tempEndPage) {
			this.tempEndPage = tempEndPage;
		}
	 
	}


