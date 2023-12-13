package com.bitstudy.app.domain;

import java.util.Date;


public class BoardDTO {
    private int boardId;
    private String boardWriter;//작성자 세션아이디값 받을 예정
    private String boardTitle; //제목
    private String boardContents; //내용
    private int boardPrice; // 상품가격
    private Date boardCreate; // 작성일
    private int boardHits; //조회수
    private String saleStatus; // 판매 상태 기본값 '판매중'
    private String boardFileName; //상품이미지 업로드
    private String boardFileDB; //상품이미지 DB담을 것

    public BoardDTO() {
    }

    public BoardDTO(String boardWriter, String boardTitle, String boardContents, int boardPrice, String saleStatus) {
        this.boardWriter = boardWriter;
        this.boardTitle = boardTitle;
        this.boardContents = boardContents;
        this.boardPrice = boardPrice;
        this.saleStatus = saleStatus;
    }

    public int getBoardId() {
        return boardId;
    }

    public void setBoardId(int boardId) {
        this.boardId = boardId;
    }

    public String getBoardWriter() {
        return boardWriter;
    }

    public void setBoardWriter(String boardWriter) {
        this.boardWriter = boardWriter;
    }

    public String getBoardTitle() {
        return boardTitle;
    }

    public void setBoardTitle(String boardTitle) {
        this.boardTitle = boardTitle;
    }

    public String getBoardContents() {
        return boardContents;
    }

    public void setBoardContents(String boardContents) {
        this.boardContents = boardContents;
    }

    public int getBoardPrice() {
        return boardPrice;
    }

    public void setBoardPrice(int boardPrice) {
        this.boardPrice = boardPrice;
    }

    public Date getBoardCreate() {
        return boardCreate;
    }

    public void setBoardCreate(Date boardCreate) {
        this.boardCreate = boardCreate;
    }

    public int getBoardHits() {
        return boardHits;
    }

    public void setBoardHits(int boardHits) {
        this.boardHits = boardHits;
    }

    public String getSaleStatus() {
        return saleStatus;
    }

    public void setSaleStatus(String saleStatus) {
        this.saleStatus = saleStatus;
    }

    public String getBoardFileName() {
        return boardFileName;
    }

    public void setBoardFileName(String boardFileName) {
        this.boardFileName = boardFileName;
    }

    public String getBoardFileDB() {
        return boardFileDB;
    }

    public void setBoardFileDB(String boardFileDB) {
        this.boardFileDB = boardFileDB;
    }

    @Override
    public String toString() {
        return "BoardDTO{" +
                "boardId=" + boardId +
                ", boardWriter='" + boardWriter + '\'' +
                ", boardTitle='" + boardTitle + '\'' +
                ", boardContents='" + boardContents + '\'' +
                ", boardPrice=" + boardPrice +
                ", boardCreate=" + boardCreate +
                ", boardHits=" + boardHits +
                ", saleStatus='" + saleStatus + '\'' +
                ", boardFileName='" + boardFileName + '\'' +
                ", boardFileDB='" + boardFileDB + '\'' +
                '}';
    }
}

