package com.project.shuttle.model.dto;

public class Criteria {
    
    private int page; // 현재 페이지 번호
    private int pageCount; // 페이지 당 보여줄 게시글 갯수
    
    public int getPageStart() {// 특정 페이지의 게시글 시작 번호, 게시글 시작 행 번호
        return (this.page-1)*pageCount;
    }
    
    public Criteria() {
    }
    
    public int getPage() {
        return page;
    }
    public void setPage(int page) {
        if(page <= 0) {
            this.page = 1;
        } else {
            this.page = page;
        }
    }
    public int getPageCount() {
        return pageCount;
    }
    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    
}


