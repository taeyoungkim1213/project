package com.bitstudy.app.domain;


public class ReviewPageDto {
    private int page; // 현재 페이지
    private int maxPage; // 전체 필요한 페이지 갯수
    private int startPage; // 현재 페이지 기준 시작 페이지 값
    private int endPage; // 현재 페이지 기준 마지막 페이지 값

    public ReviewPageDto() {
    }

    public ReviewPageDto(int page, int maxPage, int startPage, int endPage) {
        this.page = page;
        this.maxPage = maxPage;
        this.startPage = startPage;
        this.endPage = endPage;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getMaxPage() {
        return maxPage;
    }

    public void setMaxPage(int maxPage) {
        this.maxPage = maxPage;
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

    @Override
    public String toString() {
        return "ReviewPageDto{" +
                "page=" + page +
                ", maxPage=" + maxPage +
                ", startPage=" + startPage +
                ", endPage=" + endPage +
                '}';
    }
}
